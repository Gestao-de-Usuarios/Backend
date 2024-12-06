from flask import Flask, jsonify, request, redirect, url_for, session, send_from_directory
from flask_cors import CORS
from flask_dance.contrib.google import make_google_blueprint, google
from flask_dance.contrib.github import make_github_blueprint, github
from dotenv import load_dotenv
import os
import sqlite3
import random
import string
from envio_email import enviar_email
from middleware import requires_permissions, requires_permissions_or_view_only

load_dotenv()

app = Flask(__name__, static_folder='../Frontend/build', static_url_path='/')

# Configuração de CORS para permitir credenciais e especificar a origem do frontend
CORS(app, supports_credentials=True, origins=["http://localhost:3000"])

app.secret_key = os.urandom(24)

os.environ["OAUTHLIB_INSECURE_TRANSPORT"] = "1"
os.environ["OAUTHLIB_RELAX_TOKEN_SCOPE"] = "1"

#db = sqlite3.connect('BancoDeDados.db')
DATABASE = 'BancoDeDados.db'


#criação de uma rota para autenticar o usuário via google
google_bp = make_google_blueprint(
    client_id=os.getenv("CLIENT_ID_GOOGLE"),
    client_secret=os.getenv("CLIENT_SECRET_GOOGLE"),
    reprompt_consent=True,
    scope=["profile", "email"],
    redirect_to="authorized_google"
)
app.register_blueprint(google_bp, url_prefix="/login")


#criação de uma rota para autenticar o usuário via github
github_bp = make_github_blueprint(
    client_id=os.getenv("CLIENT_ID_GITHUB"),
    client_secret=os.getenv("CLIENT_SECRET_GITHUB"),
    redirect_to="authorized_github"
)
app.register_blueprint(github_bp, url_prefix="/login")




def get_connection():
    db = sqlite3.connect(DATABASE)
    db.row_factory = sqlite3.Row
    return db


def init_db():
    with app.app_context():
        db = get_connection()
        with app.open_resource('schema.sql', mode='r') as f:
            db.cursor().executescript(f.read())
        db.commit()


# Rota para servir o index.html
@app.route('/')
def serve():
    return send_from_directory(app.static_folder, 'index.html')

# Rota para servir outros arquivos estáticos (opcional)
@app.errorhandler(404)
def not_found(e):
    return send_from_directory(app.static_folder, 'index.html')


@app.route('/initdb')
def init_database():
    init_db()
    return 'Database initialized', 200


@app.route('/users', methods=['GET'])
@requires_permissions_or_view_only('admin')
# @requires_permissions('admin')
def get_users():
    try:
        db = get_connection()
        cursor = db.cursor()
        cursor.execute("SELECT id, email, nome, status, data_criacao, data_ultima_atualizacao FROM Usuarios")
        rows = cursor.fetchall()
        rows = [dict(row) for row in rows]
        
        return jsonify(rows)
    except sqlite3.Error as e:
        print(f"Erro na rota /users: {e}")
        return jsonify({'error': 'Erro interno do servidor.'}), 500
    finally:
        db.close()



@app.route('/users/<int:user_id>', methods=['GET'])
@requires_permissions('admin')
def get_user(user_id):
    try:
        db = get_connection()
        cursor = db.cursor()
        cursor.execute("SELECT * FROM Usuarios WHERE id=?", (user_id,))
        row = cursor.fetchone()
        if row:
            row = dict(row)
            return jsonify(row)
        else:
            return jsonify({'error': 'User not found'}), 404
    except sqlite3.Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        db.close()





##################################### LOGIN ##############################################

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()

    if not data.get('email') or not data.get('senha'):
        return jsonify({'error': 'Email e senha são obrigatórios'}), 400

    email = data.get('email')
    senha = data.get('senha')
    
    try:
        db = get_connection()
        cursor = db.cursor()

        cursor.execute("SELECT * FROM Usuarios WHERE email=?", (email,))
        user = cursor.fetchone()

        if user is None or senha != user['senha']:
            return jsonify({'error': 'Email ou senha inválidos'}), 400
        
        if user['status'] == 'bloqueado':
            return jsonify({'error': 'Usário bloqueado'}), 400

        session['user_id'] = user['id']
        session['email'] = user['email']
        session['tipo_usuario'] = user['tipo_usuario']

    
        return jsonify({
            'message': 'Login bem-sucedido',
            'tipo_usuario': user['tipo_usuario']
        }), 200

    except sqlite3.Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        db.close()

