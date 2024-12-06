-- Criação da tabela de usuários
CREATE TABLE IF NOT EXISTS Usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,                                           -- ID único e auto-incrementado
    email VARCHAR(255) NULL,                                                        -- E-mail do usuário como login
    senha VARCHAR(255) NULL,                                                        -- Senha do usuário
    nome VARCHAR(255) NOT NULL,                                                     -- Nome real do usuário
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,                                -- Data de criação do usuário
    data_ultima_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP,                     -- Data de última atualização do usuário
    tipo_usuario TEXT CHECK(tipo_usuario in ('admin', 'comum')) DEFAULT 'comum',    -- Tipo de usuário (admin ou comum)
    status TEXT CHECK(status in ('ativo', 'bloqueado')) DEFAULT 'ativo',            -- Status do usuário (ativo ou bloqueado)
    UNIQUE (email)                                                                  -- O campo login deve ser único
);


INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('admin@adm.com', 'admin', 'admin', 'ativo', 'admin' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('bob@example.com', 'senha123', 'Bob Silva', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('carla@example.com', 'senha123', 'Carla Oliveira', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('daniel@example.com', 'senha123', 'Daniel Souza', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('erika@example.com', 'senha123', 'Erika Mendes', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('felipe@example.com', 'senha123', 'Felipe Ferreira', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('gabriela@example.com', 'senha123', 'Gabriela Lima', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('henrique@example.com', 'senha123', 'Henrique Costa', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('isabela@example.com', 'senha123', 'Isabela Martins', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('joao@example.com', 'senha123', 'João Pereira', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('karina@example.com', 'senha123', 'Karina Silva', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('lucas@example.com', 'senha123', 'Lucas Monteiro', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('mariana@example.com', 'senha123', 'Mariana Rocha', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('nicolas@example.com', 'senha123', 'Nicolas Andrade', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('olivia@example.com', 'senha123', 'Olivia Ribeiro', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('paulo@example.com', 'senha123', 'Paulo Almeida', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('quenia@example.com', 'senha123', 'Quênia Fernandes', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('rafael@example.com', 'senha123', 'Rafael Cardoso', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('sabrina@example.com', 'senha123', 'Sabrina Teixeira', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('thiago@example.com', 'senha123', 'Thiago Correia', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('ursula@example.com', 'senha123', 'Úrsula Santana', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('victor@example.com', 'senha123', 'Victor Mendes', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('wagner@example.com', 'senha123', 'Wagner Dias', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('xavier@example.com', 'senha123', 'Xavier Barbosa', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('yara@example.com', 'senha123', 'Yara Mendes', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('zeca@example.com', 'senha123', 'Zeca Borges', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('ana@example.com', 'senha123', 'Ana Clara', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('bruno@example.com', 'senha123', 'Bruno Marques', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('camila@example.com', 'senha123', 'Camila Nunes', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('diego@example.com', 'senha123', 'Diego Ramos', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('elena@example.com', 'senha123', 'Elena Machado', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('fabio@example.com', 'senha123', 'Fábio Souza', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('giovana@example.com', 'senha123', 'Giovana Batista', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('heitor@example.com', 'senha123', 'Heitor Silveira', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('ines@example.com', 'senha123', 'Inês Araújo', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('jessica@example.com', 'senha123', 'Jéssica Viana', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('kevin@example.com', 'senha123', 'Kevin Moreira', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('laura@example.com', 'senha123', 'Laura Farias', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('marcos@example.com', 'senha123', 'Marcos Paiva', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('nathalia@example.com', 'senha123', 'Nathália Cunha', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('otavio@example.com', 'senha123', 'Otávio Barreto', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('patricia@example.com', 'senha123', 'Patrícia Costa', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('rodrigo@example.com', 'senha123', 'Rodrigo Amorim', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('samara@example.com', 'senha123', 'Samara Pires', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('tiago@example.com', 'senha123', 'Tiago Rocha', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('valeria@example.com', 'senha123', 'Valéria Gomes', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('william@example.com', 'senha123', 'William Tavares', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('adriana@example.com', 'senha123', 'Adriana Pereira', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('bernardo@example.com', 'senha123', 'Bernardo Silva', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('clara@example.com', 'senha123', 'Clara Santos', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('daniela@example.com', 'senha123', 'Daniela Fernandes', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('eduardo@example.com', 'senha123', 'Eduardo Ribeiro', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('fernanda@example.com', 'senha123', 'Fernanda Costa', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('gustavo@example.com', 'senha123', 'Gustavo Almeida', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('helena@example.com', 'senha123', 'Helena Cardoso', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('igor@example.com', 'senha123', 'Igor Carvalho', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('julia@example.com', 'senha123', 'Júlia Martins', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('kaique@example.com', 'senha123', 'Kaique Andrade', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('leticia@example.com', 'senha123', 'Letícia Barros', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('mateus@example.com', 'senha123', 'Mateus Campos', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('nina@example.com', 'senha123', 'Nina Vilela', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('oliver@example.com', 'senha123', 'Oliver Mendes', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('priscila@example.com', 'senha123', 'Priscila Gomes', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('renato@example.com', 'senha123', 'Renato Vieira', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('sandra@example.com', 'senha123', 'Sandra Figueira', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('tadeu@example.com', 'senha123', 'Tadeu Nascimento', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('vitoria@example.com', 'senha123', 'Vitória Luz', 'ativo', 'comum' );
INSERT INTO Usuarios (email, senha, nome, status, tipo_usuario) VALUES ('yasmin@example.com', 'senha123', 'Yasmin Torres', 'ativo', 'comum' );


-- Criação da tabela de produtos
CREATE TABLE IF NOT EXISTS Produtos
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,                                           -- ID único e auto-incrementado
    nome VARCHAR (255) NOT NULL,                                                     -- Nome do produto
    preco DECIMAL (10, 2) NOT NULL,                                                  -- Preço do produto
    categoria VARCHAR (100) NOT NULL,                                               -- Categoria do produto
    descricao TEXT,                                                                 -- Descrição do produto
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,                                -- Data de criação do produto
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP,                            -- Data de última atualização do produto
    estoque INTEGER DEFAULT 0,                                                      -- Quantidade em estoque
    UNIQUE (nome)                                                                   -- O nome do produto deve ser único
);


-- Inserção de produtos na tabela Produtos
INSERT INTO Produtos (nome, preco, categoria, descricao, estoque) VALUES
    ('Smartphone XYZ', 2999.99, 'Eletrônicos', 'Smartphone com 128GB de armazenamento e câmera de 48MP.', 50),
    ('Notebook ABC', 5499.50, 'Eletrônicos', 'Notebook com processador Intel i7, 16GB RAM e SSD de 512GB.', 30),
    ('Camiseta Branca', 59.90, 'Vestuário', 'Camiseta branca de algodão, tamanho M.', 100),
    ('Jeans Azul', 149.90, 'Vestuário', 'Calça jeans azul escura, corte slim.', 80),
    ('Tênis Esportivo', 199.99, 'Calçados', 'Tênis esportivo confortável para corrida.', 60),
    ('Relógio Digital', 89.90, 'Acessórios', 'Relógio digital com múltiplas funções.', 40),
    ('Fone de Ouvido Bluetooth', 129.90, 'Eletrônicos', 'Fone de ouvido Bluetooth com cancelamento de ruído.', 70),
    ('Bolsa de Couro', 249.90, 'Acessórios', 'Bolsa de couro legítimo, tamanho médio.', 25),
    ('Livro "Introdução à Programação"', 79.90, 'Livros', 'Livro didático sobre conceitos básicos de programação.', 120),
    ('Cadeira Ergonômica', 399.90, 'Móveis', 'Cadeira ergonômica ajustável para escritório.', 15);
