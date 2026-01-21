-- =====================================================================
-- LOJA database schema (MySQL/MariaDB)
-- Generated/organized for version control (GitHub).
-- =====================================================================

-- Create database with a safe default charset/collation (adjust if needed)
CREATE DATABASE IF NOT EXISTS LOJA
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE LOJA;

-- Disable FK checks during rebuild
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
-- Drop tables (dependency order)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS LOJA.PRODUTO_CARACTERISTICA;
DROP TABLE IF EXISTS LOJA.CARACTERISTICA;
DROP TABLE IF EXISTS LOJA.PRODUTO;
DROP TABLE IF EXISTS LOJA.FABRICANTE;
DROP TABLE IF EXISTS LOJA.CATEGORIA;
DROP TABLE IF EXISTS LOJA.DEPARTAMENTO;
DROP TABLE IF EXISTS LOJA.GRUPO;

-----------------------------------------------------------------------
---      Create tables
-----------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS LOJA.GRUPO (
  COD_GRUPO INT NOT NULL AUTO_INCREMENT,
  NOM_GRUPO VARCHAR(45) NOT NULL,
  IDF_ATIVO CHAR(1) NOT NULL DEFAULT 'S',
  CONSTRAINT PK_GRUPO PRIMARY KEY (COD_GRUPO)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DESC LOJA.GRUPO;
+-----------+-------------+------+-----+---------+----------------+
| Field     | Type        | Null | Key | Default | Extra          |
+-----------+-------------+------+-----+---------+----------------+
| COD_GRUPO | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOM_GRUPO | varchar(45) | NO   |     | NULL    |                |
| IDF_ATIVO | varchar(1)  | YES  |     | S       |                |
+-----------+-------------+------+-----+---------+----------------+



CREATE TABLE IF NOT EXISTS LOJA.DEPARTAMENTO (
    COD_DEPARTAMENTO INT NOT NULL AUTO_INCREMENT,
    NOM_DEPARTAMENTO VARCHAR(45) NOT NULL,
    IDF_ATIVO CHAR(1) NOT NULL DEFAULT 'S',
    COD_GRUPO INT NULL,
    CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (COD_DEPARTAMENTO),
    KEY IX_DEPARTAMENTO_COD_GRUPO (COD_GRUPO),
    CONSTRAINT FK_DEPARTAMENTO_GRUPO
    FOREIGN KEY (COD_GRUPO) REFERENCES LOJA.GRUPO (COD_GRUPO)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DESC LOJA.DEPARTAMENTO;
+------------------+-------------+------+-----+---------+----------------+
| Field            | Type        | Null | Key | Default | Extra          |
+------------------+-------------+------+-----+---------+----------------+
| COD_DEPARTAMENTO | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOM_DEPARTAMENTO | varchar(45) | NO   |     | NULL    |                |
| IDF_ATIVO        | varchar(1)  | YES  |     | S       |                |
| COD_GRUPO        | int(11)     | YES  | MUL | NULL    |                |
+------------------+-------------+------+-----+---------+----------------+





CREATE TABLE IF NOT EXISTS LOJA.CATEGORIA (
  COD_CATEGORIA INT NOT NULL AUTO_INCREMENT,
  NOM_CATEGORIA VARCHAR(45) NOT NULL,
  IDF_ATIVO CHAR(1) NOT NULL DEFAULT 'S',
  COD_DEPARTAMENTO INT NULL,
  POS_CATEGORIA INT NULL,
  CONSTRAINT PK_CATEGORIA PRIMARY KEY (COD_CATEGORIA),
  KEY IX_CATEGORIA_COD_DEPARTAMENTO (COD_DEPARTAMENTO),
  CONSTRAINT FK_CATEGORIA_DEPARTAMENTO
    FOREIGN KEY (COD_DEPARTAMENTO) REFERENCES LOJA.DEPARTAMENTO (COD_DEPARTAMENTO)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DESC LOJA.CATEGORIA;
+------------------+-------------+------+-----+---------+----------------+
| Field            | Type        | Null | Key | Default | Extra          |
+------------------+-------------+------+-----+---------+----------------+
| COD_CATEGORIA    | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOM_CATEGORIA    | varchar(45) | NO   |     | NULL    |                |
| IDF_ATIVO        | varchar(1)  | YES  |     | S       |                |
| COD_DEPARTAMENTO | int(11)     | NO   | MUL | NULL    |                |
| POS_CATEGORIA    | int(11)     | NO   |     | NULL    |                |
+------------------+-------------+------+-----+---------+----------------+






CREATE TABLE IF NOT EXISTS LOJA.FABRICANTE (
  COD_FABRICANTE INT NOT NULL AUTO_INCREMENT,
  NOM_FABRICANTE VARCHAR(45) NOT NULL,
  SITE_FABRICANTE VARCHAR(200) NULL,
  IDF_ATIVO CHAR(1) NOT NULL DEFAULT 'S',
  CONSTRAINT PK_FABRICANTE PRIMARY KEY (COD_FABRICANTE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
 DESC LOJA.FABRICANTE;
+-----------------+--------------+------+-----+---------+----------------+
| Field           | Type         | Null | Key | Default | Extra          |
+-----------------+--------------+------+-----+---------+----------------+
| COD_FABRICANTE  | int(11)      | NO   | PRI | NULL    | auto_increment |
| NOM_FABRICANTE  | varchar(100) | NO   |     | NULL    |                |
| SITE_FABRICANTE | varchar(250) | YES  |     | NULL    |                |
| IDF_ATIVO       | varchar(1)   | YES  |     | S       |                |
+-----------------+--------------+------+-----+---------+----------------+






CREATE TABLE IF NOT EXISTS LOJA.PRODUTO (
  COD_PRODUTO INT NOT NULL AUTO_INCREMENT,
  NOM_PRODUTO VARCHAR(250) NOT NULL,
  DSC_PRODUTO LONGTEXT NULL,
  IMG_PRODUTO VARCHAR(250) NULL,
  EST_PRODUTO INT NOT NULL DEFAULT 0,
  PCO_PRODUTO DECIMAL(10,2) NOT NULL DEFAULT 0,
  NUM_DIAS_PREV_ENTREGA INT NOT NULL DEFAULT 0,
  COD_CATEGORIA INT NOT NULL,
  COD_FABRICANTE INT NOT NULL,
  CONSTRAINT PK_PRODUTO PRIMARY KEY (COD_PRODUTO),
  KEY IX_PRODUTO_COD_CATEGORIA (COD_CATEGORIA),
  KEY IX_PRODUTO_COD_FABRICANTE (COD_FABRICANTE),
  CONSTRAINT FK_PRODUTO_CATEGORIA
    FOREIGN KEY (COD_CATEGORIA) REFERENCES LOJA.CATEGORIA (COD_CATEGORIA),
  CONSTRAINT FK_PRODUTO_FABRICANTE
    FOREIGN KEY (COD_FABRICANTE) REFERENCES LOJA.FABRICANTE (COD_FABRICANTE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DESC LOJA.PRODUTO;
+-----------------------+---------------+------+-----+---------+----------------+
| Field                 | Type          | Null | Key | Default | Extra          |
+-----------------------+---------------+------+-----+---------+----------------+
| COD_PRODUTO           | int(11)       | NO   | PRI | NULL    | auto_increment |
| NOM_PRODUTO           | varchar(250)  | NO   |     | NULL    |                |
| DSC_PRODUTO           | longtext      | YES  |     | NULL    |                |
| IMG_PRODUTO           | varchar(250)  | YES  |     | NULL    |                |
| EST_PRODUTO           | int(11)       | YES  |     | 0       |                |
| PCO_PRODUTO           | decimal(10,2) | YES  |     | 0.00    |                |
| NUM_DIAS_PREV_ENTREGA | int(11)       | YES  |     | 0       |                |
| COD_CATEGORIA         | int(11)       | NO   | MUL | NULL    |                |
| COD_FABRICANTE        | int(11)       | NO   | MUL | NULL    |                |
+-----------------------+---------------+------+-----+---------+----------------+






CREATE TABLE IF NOT EXISTS LOJA.CARACTERISTICA (
  COD_CARACTERISTICA INT NOT NULL AUTO_INCREMENT,
  NOM_CARACTERISTICA VARCHAR(45) NOT NULL,
  IDF_ATIVO CHAR(1) NOT NULL DEFAULT 'S',
  CONSTRAINT PK_CARACTERISTICA PRIMARY KEY (COD_CARACTERISTICA)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DESC LOJA.CARACTERISTICA;
+--------------------+-------------+------+-----+---------+----------------+
| Field              | Type        | Null | Key | Default | Extra          |
+--------------------+-------------+------+-----+---------+----------------+
| COD_CARACTERISTICA | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOM_CARACTERISTICA | varchar(45) | NO   |     | NULL    |                |
| IDF_ATIVO          | varchar(1)  | YES  |     | S       |                |
+--------------------+-------------+------+-----+---------+----------------+



CREATE TABLE IF NOT EXISTS LOJA.PRODUTO_CARACTERISTICA (
  COD_PRODUTO INT NOT NULL,
  COD_CARACTERISTICA INT NOT NULL,
  SEQ_CARACTERISTICA INT NOT NULL,
  VLR_CARACTERISTICA VARCHAR(100) NOT NULL,
  CONSTRAINT PK_PRODUTO_CARACTERISTICA
    PRIMARY KEY (COD_PRODUTO, COD_CARACTERISTICA, SEQ_CARACTERISTICA),
  KEY IX_PRODUTO_CARACTERISTICA_COD_CARACTERISTICA (COD_CARACTERISTICA),
  CONSTRAINT FK_PRODUTO_CARACTERISTICA_PRODUTO
    FOREIGN KEY (COD_PRODUTO) REFERENCES LOJA.PRODUTO (COD_PRODUTO),
  CONSTRAINT FK_PRODUTO_CARACTERISTICA_CARACTERISTICA
    FOREIGN KEY (COD_CARACTERISTICA) REFERENCES LOJA.CARACTERISTICA (COD_CARACTERISTICA)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

 DESC LOJA.PRODUTO_CARACTERISTICA;
+--------------------+--------------+------+-----+---------+-------+
| Field              | Type         | Null | Key | Default | Extra |
+--------------------+--------------+------+-----+---------+-------+
| COD_PRODUTO        | int(11)      | NO   | PRI | NULL    |       |
| COD_CARACTERISTICA | int(11)      | NO   | PRI | NULL    |       |
| SEQ_CARACTERISTICA | int(11)      | NO   | PRI | NULL    |       |
| VLR_CARACTERISTICA | varchar(100) | NO   |     | NULL    |       |
+--------------------+--------------+------+-----+---------+-------+



-- Re-enable FK checks
SET FOREIGN_KEY_CHECKS = 1;