# Autenticação do usuário via Google
@app.route('/api/login/google')
def login_google():
    if google.authorized:
        return redirect(url_for('authorized_google'))
    return redirect(url_for('google.login'))

# Autenticação do usuário via GitHub
@app.route('/api/login/github')
def login_github():
    if github.authorized:
        return redirect(url_for('authorized_github'))
    return redirect(url_for('github.login'))

# Rota para obter o tipo de usuário
@app.route('/api/user-type', methods=['GET'])
def get_user_type():
    if 'tipo_usuario' in session:
        return jsonify({'tipo_usuario': session['tipo_usuario']}), 200
    else:
        return jsonify({'error': 'Usuário não autenticado'}), 401

# Lidando com a resposta da autenticação via Google
@app.route('/api/login/google/authorized')
def authorized_google():
    
    # Verifique se o usuário foi autenticado com sucesso
    if not google.authorized:
        print("Falha na autenticação do usuário via Google")
        return redirect(url_for('google.login'))

    response = google.get("/oauth2/v2/userinfo")
    if not response.ok:
        print("Erro ao obter informações do perfil do usuário")
        return 'Falha ao obter o perfil do usuário', 400
    
    user_info = response.json()
    email = user_info.get('email')
    nome = user_info.get('name', 'Usuário')
    print("Tentando login para o email:", email)

    try:
        db = get_connection()
        cursor = db.cursor()
        
        # Verifique se o usuário já existe
        cursor.execute("SELECT * FROM Usuarios WHERE email=?", (email,))
        user = cursor.fetchone()
        
        if user is None:
            # Cria o usuário se ele não existir
            print("Usuário não encontrado no banco de dados. Criando novo usuário.")
            cursor.execute("INSERT INTO Usuarios (email, nome, status, tipo_usuario) VALUES (?, ?, ?, ?)", (email, nome, 'ativo', 'comum'))
            db.commit()
            user_id = cursor.lastrowid
            print("Usuário criado com ID:", user_id)
        else:
            user_id = user['id']
            print("Usuário existente encontrado com ID:", user_id)
        
        # Configurar as informações de sessão
        session['user_id'] = user_id
        session['email'] = email
        session['tipo_usuario'] = user['tipo_usuario']
        print("Sessão iniciada para o usuário ID:", user_id)
        
        # Retornar uma resposta de sucesso
        return jsonify({
            'message': 'Login via Google bem-sucedido',
            'tipo_usuario': user['tipo_usuario']
        }), 200

    except sqlite3.Error as e:
        print("Erro ao manipular o banco de dados:", e)
        return jsonify({'error': str(e)}), 500
    
    finally:
        db.close()
    

# Lidando com a resposta da autenticação via GitHub
@app.route('/api/login/github/authorized')
def authorized_github():
    
    if not github.authorized:
        print("Falha na autenticação do usuário via GitHub")
        return redirect(url_for('github.login'))

    response = github.get("/user")
    if not response.ok:
        print("Erro ao obter informações do perfil do usuário")
        return 'Falha ao obter o perfil do usuário', 400
    
    user_info = response.json()
    email = user_info.get('email')
    nome = user_info.get('name', 'Usuário')
    print("Tentando login para o email:", email)
    
    try:
        db = get_connection()
        cursor = db.cursor()
        
        # Verifique se o usuário já existe
        cursor.execute("SELECT * FROM Usuarios WHERE email=?", (email,))
        user = cursor.fetchone()
        
        if user is None:
            # Cria o usuário se ele não existir
            print("Usuário não encontrado no banco de dados. Criando novo usuário.")
            cursor.execute("INSERT INTO Usuarios (email, nome, status, tipo_usuario) VALUES (?, ?, ?, ?)", (email, nome, 'ativo', 'comum'))
            db.commit()
            user_id = cursor.lastrowid
            print("Usuário criado com ID:", user_id)
        else:
            user_id = user['id']
            print("Usuário existente encontrado com ID:", user_id)
        
        # Configurar as informações de sessão
        session['user_id'] = user_id
        session['email'] = email
        session['tipo_usuario'] = user['tipo_usuario']
        print("Sessão iniciada para o usuário ID:", user_id)

        # Retornar uma resposta de sucesso
        return jsonify({
            'message': 'Login via GitHub bem-sucedido',
            'tipo_usuario': user['tipo_usuario']
        }), 200

    except sqlite3.Error as e:
        print("Erro ao manipular o banco de dados:", e)
        return jsonify({'error': str(e)}), 500
    
    finally:
        db.close()




