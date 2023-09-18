-- Uma floricultura vende flores e plantas a seus clientes. Todas as vendas acontecem de maneira online. Cada planta possui uma ou várias categorias para facilitar a busca pelo cliente. Quando o cliente termina de escolher as plantas ele então as adiciona a um pedido, informa a quantidade de cada planta e segue para o pagamento. A forma de pagamento deve ser selecionada pelo cliente. 

CREATE DATABASE IF NOT EXISTS floricultura;

USE floricultura;

CREATE TABLE IF NOT EXISTS clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NULL,
    cpf VARCHAR(11) NOT NULL,
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(10) NOT NULL,
    data_nascimento DATE NOT NULL,
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS enderecos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(150) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    clientes_id INT NOT NULL,
    FOREIGN KEY (clientes_id) REFERENCES clientes(id)
);

-- Na table acima, a linha do foreign key representa que o id do cliente é a chave estrangeira da tabela enderecos. Ou seja, o id do cliente é a chave primária da tabela clientes e a chave estrangeira da tabela enderecos. É necessário para que o banco de dados saiba que o endereço pertence a um cliente.

CREATE TABLE IF NOT EXISTS plantas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    especie VARCHAR(100) NOT NULL,
    descricao TEXT NULL,
    valor DECIMAL(10, 2) NOT NULL DEFAULT(0)
);

CREATE TABLE IF NOT EXISTS categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS categorias_plantas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    categorias_id INT NOT NULL,
    plantas_id INT NOT NULL,
    FOREIGN KEY (categorias_id) REFERENCES categorias(id),
    FOREIGN KEY (plantas_id) REFERENCES plantas(id)
);

CREATE TABLE IF NOT EXISTS pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    clientes_id INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL DEFAULT(0),
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (clientes_id) REFERENCES clientes(id)
);

CREATE TABLE IF NOT EXISTS itens_pedido (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    plantas_id INT NOT NULL,
    pedidos_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL DEFAULT 0,
    valor_total DECIMAL(10, 2) NOT NULL DEFAULT 0,
    FOREIGN KEY (plantas_id) REFERENCES plantas(id),
    FOREIGN KEY (pedidos_id) REFERENCES pedidos(id)
);

CREATE TABLE IF NOT EXISTS formas_pagamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE pagamentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedidos_id INT NOT NULL,
    formas_pagamento_id INT NOT NULL,
    valor DECIMAL(10, 2) NOT NULL DEFAULT 0,
    FOREIGN KEY (pedidos_id) REFERENCES pedidos(id),
    FOREIGN KEY (formas_pagamento_id) REFERENCES formas_pagamento(id)   
);