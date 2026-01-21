/* ============================================================
   ALTER TABLE (MySQL) - exemplos organizados
   ============================================================ */


/* ============================================================
   1) RENOMEAR / AJUSTAR COLUNA (CHANGE / MODIFY)
   ============================================================ */

-- CHANGE: renomeia coluna e pode alterar tipo/constraints
ALTER TABLE produto
  CHANGE preco valor_unitario INT NOT NULL;

-- CHANGE: manter o nome, mas alterar definição (tipo/constraints)
ALTER TABLE produto
  CHANGE valor_unitario valor_unitario INT;

-- MODIFY: altera tipo/constraints SEM renomear coluna
ALTER TABLE produto
  MODIFY valor_unitario VARCHAR(50) NOT NULL;


/* ============================================================
   2) ADICIONAR COLUNAS (ADD)
   ============================================================ */

-- adiciona coluna (vai para o final)
ALTER TABLE produto
  ADD peso DECIMAL(10,2) NOT NULL;

-- adiciona coluna em posição específica
ALTER TABLE produto
  ADD COLUMN peso DECIMAL(10,2) NOT NULL
  AFTER nome_produto;

-- adiciona coluna como primeira
ALTER TABLE produto
  ADD COLUMN peso DECIMAL(10,2) NOT NULL
  FIRST;

-- exemplo genérico (sem posição)
ALTER TABLE tabela
  ADD coluna VARCHAR(30);

ALTER TABLE tabela
  ADD coluna100 INT;

-- exemplo genérico com posição + UNIQUE
ALTER TABLE tabela
  ADD COLUMN coluna4 VARCHAR(30) NOT NULL UNIQUE
  AFTER coluna3;


/* ============================================================
   3) REMOVER COLUNAS (DROP COLUMN)
   ============================================================ */

ALTER TABLE produto
  DROP COLUMN peso;


/* ============================================================
   4) CHAVES PRIMÁRIAS (PRIMARY KEY)
   ============================================================ */

-- adicionando PK simples
ALTER TABLE tabela
  ADD PRIMARY KEY (coluna1);

-- adicionando PK com nome de constraint (boa prática)
ALTER TABLE cliente
  ADD CONSTRAINT pk_cliente
  PRIMARY KEY (idcliente);


/* ============================================================
   5) CHAVES ESTRANGEIRAS (FOREIGN KEY)
   ============================================================ */

-- FK (forma recomendada: nomear constraint)
ALTER TABLE telefone
  ADD CONSTRAINT fk_cliente_telefone
  FOREIGN KEY (id_cliente) REFERENCES cliente(idcliente);

-- FK com ação ON DELETE (CASCADE)
ALTER TABLE telefone
  ADD CONSTRAINT fk_cliente_telefone
  FOREIGN KEY (id_cliente) REFERENCES cliente(idcliente)
  ON DELETE CASCADE;

-- FK com ação ON DELETE (SET NULL)
ALTER TABLE telefone
  ADD CONSTRAINT fk_cliente_telefone
  FOREIGN KEY (id_cliente) REFERENCES cliente(idcliente)
  ON DELETE SET NULL;

-- exemplos em cadeia (carro/marca/cor)
ALTER TABLE cliente
  ADD CONSTRAINT fk_cliente_carro
  FOREIGN KEY (id_carro) REFERENCES carro(idcarro);

ALTER TABLE carro
  ADD CONSTRAINT fk_carro_marca
  FOREIGN KEY (id_marca) REFERENCES marca(idmarca);

ALTER TABLE carro_cor
  ADD CONSTRAINT fk_carro_cor_cor
  FOREIGN KEY (id_cor) REFERENCES cor(idcor);

ALTER TABLE carro_cor
  ADD CONSTRAINT fk_carro_cor_carro
  FOREIGN KEY (id_carro) REFERENCES carro(idcarro);


/* ============================================================
   6) REMOVER CONSTRAINTS (DROP FOREIGN KEY)
   ============================================================ */

-- MySQL: para FK, usa DROP FOREIGN KEY <nome_da_fk>
ALTER TABLE telefone
  DROP FOREIGN KEY fk_cliente_telefone;


/* ============================================================
   7) RENOMEAR TABELA
   ============================================================ */

-- MySQL moderno:
RENAME TABLE tabela TO pessoa;

-- (alternativo, dependendo da versão):
-- ALTER TABLE tabela RENAME TO pessoa;


/* ============================================================
   8) ALTERAR TIPO DE CAMPO (exemplo genérico)
   ============================================================ */

ALTER TABLE tabela
  MODIFY coluna2 DATE NOT NULL;

/* ============================================================
   FIM DO ARQUIVO
   ============================================================ */

/* ============================================================
   ALTER TABLE – EXEMPLOS CONSOLIDADOS (MySQL)
   ============================================================ */

-- 1) Renomear coluna + alterar definição
ALTER TABLE produto
  CHANGE preco valor_unitario INT NOT NULL;

-- 2) Alterar tipo mantendo o nome (CHANGE)
ALTER TABLE produto
  CHANGE valor_unitario valor_unitario INT;

-- 3) Alterar tipo sem renomear (MODIFY)
ALTER TABLE produto
  MODIFY valor_unitario VARCHAR(50) NOT NULL;