#################################### CADASTRO ############################################

@app.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()

    # Verifica se os campos obrigatórios foram enviados
    if not data.get('email') or not data.get('senha') or not data.get('nome'):
        return jsonify({'error': 'Email, senha e nome são obrigatórios'}), 400

    email = data.get('email')
    senha = data.get('senha')
    nome = data.get('nome')
    tipo_usuario = data.get('tipo_usuario', 'comum')


    try:
        db = get_connection()
        cursor = db.cursor()

        cursor.execute("SELECT * FROM Usuarios WHERE email=?", (email,))
        if cursor.fetchone():
            return jsonify({'error': 'Email já está cadastrado!'}), 400

        cursor.execute("INSERT INTO Usuarios (email, senha, nome, tipo_usuario) VALUES (?, ?, ?, ?)", (email, senha, nome, tipo_usuario))
        db.commit()

        return jsonify({'message': 'Usuário criado com sucesso'}), 200

    except sqlite3.Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        db.close()




@app.route('/users/<int:user_id>/block', methods=['PUT'])
@requires_permissions('admin')
def block_user(user_id):
    try:
        db = get_connection()
        cursor = db.cursor()

        cursor.execute("UPDATE Usuarios SET status='bloqueado', data_ultima_atualizacao=CURRENT_TIMESTAMP WHERE id=?", (user_id,))
        db.commit()

        return jsonify({'message': 'Usuário bloqueado com sucesso'}), 200

    except sqlite3.Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        db.close()





# Ativação de um usuário (cmd): curl -X PUT http://127.0.0.1:5000/users/1/activate
@app.route('/users/<int:user_id>/activate', methods=['PUT'])
@requires_permissions('admin')
def activate_user(user_id):
    try:
        db = get_connection()
        cursor = db.cursor()

        cursor.execute("UPDATE Usuarios SET status='ativo', data_ultima_atualizacao=CURRENT_TIMESTAMP WHERE id=?", (user_id,))
        db.commit()

        return jsonify({'message': 'Usuário ativado com sucesso'}), 200

    except sqlite3.Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        db.close()



########################################### Forgot Password ##############################################

@app.route('/forgot-password', methods=['POST'])
def forgot_password():
    data = request.get_json()
    email = data.get('email')

    if not email:
        return jsonify({'error': 'Email obrigatório'}), 400

    try:
        db = get_connection()
        cursor = db.cursor()
        cursor.execute("SELECT * FROM Usuarios WHERE email=?", (email,))
        user = cursor.fetchone()

        if user is None:
            return jsonify({'message': 'Se este email estiver cadastrado, uma nova senha será enviada.'}), 200
        
        nova_senha = ''.join(random.choices(string.ascii_uppercase + string.digits, k=8))
        
        cursor.execute("UPDATE Usuarios SET senha=?, data_ultima_atualizacao=CURRENT_TIMESTAMP WHERE email=?", (nova_senha, email))
        db.commit()

        # Enviar email de restabelecimento de senha
        enviar_email(email, nova_senha)

        return jsonify({'message': 'Email de recuperação enviado com sucesso'}), 200
        
    except sqlite3.Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        db.close()


if __name__ == '__main__':
    app.run(debug=True)
