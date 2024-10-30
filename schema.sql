-- Criação da tabela de usuários
CREATE TABLE IF NOT EXISTS Usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,                                -- ID único e auto-incrementado
    email VARCHAR(255) NULL,                                             -- E-mail do usuário como login
    senha VARCHAR(255) NULL,                                             -- Senha do usuário
    nome VARCHAR(255) NOT NULL,                                          -- Nome real do usuário
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,                     -- Data de criação do usuário
    data_ultima_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP,          -- Data de última atualização do usuário
    status TEXT CHECK(status in ('ativo', 'bloqueado')) DEFAULT 'ativo', -- Status do usuário (ativo ou bloqueado)
    UNIQUE (email)                                                       -- O campo login deve ser único
);


