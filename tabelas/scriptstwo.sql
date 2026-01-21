
CREATE DATABASE IF NOT EXISTS LOJA;

USE LOJA;

DROP TABLE IF EXISTS LOJA.GRUPO;

CREATE TABLE IF NOT EXISTS LOJA.GRUPO (
    COD_GRUPO INT NOT NULL AUTO_INCREMENT,

    NOM_GRUPO VARCHAR(45) NOT NULL,
    IDF_ATIVO VARCHAR(1) DEFAULT 'S',
    PRIMARY KEY (COD_GRUPO)
) ENGINE = InnoDB;
+-----------+-------------+------+-----+---------+----------------+
| Field     | Type        | Null | Key | Default | Extra          |
+-----------+-------------+------+-----+---------+----------------+
| COD_GRUPO | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOM_GRUPO | varchar(45) | NO   |     | NULL    |                |
| IDF_ATIVO | varchar(1)  | YES  |     | S       |                |
+-----------+-------------+------+-----+---------+----------------+


/*---------------------------------------------------------------------------*/


DROP TABLE IF EXISTS LOJA.DEPARTAMENTO;

CREATE TABLE IF NOT EXISTS LOJA.DEPARTAMENTO (
    COD_DEPARTAMENTO INT NOT NULL AUTO_INCREMENT,
    NOM_DEPARTAMENTO VARCHAR(45) NOT NULL,
    IDF_ATIVO VARCHAR(1) DEFAULT 'S',
    COD_GRUPO INT,
    PRIMARY KEY (COD_DEPARTAMENTO),
    FOREIGN KEY (COD_GRUPO) REFERENCES LOJA.GRUPO(COD_GRUPO)
) ENGINE = InnoDB;
DESC LOJA.DEPARTAMENTO;
+------------------+-------------+------+-----+---------+----------------+
| Field            | Type        | Null | Key | Default | Extra          |
+------------------+-------------+------+-----+---------+----------------+
| COD_DEPARTAMENTO | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOM_DEPARTAMENTO | varchar(45) | NO   |     | NULL    |                |
| IDF_ATIVO        | varchar(1)  | YES  |     | S       |                |
| COD_GRUPO        | int(11)     | YES  | MUL | NULL    |                |
+------------------+-------------+------+-----+---------+----------------+


/*---------------------------------------------------------------------------*/



DROP TABLE IF EXISTS LOJA.CATEGORIA;

CREATE TABLE IF NOT EXISTS LOJA.CATEGORIA (
    COD_CATEGORIA INT NOT NULL AUTO_INCREMENT,
    NOM_CATEGORIA VARCHAR(45) NOT NULL,
    IDF_ATIVO VARCHAR(1) DEFAULT 'S',
    COD_DEPARTAMENTO INT NOT NULL,
    POS_CATEGORIA INT NOT NULL,
    PRIMARY KEY (COD_CATEGORIA),
    FOREIGN KEY (COD_DEPARTAMENTO) REFERENCES LOJA.DEPARTAMENTO(COD_DEPARTAMENTO)
) ENGINE = InnoDB;

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




/*---------------------------------------------------------------------------*/



DROP TABLE IF EXISTS LOJA.FABRICANTE;

CREATE TABLE IF NOT EXISTS LOJA.FABRICANTE (
    COD_FABRICANTE INT NOT NULL AUTO_INCREMENT,
    NOM_FABRICANTE VARCHAR(100) NOT NULL,
    SITE_FABRICANTE VARCHAR(250),
    IDF_ATIVO VARCHAR(1) DEFAULT 'S',
    PRIMARY KEY (COD_FABRICANTE)
) ENGINE = InnoDB;

 DESC LOJA.FABRICANTE;
+-----------------+--------------+------+-----+---------+----------------+
| Field           | Type         | Null | Key | Default | Extra          |
+-----------------+--------------+------+-----+---------+----------------+
| COD_FABRICANTE  | int(11)      | NO   | PRI | NULL    | auto_increment |
| NOM_FABRICANTE  | varchar(100) | NO   |     | NULL    |                |
| SITE_FABRICANTE | varchar(250) | YES  |     | NULL    |                |
| IDF_ATIVO       | varchar(1)   | YES  |     | S       |                |
+-----------------+--------------+------+-----+---------+----------------+



