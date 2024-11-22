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


INSERT INTO Usuarios (email, senha, nome, status) VALUES ('alice@example.com', 'senha123', 'Alice Santos', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('bob@example.com', 'senha123', 'Bob Silva', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('carla@example.com', 'senha123', 'Carla Oliveira', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('daniel@example.com', 'senha123', 'Daniel Souza', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('erika@example.com', 'senha123', 'Erika Mendes', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('felipe@example.com', 'senha123', 'Felipe Ferreira', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('gabriela@example.com', 'senha123', 'Gabriela Lima', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('henrique@example.com', 'senha123', 'Henrique Costa', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('isabela@example.com', 'senha123', 'Isabela Martins', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('joao@example.com', 'senha123', 'João Pereira', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('karina@example.com', 'senha123', 'Karina Silva', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('lucas@example.com', 'senha123', 'Lucas Monteiro', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('mariana@example.com', 'senha123', 'Mariana Rocha', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('nicolas@example.com', 'senha123', 'Nicolas Andrade', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('olivia@example.com', 'senha123', 'Olivia Ribeiro', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('paulo@example.com', 'senha123', 'Paulo Almeida', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('quenia@example.com', 'senha123', 'Quênia Fernandes', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('rafael@example.com', 'senha123', 'Rafael Cardoso', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('sabrina@example.com', 'senha123', 'Sabrina Teixeira', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('thiago@example.com', 'senha123', 'Thiago Correia', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('ursula@example.com', 'senha123', 'Úrsula Santana', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('victor@example.com', 'senha123', 'Victor Mendes', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('wagner@example.com', 'senha123', 'Wagner Dias', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('xavier@example.com', 'senha123', 'Xavier Barbosa', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('yara@example.com', 'senha123', 'Yara Mendes', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('zeca@example.com', 'senha123', 'Zeca Borges', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('ana@example.com', 'senha123', 'Ana Clara', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('bruno@example.com', 'senha123', 'Bruno Marques', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('camila@example.com', 'senha123', 'Camila Nunes', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('diego@example.com', 'senha123', 'Diego Ramos', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('elena@example.com', 'senha123', 'Elena Machado', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('fabio@example.com', 'senha123', 'Fábio Souza', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('giovana@example.com', 'senha123', 'Giovana Batista', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('heitor@example.com', 'senha123', 'Heitor Silveira', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('ines@example.com', 'senha123', 'Inês Araújo', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('jessica@example.com', 'senha123', 'Jéssica Viana', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('kevin@example.com', 'senha123', 'Kevin Moreira', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('laura@example.com', 'senha123', 'Laura Farias', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('marcos@example.com', 'senha123', 'Marcos Paiva', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('nathalia@example.com', 'senha123', 'Nathália Cunha', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('otavio@example.com', 'senha123', 'Otávio Barreto', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('patricia@example.com', 'senha123', 'Patrícia Costa', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('rodrigo@example.com', 'senha123', 'Rodrigo Amorim', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('samara@example.com', 'senha123', 'Samara Pires', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('tiago@example.com', 'senha123', 'Tiago Rocha', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('valeria@example.com', 'senha123', 'Valéria Gomes', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('william@example.com', 'senha123', 'William Tavares', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('adriana@example.com', 'senha123', 'Adriana Pereira', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('bernardo@example.com', 'senha123', 'Bernardo Silva', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('clara@example.com', 'senha123', 'Clara Santos', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('daniela@example.com', 'senha123', 'Daniela Fernandes', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('eduardo@example.com', 'senha123', 'Eduardo Ribeiro', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('fernanda@example.com', 'senha123', 'Fernanda Costa', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('gustavo@example.com', 'senha123', 'Gustavo Almeida', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('helena@example.com', 'senha123', 'Helena Cardoso', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('igor@example.com', 'senha123', 'Igor Carvalho', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('julia@example.com', 'senha123', 'Júlia Martins', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('kaique@example.com', 'senha123', 'Kaique Andrade', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('leticia@example.com', 'senha123', 'Letícia Barros', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('mateus@example.com', 'senha123', 'Mateus Campos', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('nina@example.com', 'senha123', 'Nina Vilela', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('oliver@example.com', 'senha123', 'Oliver Mendes', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('priscila@example.com', 'senha123', 'Priscila Gomes', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('renato@example.com', 'senha123', 'Renato Vieira', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('sandra@example.com', 'senha123', 'Sandra Figueira', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('tadeu@example.com', 'senha123', 'Tadeu Nascimento', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('vitoria@example.com', 'senha123', 'Vitória Luz', 'ativo');
INSERT INTO Usuarios (email, senha, nome, status) VALUES ('yasmin@example.com', 'senha123', 'Yasmin Torres', 'ativo');
