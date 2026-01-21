/* ============================================================
   DROP – EXEMPLOS CONSOLIDADOS (MySQL)
   ============================================================ */

-- 1) Apagar banco de dados
DROP DATABASE comercio;

-- 2) Apagar banco de dados (seguro)
DROP DATABASE IF EXISTS comercio;

-- 3) Apagar tabela
DROP TABLE cliente;

-- 4) Apagar tabela (seguro)
DROP TABLE IF EXISTS cliente;

-- 5) Apagar múltiplas tabelas
DROP TABLE IF EXISTS cliente, telefone, endereco;

-- 6) Apagar coluna
ALTER TABLE produto
DROP COLUMN peso;

-- 7) Apagar chave primária
ALTER TABLE cliente
DROP PRIMARY KEY;

-- 8) Apagar foreign key
ALTER TABLE telefone
DROP FOREIGN KEY fk_cliente_telefone;

-- 9) Apagar índice comum
DROP INDEX idx_cliente_email ON cliente;

-- 10) Apagar índice UNIQUE
DROP INDEX uk_cliente_cpf ON cliente;

-- 11) Apagar view
DROP VIEW relatorio_clientes;

-- 12) Apagar view (seguro)
DROP VIEW IF EXISTS relatorio_clientes;

-- 13) Apagar procedure
DROP PROCEDURE calcular_total;

-- 14) Apagar procedure (seguro)
DROP PROCEDURE IF EXISTS calcular_total;

-- 15) Apagar function
DROP FUNCTION calcular_desconto;

-- 16) Apagar function (seguro)
DROP FUNCTION IF EXISTS calcular_desconto;

-- 17) Apagar trigger
DROP TRIGGER trg_before_insert_cliente;

-- 18) Apagar trigger (seguro)
DROP TRIGGER IF EXISTS trg_before_insert_cliente;

-- 19) Apagar evento (event scheduler)
DROP EVENT evento_limpeza_diaria;

-- 20) Apagar evento (seguro)
DROP EVENT IF EXISTS evento_limpeza_diaria;

-- 21) Apagar constraint CHECK (MySQL 8+)
ALTER TABLE cliente
DROP CHECK chk_sexo;

-- 22) Apagar sequence (MySQL 8+)
DROP SEQUENCE seq_pedido;

-- 23) Apagar tablespace (avançado)
DROP TABLESPACE ts_dados;

-- 24) Apagar usuário
DROP USER 'usuario_teste'@'localhost';

-- 25) Apagar usuário (seguro)
DROP USER IF EXISTS 'usuario_teste'@'localhost';

-- 26) Apagar role
DROP ROLE role_leitura;

-- 27) Apagar role (seguro)
DROP ROLE IF EXISTS role_leitura;

-- 28) Apagar banco temporário (exemplo)
DROP DATABASE IF EXISTS tmp_migracao;

-- 29) Apagar tudo de uma tabela (estrutura fica)
TRUNCATE TABLE logs;

-- 30) Apagar partição
ALTER TABLE vendas
DROP PARTITION p2023;
