from flask import Flask, jsonify, request
import sqlite3
from flask_cors import CORS
import bcrypt
import base64


app = Flask(__name__)
CORS(app)  # Cors permite o front-end acessar os dados da API

db = sqlite3.connect('BancoDeDados.db')
DATABASE = 'BancoDeDados.db'


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


@app.route('/initdb')
def init_database():
    init_db()
    return 'Database initialized', 200


# # Get sem a visualização da senha do usuário
# @app.route('/users', methods=['GET'])
# def get_users():
#    try:
#        db = get_connection()
#        cursor = db.cursor()
#        cursor.execute("SELECT id, nome, email, status, data_criacao, data_ultima_atualizacao FROM Usuarios")  # Não retorna a senha
#        rows = cursor.fetchall()
#        rows = [dict(row) for row in rows]
#        return jsonify(rows)
#    except sqlite3.Error as e:
#        return jsonify({'error': str(e)}), 500
#    finally:
#        db.close()


# Get com a visualização da senha do usuário hasheada
@app.route('/users', methods=['GET'])
def get_users():
    try:
        db = get_connection()
        cursor = db.cursor()
        cursor.execute("SELECT * FROM Usuarios")
        rows = cursor.fetchall()
        rows = [dict(row) for row in rows]
        
        for row in rows:
            row['senha'] = base64.b64encode(row['senha']).decode('utf-8')  # Converte o hash da senha para string
        
        return jsonify(rows)
    except sqlite3.Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        db.close()


# Get sem a visualização da senha do usuário
@app.route('/users/<int:user_id>', methods=['GET'])
def get_user(user_id):
    try:
        db = get_connection()
        cursor = db.cursor()
        cursor.execute("SELECT id, email, nome, status FROM Usuarios WHERE id=?", (user_id,))  # Não retorna a senha
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



@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()

    # Verifica se os campos obrigatórios foram enviados
    if not data.get('email') or not data.get('senha'):
        return jsonify({'error': 'Email e senha são obrigatórios'}), 400

    email = data.get('email')
    senha = data.get('senha').encode('utf-8') # Converte a senha para bytes

    try:
        db = get_connection()
        cursor = db.cursor()

        # Verifica se o usuário existe no banco de dados
        cursor.execute("SELECT * FROM Usuarios WHERE email=?", (email,))
        user = cursor.fetchone()

        if user is None:
            return jsonify({'error': 'Email ou senha inválidos'}), 400

        
        if bcrypt.checkpw(senha, user['senha']):
            return jsonify({'message': 'Login bem-sucedido'}), 200
        else:
            return jsonify({'error': 'Email ou senha inválidos'}), 400

    except sqlite3.Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        db.close()


@app.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()

    # Verifica se os campos obrigatórios foram enviados
    if not data.get('email') or not data.get('senha') or not data.get('nome'):
        return jsonify({'error': 'Email, senha e nome são obrigatórios'}), 400

    email = data.get('email')
    senha = data.get('senha').encode('utf-8') # Converte a senha strings para bytes
    nome = data.get('nome')

    # Gerando o hash da senha
    hashed_senha = bcrypt.hashpw(senha, bcrypt.gensalt())

    try:
        db = get_connection()
        cursor = db.cursor()

        # Verifica se o usuário existe no banco de dados
        cursor.execute("SELECT * FROM Usuarios WHERE email=?", (email,))
        user = cursor.fetchone()

        if user is not None:
            return jsonify({'error': 'Email ja esta Cadastrado!'}), 400

        # Cria um novo usuário no banco de dados
        cursor.execute("INSERT INTO Usuarios (email, senha, nome) VALUES (?, ?, ?)", (email, hashed_senha, nome))
        db.commit()

        return jsonify({'message': 'Usário criado com sucesso'}), 200

    except sqlite3.Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        db.close()



@app.route('/users/<int:user_id>/block', methods=['PUT'])
def block_user(user_id):
    try:
        db = get_connection()
        cursor = db.cursor()

        cursor.execute("UPDATE Usuarios SET status='bloqueado' WHERE id=?", (user_id,))
        db.commit()

        return jsonify({'message': 'Usário bloqueado com sucesso'}), 200

    except sqlite3.Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        db.close()



# Ativação de um usuário: curl -X PUT http://127.0.0.1:5000/users/1/activate
@app.route('/users/<int:user_id>/activate', methods=['PUT'])
def activate_user(user_id):
    try:
        db = get_connection()
        cursor = db.cursor()

        # Atualiza o status do usuário para "ativo"
        cursor.execute("UPDATE Usuarios SET status='ativo' WHERE id=?", (user_id,))
        db.commit()

        return jsonify({'message': 'Usuário ativado com sucesso'}), 200

    except sqlite3.Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        db.close()




if __name__ == '__main__':
    app.run(debug=True)