/*---------------------------------------------------------------------------*/



DROP TABLE IF EXISTS LOJA.PRODUTO;

CREATE TABLE IF NOT EXISTS LOJA.PRODUTO (
    COD_PRODUTO INT NOT NULL AUTO_INCREMENT,
    NOM_PRODUTO VARCHAR(250) NOT NULL,
    DSC_PRODUTO LONGTEXT,
    IMG_PRODUTO VARCHAR(250),
    EST_PRODUTO INT DEFAULT 0,
    PCO_PRODUTO DECIMAL(10,2) DEFAULT 0,
    NUM_DIAS_PREV_ENTREGA INT DEFAULT 0,
    COD_CATEGORIA INT NOT NULL,
    COD_FABRICANTE INT NOT NULL,
    PRIMARY KEY (COD_PRODUTO),
    FOREIGN KEY (COD_CATEGORIA) REFERENCES LOJA.CATEGORIA(COD_CATEGORIA),
    FOREIGN KEY (COD_FABRICANTE) REFERENCES LOJA.FABRICANTE(COD_FABRICANTE)
) ENGINE = InnoDB;
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


/*---------------------------------------------------------------------------*/



DROP TABLE IF EXISTS LOJA.CARACTERISTICA;

CREATE TABLE IF NOT EXISTS LOJA.CARACTERISTICA (
    COD_CARACTERISTICA INT NOT NULL AUTO_INCREMENT,
    NOM_CARACTERISTICA VARCHAR(45) NOT NULL,
    IDF_ATIVO VARCHAR(1) DEFAULT 'S',
    PRIMARY KEY (COD_CARACTERISTICA)
) ENGINE = InnoDB;
 DESC LOJA.CARACTERISTICA;
+--------------------+-------------+------+-----+---------+----------------+
| Field              | Type        | Null | Key | Default | Extra          |
+--------------------+-------------+------+-----+---------+----------------+
| COD_CARACTERISTICA | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOM_CARACTERISTICA | varchar(45) | NO   |     | NULL    |                |
| IDF_ATIVO          | varchar(1)  | YES  |     | S       |                |
+--------------------+-------------+------+-----+---------+----------------+


/*---------------------------------------------------------------------------*/


DROP TABLE IF EXISTS LOJA.PRODUTO_CARACTERISTICA;

CREATE TABLE IF NOT EXISTS LOJA.PRODUTO_CARACTERISTICA (
    COD_PRODUTO INT NOT NULL,
    COD_CARACTERISTICA INT NOT NULL,
    SEQ_CARACTERISTICA INT NOT NULL,
    VLR_CARACTERISTICA VARCHAR(100) NOT NULL,
    PRIMARY KEY (COD_PRODUTO, COD_CARACTERISTICA, SEQ_CARACTERISTICA),
    FOREIGN KEY (COD_PRODUTO) REFERENCES LOJA.PRODUTO(COD_PRODUTO),
    FOREIGN KEY (COD_CARACTERISTICA) REFERENCES LOJA.CARACTERISTICA(COD_CARACTERISTICA)
) ENGINE = InnoDB;

 DESC LOJA.PRODUTO_CARACTERISTICA;
+--------------------+--------------+------+-----+---------+-------+
| Field              | Type         | Null | Key | Default | Extra |
+--------------------+--------------+------+-----+---------+-------+
| COD_PRODUTO        | int(11)      | NO   | PRI | NULL    |       |
| COD_CARACTERISTICA | int(11)      | NO   | PRI | NULL    |       |
| SEQ_CARACTERISTICA | int(11)      | NO   | PRI | NULL    |       |
| VLR_CARACTERISTICA | varchar(100) | NO   |     | NULL    |       |
+--------------------+--------------+------+-----+---------+-------+
