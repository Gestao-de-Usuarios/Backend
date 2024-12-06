from functools import wraps
from flask import Flask, jsonify, request
import jwt
import datetime
import os

app = Flask(__name__)

JWT_SECRET_KEY = os.getenv("JWT_SECRET_KEY", "secret_jwt_key")

def login_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        auth_header = request.headers.get('Authorization')
        if not auth_header or not auth_header.startswith('Bearer '):
            return jsonify({'error': 'Token não fornecido'}), 401

        token = auth_header.split(' ')[1]
        try:
            decoded = jwt.decode(token, JWT_SECRET_KEY, algorithms=['HS256'])
        except jwt.ExpiredSignatureError:
            return jsonify({'error': 'Token expirado'}), 401
        except jwt.InvalidTokenError:
            return jsonify({'error': 'Token inválido'}), 401

        # Armazena as informações do usuário no objeto request
        request.user = decoded
        return f(*args, **kwargs)
    return decorated

def admin_required(f):
    @wraps(f)
    @login_required
    def decorated(*args, **kwargs):
        if request.user.get('tipo_usuario') != 'admin':
            return jsonify({'error': 'Acesso não autorizado'}), 403
        return f(*args, **kwargs)
    return decorated
