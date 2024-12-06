# middleware.py
from functools import wraps
from flask import jsonify, session
import logging

def requires_permissions(tipo_permitido):
    def decorator(f):
        @wraps(f)
        def wrapped(*args, **kwargs):
            logging.debug("Verificando permissões do usuário.")
            if 'user_id' not in session:
                logging.debug("Usuário não autenticado.")
                return jsonify({'error': 'Usuário não autenticado'}), 403
            user_type = session.get('tipo_usuario', None)
            logging.debug(f"Tipo de usuário na sessão: {user_type}")
            if user_type != tipo_permitido:
                logging.debug(f"Acesso negado para tipo de usuário: {user_type}")
                return jsonify({'error': 'Acesso negado'}), 403
            return f(*args, **kwargs)
        return wrapped
    return decorator

def requires_permissions_or_view_only(permissoes_permitidas):
    def decorator(f):
        @wraps(f)
        def wrapped(*args, **kwargs):
            logging.debug("Verificando permissões ou visualização para tipo de usuário.")
            user_type = session.get('tipo_usuario', None)
            logging.debug(f"Tipo de usuário na sessão: {user_type}")
            if not user_type:
                logging.debug("Usuário não autenticado.")
                return jsonify({'error': 'Usuário não autenticado'}), 403
            if user_type != permissoes_permitidas and user_type != 'comum':
                logging.debug(f"Acesso negado para tipo de usuário: {user_type}")
                return jsonify({'error': 'Acesso negado'}), 403
            return f(*args, **kwargs)
        return wrapped
    return decorator
