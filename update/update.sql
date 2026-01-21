/* ============================================================
   UPDATE – EXEMPLOS CONSOLIDADOS (MySQL)
   ============================================================ */

START TRANSACTION;
-- UPDATE aqui
ROLLBACK; -- ou COMMIT;



-- 1) UPDATE simples com WHERE (básico)
UPDATE cliente
SET email = 'JORGE@IG.COM.BR'
WHERE nome = 'JORGE';

-- 2) UPDATE por ID (chave primária)
UPDATE produto
SET valor = 110.00
WHERE idproduto = 4;

-- 3) Atualizar múltiplas colunas
UPDATE cliente
SET email = 'ana@gmail.com',
    telefone = '11999999999'
WHERE nome = 'ANA';

-- 4) UPDATE usando LIKE
UPDATE cliente
SET endereco = 'RIO DE JANEIRO - RJ'
WHERE endereco LIKE '%RIO%';

-- 5) UPDATE com condição OR
UPDATE cliente
SET ativo = 0
WHERE sexo = 'M'
   OR endereco LIKE '%MG';

-- 6) UPDATE com condição AND
UPDATE cliente
SET ativo = 1
WHERE sexo = 'F'
  AND endereco LIKE '%RJ';

-- 7) UPDATE atribuindo NULL
UPDATE cliente
SET email = NULL
WHERE nome = 'CARLA';

-- 8) UPDATE com cálculo
UPDATE produto
SET valor = valor * 1.10
WHERE categoria = 'ELETRONICOS';

-- 9) UPDATE com arredondamento
UPDATE produto
SET valor = ROUND(valor * 1.05, 2)
WHERE categoria = 'LIVROS';

-- 10) UPDATE com IF / CASE
UPDATE cliente
SET ativo =
    CASE
        WHEN sexo = 'F' THEN 1
        ELSE 0
    END;

-- 11) UPDATE usando subquery (WHERE IN)
UPDATE produto
SET valor = valor * 0.90
WHERE idproduto IN (
    SELECT idproduto
    FROM estoque
    WHERE quantidade < 10
);

-- 12) UPDATE usando subquery escalar
UPDATE produto
SET valor = (
    SELECT AVG(valor)
    FROM produto
)
WHERE categoria = 'PROMOCAO';

-- 13) UPDATE com JOIN (muito usado em produção)
UPDATE produto p
INNER JOIN categoria c
        ON p.idcategoria = c.idcategoria
SET p.valor = p.valor * 1.15
WHERE c.nome = 'IMPORTADOS';

-- 14) UPDATE com JOIN em outra tabela
UPDATE cliente c
INNER JOIN endereco e
        ON c.idcliente = e.id_cliente
SET c.ativo = 0
WHERE e.estado = 'SP';

-- 15) UPDATE limitando quantidade de linhas (MySQL)
UPDATE cliente
SET ativo = 0
ORDER BY idcliente
LIMIT 10;

-- 16) UPDATE com data/hora atual
UPDATE pedido
SET data_atualizacao = NOW()
WHERE status = 'PAGO';

-- 17) UPDATE com COALESCE / IFNULL
UPDATE cliente
SET email = COALESCE(email, 'sememail@dominio.com');

-- 18) UPDATE com CONCAT
UPDATE cliente
SET observacao = CONCAT('Cliente atualizado em ', NOW())
WHERE idcliente = 1;

-- 19) UPDATE com EXISTS
UPDATE cliente c
SET ativo = 0
WHERE EXISTS (
    SELECT 1
    FROM bloqueio b
    WHERE b.idcliente = c.idcliente
);

-- 20) UPDATE com BETWEEN
UPDATE produto
SET valor = valor * 0.95
WHERE valor BETWEEN 100 AND 200;

-- 21) UPDATE sem WHERE (⚠️ ATENÇÃO)
UPDATE cliente
SET ativo = 1;

-- 22) UPDATE com verificação antes (boa prática)
SELECT *
FROM produto
WHERE categoria = 'LIVROS';

UPDATE produto
SET valor = valor * 1.05
WHERE categoria = 'LIVROS';



/* =========================
   UPDATE – COLA RÁPIDA
   ========================= */

-- 1) Básico (sempre com WHERE)
UPDATE tabela
SET coluna = valor
WHERE condicao;

-- 2) Por chave primária
UPDATE produto
SET valor = 110.00
WHERE idproduto = 4;

-- 3) Múltiplas colunas
UPDATE cliente
SET email = 'ana@gmail.com',
    telefone = '11999999999'
WHERE idcliente = 10;

-- 4) AND / OR
UPDATE cliente
SET ativo = 0
WHERE sexo = 'M'
  AND endereco LIKE '%RJ';

-- 5) LIKE
UPDATE cliente
SET endereco = 'RIO DE JANEIRO - RJ'
WHERE endereco LIKE '%RIO%';

-- 6) NULL (atribuir)
UPDATE cliente
SET email = NULL
WHERE nome = 'CARLA';

-- 7) Cálculo
UPDATE produto
SET valor = valor * 1.10
WHERE categoria = 'ELETRONICOS';

-- 8) Arredondamento
UPDATE produto
SET valor = ROUND(valor * 1.05, 2)
WHERE categoria = 'LIVROS';

-- 9) CASE (condicional)
UPDATE cliente
SET ativo =
    CASE
        WHEN sexo = 'F' THEN 1
        ELSE 0
    END;

-- 10) Subquery (IN)
UPDATE produto
SET valor = valor * 0.90
WHERE idproduto IN (
    SELECT idproduto
    FROM estoque
    WHERE quantidade < 10
);

-- 11) Subquery escalar
UPDATE produto
SET valor = (
    SELECT AVG(valor)
    FROM produto
)
WHERE categoria = 'PROMOCAO';

-- 12) UPDATE com JOIN
UPDATE cliente c
INNER JOIN endereco e
        ON c.idcliente = e.id_cliente
SET c.ativo = 0
WHERE e.estado = 'SP';

-- 13) EXISTS
UPDATE cliente c
SET ativo = 0
WHERE EXISTS (
    SELECT 1
    FROM bloqueio b
    WHERE b.idcliente = c.idcliente
);

-- 14) BETWEEN
UPDATE produto
SET valor = valor * 0.95
WHERE valor BETWEEN 100 AND 200;

-- 15) Funções úteis
UPDATE cliente
SET email = COALESCE(email, 'sememail@dominio.com');

-- 16) LIMIT (MySQL)
UPDATE cliente
SET ativo = 0
ORDER BY idcliente
LIMIT 10;

-- 17) Data/hora
UPDATE pedido
SET data_atualizacao = NOW()
WHERE status = 'PAGO';

-- 18) ⚠️ SEM WHERE (cuidado!)
UPDATE cliente
SET ativo = 1;
