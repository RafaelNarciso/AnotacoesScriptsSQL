/* ============================================================
   CONTEXTO
   - LIVROS (LIVRARIA)
   - CLIENTE / ENDERECO / TELEFONE (PROJETO)
   - FUNCIONARIOS (EXERCICIO)
   - VENDEDORES / CURSOS (EXEMPLOS)
   ============================================================ */


/* ============================================================
   1) LIVROS
   ============================================================ */

-- 1) Trazer todos os dados
SELECT *
FROM livros;

-- 2) Trazer o nome do livro e a editora
SELECT livro, editora
FROM livros;

-- 3) Trazer o nome do livro e a UF dos livros publicados por autores do sexo masculino
SELECT livro, uf
FROM livros
WHERE sexo = 'M';

-- (variação incluindo autor)
SELECT autor, sexo, livro, uf
FROM livros
WHERE sexo = 'M';

-- 4) Trazer o nome do livro e o número de páginas dos livros publicados por autores do sexo feminino
SELECT livro, paginas
FROM livros
WHERE sexo = 'F';

-- (variação incluindo autor)
SELECT autor, livro, paginas
FROM livros
WHERE sexo = 'F';

-- 5) Trazer os valores dos livros publicados em SP
SELECT livro, valor
FROM livros
WHERE uf = 'SP';

-- (variação incluindo UF)
SELECT uf, livro, valor
FROM livros
WHERE uf = 'SP';

-- 6) Autores masculinos com livros publicados em SP ou RJ (atenção ao AND/OR)
SELECT autor, sexo, uf
FROM livros
WHERE sexo = 'M'
  AND (uf = 'SP' OR uf = 'RJ');

-- 6b) Filtro adicional: páginas > 100 e UF = SP
SELECT autor, sexo, uf
FROM livros
WHERE sexo = 'M'
  AND uf = 'SP'
  AND paginas > 100;


/* ============================================================
   2) CLIENTE - FILTROS (WHERE/LIKE) + AGREGAÇÃO (COUNT/GROUP BY)
   ============================================================ */

-- Todos os clientes
SELECT *
FROM cliente;

-- OR (pelo menos uma condição verdadeira)
SELECT nome, sexo, endereco
FROM cliente
WHERE sexo = 'M'
   OR endereco LIKE '%RJ';

-- AND (todas condições verdadeiras)
SELECT nome, sexo, endereco
FROM cliente
WHERE sexo = 'M'
  AND endereco LIKE '%RJ';

-- Feminino ou endereço contendo ESTACIO
SELECT nome, sexo, endereco
FROM cliente
WHERE sexo = 'F'
   OR endereco LIKE '%ESTACIO';

-- Contando registros
SELECT COUNT(*) AS qtd_registros
FROM cliente;

-- Contagem por sexo (GROUP BY)
SELECT sexo, COUNT(*) AS qtd
FROM cliente
GROUP BY sexo;

-- Contagem por endereço
SELECT endereco, COUNT(*) AS qtd
FROM cliente
GROUP BY endereco;

-- Data/hora atual (MySQL)
SELECT NOW() AS data_atual;

-- Operações em linha (exemplo)
SELECT 2 + 2 AS soma;


/* ============================================================
   3) CLIENTE - NULOS (NULL)
   ============================================================ */

-- Filtrando mulheres
SELECT nome, sexo, endereco
FROM cliente
WHERE sexo = 'F';

-- ERRADO: NULL não se compara com "="
-- WHERE email = NULL;

-- Certo: IS NULL / IS NOT NULL
SELECT nome, sexo, endereco
FROM cliente
WHERE email IS NULL;

SELECT nome, sexo, endereco
FROM cliente
WHERE email IS NOT NULL;


/* ============================================================
   4) CLIENTE - UPDATE + CHECK
   ============================================================ */

-- Buscar cliente específico
SELECT *
FROM cliente
WHERE nome = 'LILIAN';

-- Atualizar e validar
UPDATE cliente
SET email = 'JOAOA@IG.COM.BR'
WHERE nome = 'JOAO';

UPDATE cliente
SET email = 'JORGE@IG.COM.BR'
WHERE nome = 'JORGE';

SELECT nome, email
FROM cliente;

-- Contagem total e por filtro
SELECT COUNT(*) AS total
FROM cliente;

SELECT COUNT(*) AS total_ana
FROM cliente
WHERE nome = 'ANA';

-- OR vs AND (exemplo)
SELECT *
FROM cliente
WHERE nome = 'CARLA'
   OR email = 'LILIAN@HOTMAIL.COM';

SELECT *
FROM cliente
WHERE nome = 'CARLA'
  AND email = 'LILIAN@HOTMAIL.COM';


/* ============================================================
   5) JOINs (CLIENTE + ENDERECO + TELEFONE)
   ============================================================ */

-- JOIN (recomendado) com aliases
SELECT c.nome, c.sexo, e.bairro, e.cidade
FROM cliente c
INNER JOIN endereco e
        ON c.idcliente = e.id_cliente
WHERE c.sexo = 'F';

SELECT c.nome, c.sexo, c.email, t.tipo, t.numero
FROM cliente c
INNER JOIN telefone t
        ON c.idcliente = t.id_cliente;

