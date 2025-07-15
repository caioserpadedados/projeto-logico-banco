-- Criação das tabelas principais

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    tipo_cliente VARCHAR(10), -- PJ ou PF
    cpf_cnpj VARCHAR(20)
);

CREATE TABLE Produto (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT
);

CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Pagamento (
    id_pagamento INT PRIMARY KEY,
    id_pedido INT,
    forma_pagamento VARCHAR(50),
    status_pagamento VARCHAR(20),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

CREATE TABLE Entrega (
    id_entrega INT PRIMARY KEY,
    id_pedido INT,
    status_entrega VARCHAR(50),
    codigo_rastreio VARCHAR(50),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

CREATE TABLE Pedido_Produto (
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

-- Inserção de dados fictícios

INSERT INTO Cliente VALUES (1, 'João Silva', 'PF', '123.456.789-00');
INSERT INTO Cliente VALUES (2, 'Empresa XPTO', 'PJ', '12.345.678/0001-99');

INSERT INTO Produto VALUES (1, 'Mouse Gamer', 150.00, 30);
INSERT INTO Produto VALUES (2, 'Teclado Mecânico', 300.00, 15);

INSERT INTO Pedido VALUES (1, 1, '2025-07-15', 450.00);
INSERT INTO Pedido VALUES (2, 2, '2025-07-14', 300.00);

INSERT INTO Pagamento VALUES (1, 1, 'Cartão de Crédito', 'Pago');
INSERT INTO Pagamento VALUES (2, 2, 'Boleto', 'Aguardando');

INSERT INTO Entrega VALUES (1, 1, 'Em trânsito', 'BR123456789XYZ');
INSERT INTO Entrega VALUES (2, 2, 'Processando', NULL);

INSERT INTO Pedido_Produto VALUES (1, 1, 2, 150.00);
INSERT INTO Pedido_Produto VALUES (1, 2, 1, 300.00);
INSERT INTO Pedido_Produto VALUES (2, 2, 1, 300.00); 

-- Recuperações simples com SELECT Statement
SELECT * FROM Cliente;

-- Filtros com WHERE Statement
SELECT * FROM Produto WHERE preco > 200;

-- Criação de expressões para atributos derivados
SELECT nome, preco, estoque, (preco * estoque) AS valor_total_estoque FROM Produto;

-- Ordenações dos dados com ORDER BY
SELECT * FROM Cliente ORDER BY nome;

-- Agrupamentos com HAVING
SELECT id_cliente, COUNT(*) AS total_pedidos
FROM Pedido
GROUP BY id_cliente
HAVING COUNT(*) > 1;

-- Junções entre tabelas
SELECT p.id_pedido, c.nome AS cliente, pr.nome AS produto, pp.quantidade, pp.preco_unitario
FROM Pedido p
JOIN Cliente c ON p.id_cliente = c.id_cliente
JOIN Pedido_Produto pp ON p.id_pedido = pp.id_pedido
JOIN Produto pr ON pp.id_produto = pr.id_produto;

