
# Projeto Backend Flask

## 📋 Descrição
Este é o backend de uma aplicação de gerenciamento de usuários construída com Flask. A aplicação permite que usuários se cadastrem, façam login, visualizem usuários cadastrados, bloqueiem e ativem usuários. As senhas são armazenadas de forma segura utilizando bcrypt para hashing.

## 🚀 Funcionalidades
- **Cadastro de Usuários**: Permite que novos usuários se cadastrem fornecendo nome, email e senha.
- **Login de Usuários**: Autenticação de usuários existentes com email e senha.
- **Listagem de Usuários**: Recupera todos os usuários cadastrados, com ou sem visualização das senhas hasheadas.
- **Bloqueio de Usuários**: Permite bloquear um usuário, impedindo que ele faça login.
- **Ativação de Usuários**: Permite ativar um usuário previamente bloqueado.
- **Inicialização do Banco de Dados**: Endpoint para criar a estrutura do banco de dados a partir de um arquivo de esquema.

## 📦 Tecnologias Utilizadas
- Python 3.x
- Flask
- Flask-Cors
- SQLite3
- bcrypt

## 📑 Estrutura do Projeto

```bash
backend/
├── BancoDeDados.db
├── schema.sql
├── app.py
├── requirements.txt
└── README.md
```

## 🛠️ Instalação e Configuração

### 1. Clone o Repositório
```bash
git clone https://github.com/seu-usuario/seu-repositorio-backend.git
cd seu-repositorio-backend
```

### 2. Crie um Ambiente Virtual (Recomendado)
```bash
python -m venv venv
```

### 3. Ative o Ambiente Virtual
No Windows:
```bash
venv\Scripts ctivate
```
No macOS/Linux:
```bash
source venv/bin/activate
```

### 4. Instale as Dependências
```bash
pip install -r requirements.txt
```

### 5. Configure o Banco de Dados
Crie o Arquivo de Esquema (`schema.sql`):
```sql
CREATE TABLE IF NOT EXISTS Usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT UNIQUE NOT NULL,
    senha BLOB NOT NULL,
    nome TEXT NOT NULL,
    status TEXT DEFAULT 'ativo',
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

Inicialize o Banco de Dados:
```bash
python app.py
```

Acesse o endpoint `/initdb` para inicializar o banco de dados:
```bash
curl http://127.0.0.1:5000/initdb
```

### 6. Rodando o Servidor Flask
```bash
python app.py
```

O servidor estará disponível em http://127.0.0.1:5000/ por padrão.

## 🔧 Endpoints da API

1. **Inicializar Banco de Dados**
   - **URL**: `/initdb`
   - **Método**: `GET`
   - **Descrição**: Inicializa o banco de dados criando as tabelas necessárias.
   - **Resposta**: `"Database initialized"`

2. **Listar Todos os Usuários (com Senha Hasheada)**
   - **URL**: `/users`
   - **Método**: `GET`
   - **Descrição**: Retorna todos os usuários cadastrados com as senhas hasheadas em base64.

3. **Obter Detalhes de um Usuário Específico**
   - **URL**: `/users/<int:user_id>`
   - **Método**: `GET`
   - **Descrição**: Retorna os detalhes de um usuário específico sem a senha.

4. **Login de Usuário**
   - **URL**: `/login`
   - **Método**: `POST`
   - **Descrição**: Autentica um usuário com email e senha.

5. **Cadastro de Usuário**
   - **URL**: `/signup`
   - **Método**: `POST`
   - **Descrição**: Cadastra um novo usuário com nome, email e senha.

6. **Bloquear Usuário**
   - **URL**: `/users/<int:user_id>/block`
   - **Método**: `PUT`
   - **Descrição**: Bloqueia um usuário específico.

7. **Ativar Usuário**
   - **URL**: `/users/<int:user_id>/activate`
   - **Método**: `PUT`
   - **Descrição**: Ativa um usuário previamente bloqueado.

## 🔒 Segurança
- **Hashing de Senhas**: As senhas dos usuários são armazenadas de forma segura utilizando bcrypt.
- **CORS**: Configurado com Flask-Cors para permitir que o frontend acesse a API.

## 📄 Licença
Este projeto está licenciado sob a Licença MIT.

## 🤝 Contribuições
Contribuições são bem-vindas!

Fork o Repositório:
- Crie uma Branch (`git checkout -b feature/nome-da-feature`)
- Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
- Push para a Branch (`git push origin feature/nome-da-feature`)
- Abra um Pull Request

## 📞 Contato
Para dúvidas ou sugestões, entre em contato através do email seu-email@example.com.