SELECT c.nome, c.sexo, e.bairro, e.cidade, t.tipo, t.numero
FROM cliente c
INNER JOIN endereco e
        ON c.idcliente = e.id_cliente
INNER JOIN telefone t
        ON c.idcliente = t.id_cliente;

-- Relatório de homens
SELECT c.idcliente, c.nome, c.sexo, c.email, c.cpf,
       e.rua, e.bairro, e.cidade, e.estado,
       t.tipo, t.numero
FROM cliente c
INNER JOIN endereco e ON c.idcliente = e.id_cliente
INNER JOIN telefone t ON c.idcliente = t.id_cliente
WHERE c.sexo = 'M';

-- Quantidade de homens e mulheres
SELECT sexo, COUNT(*) AS quantidade
FROM cliente
GROUP BY sexo;

-- Mulheres do Centro/Rio (com telefone)
SELECT c.idcliente, c.email, c.nome, c.sexo, t.tipo, e.bairro, e.cidade
FROM cliente c
INNER JOIN endereco e ON c.idcliente = e.id_cliente
INNER JOIN telefone t ON c.idcliente = t.id_cliente
WHERE c.sexo = 'F'
  AND e.bairro = 'CENTRO'
  AND e.cidade = 'RIO DE JANEIRO'
  AND (t.tipo = 'RES' OR t.tipo = 'COM');

-- Celulares do RJ (exemplo)
SELECT c.nome, c.email, t.numero AS celular
FROM cliente c
INNER JOIN endereco e ON c.idcliente = e.id_cliente
INNER JOIN telefone t ON c.idcliente = t.id_cliente
WHERE t.tipo = 'CEL'
  AND e.estado = 'RJ';

-- IFNULL (MySQL) - mascarando email
SELECT c.nome,
       IFNULL(c.email, '************') AS email,
       e.estado,
       t.numero
FROM cliente c
INNER JOIN endereco e ON c.idcliente = e.id_cliente
INNER JOIN telefone t ON c.idcliente = t.id_cliente;


/* ============================================================
   6) FUNCIONARIOS - FILTROS + AGRUPAMENTO
   ============================================================ */

SELECT COUNT(*) AS total_funcionarios
FROM funcionarios;

-- Funcionários do depto Roupas OU Filmes
SELECT *
FROM funcionarios
WHERE departamento = 'Roupas'
   OR departamento = 'Filmes';

-- Contagem por departamento
SELECT departamento, COUNT(*) AS qtd
FROM funcionarios
GROUP BY departamento
ORDER BY qtd;

-- Contagem por sexo
SELECT sexo, COUNT(*) AS qtd
FROM funcionarios
GROUP BY sexo;

-- Feminino em Lar ou Filmes (OR + AND com parênteses)
SELECT *
FROM funcionarios
WHERE (departamento = 'Lar'    AND sexo = 'Feminino')
   OR (departamento = 'Filmes' AND sexo = 'Feminino');

-- Masculino OU departamento Jardim
SELECT *
FROM funcionarios
WHERE sexo = 'Masculino'
   OR departamento = 'Jardim';


/* ============================================================
   7) VENDEDORES - FUNÇÕES DE AGREGAÇÃO + SUBQUERIES
   ============================================================ */

-- Máximo / mínimo / média
SELECT MAX(fevereiro) AS maior_fev
FROM vendedores;

SELECT MIN(fevereiro) AS menor_fev
FROM vendedores;

SELECT AVG(fevereiro) AS media_fev
FROM vendedores;

-- Várias funções juntas
SELECT MAX(janeiro) AS max_jan,
       MIN(janeiro) AS min_jan,
       TRUNCATE(AVG(janeiro), 2) AS media_jan
FROM vendedores;

-- SUM por mês
SELECT SUM(janeiro) AS total_jan,
       SUM(fevereiro) AS total_fev,
       SUM(marco) AS total_mar
FROM vendedores;

-- Vendas por sexo
SELECT sexo, SUM(marco) AS total_marco
FROM vendedores
GROUP BY sexo;

-- Registros com mínimo/máximo usando subquery
SELECT nome, marco
FROM vendedores
WHERE marco = (SELECT MIN(marco) FROM vendedores);

SELECT nome, fevereiro
FROM vendedores
WHERE fevereiro > (SELECT AVG(fevereiro) FROM vendedores);

-- Total e média por vendedor (operação em linha)
SELECT nome,
       janeiro,
       fevereiro,
       marco,
       (janeiro + fevereiro + marco) AS total,
       TRUNCATE((janeiro + fevereiro + marco) / 3, 2) AS media
FROM vendedores;


============================================================
    8) CURSOS - LEFT JOIN (pré-requisito)
============================================================

SELECT c.nome  AS curso,
       c.valor AS valor,
       c.horas AS carga,
       IFNULL(p.nome, '---') AS prereq
FROM cursos c
LEFT JOIN cursos p
       ON p.idcurso = c.id_prereq;


============================================================
    9) VALORES ÚNICOS DE UMA COLUNA (DISTINCT)
============================================================

SELECT DISTINCT uf
FROM livros;

-- combinação única de colunas (tuplas únicas)
SELECT DISTINCT autor, uf
FROM livros;

-- com agregação (contar distintos)
SELECT COUNT(DISTINCT departamento) AS qtd_departamentos
FROM funcionarios;
