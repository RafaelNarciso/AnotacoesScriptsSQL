
#🗄️ Banco de Dados
CREATE DATABASE nome_banco;
DROP DATABASE nome_banco;
USE nome_banco;



#📋 Tabelas
CREATE TABLE tabela (
  id INT PRIMARY KEY,
  nome VARCHAR(100)
);



DROP TABLE tabela;
TRUNCATE TABLE tabela;



#✍️ inserção de dados
INSERT INTO tabela (coluna1, coluna2)
VALUES (valor1, valor2);



#🔍 Consulta de dados
SELECT * FROM tabela;
SELECT coluna1, coluna2 FROM tabela;



#🎯 Filtros
SELECT * FROM tabela WHERE coluna = valor;
SELECT * FROM tabela WHERE coluna > 10;
SELECT * FROM tabela WHERE coluna BETWEEN 10 AND 20;
SELECT * FROM tabela WHERE coluna IN (1, 2, 3);
SELECT * FROM tabela WHERE coluna LIKE '%texto%';



🔢 Ordenação e Limite
SELECT * FROM tabela ORDER BY coluna ASC;
SELECT * FROM tabela ORDER BY coluna DESC;
SELECT * FROM tabela LIMIT 10;



#🔄 Atualização de dados
UPDATE tabela
SET coluna = novo_valor
WHERE condicao;



#❌ Exclusão de dados
DELETE FROM tabela WHERE condicao;


#🔗 Relacionamentos (JOIN)
SELECT *
FROM tabela_a
INNER JOIN tabela_b ON tabela_a.id = tabela_b.id;
SELECT *
FROM tabela_a
LEFT JOIN tabela_b ON tabela_a.id = tabela_b.id;


#📊 Agregações
SELECT COUNT(*) FROM tabela;
SELECT SUM(coluna) FROM tabela;
SELECT AVG(coluna) FROM tabela;
SELECT MAX(coluna) FROM tabela;
SELECT MIN(coluna) FROM tabela;


#🧩 Agrupamento
SELECT coluna, COUNT(*)
FROM tabela
GROUP BY coluna
HAVING COUNT(*) > 1;

#🔑 Chaves
PRIMARY KEY
FOREIGN KEY REFERENCES outra_tabela(id)

#🔧 Alteração de Tabela
ALTER TABLE tabela ADD coluna VARCHAR(50);
ALTER TABLE tabela DROP coluna;
ALTER TABLE tabela MODIFY coluna INT;


#🔐 Índices
CREATE INDEX idx_nome ON tabela(coluna);
DROP INDEX idx_nome;


