-- 4) Adicionar coluna (última posição)
ALTER TABLE produto
  ADD peso DECIMAL(10,2) NOT NULL;

-- 5) Adicionar coluna após outra
ALTER TABLE produto
  ADD COLUMN peso DECIMAL(10,2) NOT NULL
  AFTER nome_produto;

-- 6) Adicionar coluna como primeira
ALTER TABLE produto
  ADD COLUMN peso DECIMAL(10,2) NOT NULL
  FIRST;

-- 7) Remover coluna
ALTER TABLE produto
  DROP COLUMN peso;

-- 8) Adicionar chave primária
ALTER TABLE tabela
  ADD PRIMARY KEY (coluna1);

-- 9) Adicionar chave primária com nome
ALTER TABLE cliente
  ADD CONSTRAINT pk_cliente
  PRIMARY KEY (idcliente);

-- 10) Adicionar coluna simples (genérico)
ALTER TABLE tabela
  ADD coluna VARCHAR(30);

-- 11) Adicionar coluna com posição + UNIQUE
ALTER TABLE tabela
  ADD COLUMN coluna4 VARCHAR(30) NOT NULL UNIQUE
  AFTER coluna3;

-- 12) Modificar tipo e NOT NULL
ALTER TABLE tabela
  MODIFY coluna2 DATE NOT NULL;

-- 13) Renomear tabela
RENAME TABLE tabela TO pessoa;

-- 14) Adicionar foreign key (FK)
ALTER TABLE telefone
  ADD CONSTRAINT fk_cliente_telefone
  FOREIGN KEY (id_cliente) REFERENCES cliente(idcliente);

-- 15) Remover foreign key
ALTER TABLE telefone
  DROP FOREIGN KEY fk_cliente_telefone;

-- 16) Recriar FK com ON DELETE CASCADE
ALTER TABLE telefone
  ADD CONSTRAINT fk_cliente_telefone
  FOREIGN KEY (id_cliente) REFERENCES cliente(idcliente)
  ON DELETE CASCADE;

-- 17) Recriar FK com ON DELETE SET NULL
ALTER TABLE telefone
  ADD CONSTRAINT fk_cliente_telefone
  FOREIGN KEY (id_cliente) REFERENCES cliente(idcliente)
  ON DELETE SET NULL;

-- 18) Adicionar FK em cadeia
ALTER TABLE cliente
  ADD CONSTRAINT fk_cliente_carro
  FOREIGN KEY (id_carro) REFERENCES carro(idcarro);

ALTER TABLE carro
  ADD CONSTRAINT fk_carro_marca
  FOREIGN KEY (id_marca) REFERENCES marca(idmarca);

-- 19) Adicionar DEFAULT
ALTER TABLE produto
  ADD ativo TINYINT(1) NOT NULL DEFAULT 1;

-- 20) Alterar DEFAULT existente
ALTER TABLE produto
  MODIFY ativo TINYINT(1) NOT NULL DEFAULT 0;

-- 21) Remover DEFAULT
ALTER TABLE produto
  ALTER ativo DROP DEFAULT;

-- 22) Tornar coluna NOT NULL
ALTER TABLE cliente
  MODIFY email VARCHAR(100) NOT NULL;

-- 23) Tornar coluna NULL
ALTER TABLE cliente
  MODIFY email VARCHAR(100) NULL;

-- 24) Criar índice
ALTER TABLE cliente
  ADD INDEX idx_cliente_email (email);

-- 25) Criar índice único
ALTER TABLE cliente
  ADD UNIQUE INDEX uk_cliente_cpf (cpf);

-- 26) Remover índice
ALTER TABLE cliente
  DROP INDEX idx_cliente_email;

-- 27) Chave primária composta
ALTER TABLE item_compra
  ADD CONSTRAINT pk_item_compra
  PRIMARY KEY (id_compra, id_produto);

-- 28) CHECK constraint (MySQL 8+)
ALTER TABLE cliente
  ADD CONSTRAINT chk_sexo
  CHECK (sexo IN ('M','F'));

-- 29) Desabilitar / habilitar validação de FK
SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;

-- 30) Alterar ENGINE
ALTER TABLE cliente
  ENGINE = InnoDB;

-- 31) Alterar charset e collation
ALTER TABLE cliente
  CONVERT TO CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

-- 32) Adicionar AUTO_INCREMENT
ALTER TABLE cliente
  MODIFY idcliente INT NOT NULL AUTO_INCREMENT;

-- 33) Ajustar próximo valor do AUTO_INCREMENT
ALTER TABLE cliente AUTO_INCREMENT = 1000;

-- 34) Renomear coluna (MySQL 8+)
ALTER TABLE produto
  RENAME COLUMN valor_unitario TO preco_unitario;

-- 35) Coluna calculada (generated column)
ALTER TABLE vendas
  ADD total DECIMAL(10,2)
  GENERATED ALWAYS AS (quantidade * valor_unitario) STORED;

-- 36) Comentário em coluna
ALTER TABLE cliente
  MODIFY email VARCHAR(100)
  COMMENT 'Email principal do cliente';

-- 37) Comentário na tabela
ALTER TABLE cliente
  COMMENT = 'Tabela de clientes do sistema';
