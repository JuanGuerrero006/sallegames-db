-- ============================================================
--  SALLEGAMES — Script DDL
--  Motor: MySQL 8.x / MySQL Workbench
--  Orden de creación: auxiliares → principales
--  Equipo: Omar Forero · Keily Lasso · Juan Diego Guerrero
-- ============================================================

DROP DATABASE IF EXISTS sallegames_db;
CREATE DATABASE sallegames_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE sallegames_db;

-- ─────────────────────────────────────────────────────────────
--  TABLAS AUXILIARES (catálogos)
-- ─────────────────────────────────────────────────────────────

CREATE TABLE pais (
  id_pais     INT          NOT NULL AUTO_INCREMENT,
  codigo_iso  CHAR(3)      NOT NULL,
  nombre_pais VARCHAR(100) NOT NULL,
  CONSTRAINT pk_pais      PRIMARY KEY (id_pais),
  CONSTRAINT uq_pais_iso  UNIQUE      (codigo_iso)
);

CREATE TABLE ciudad (
  id_ciudad     INT          NOT NULL AUTO_INCREMENT,
  nombre_ciudad VARCHAR(100) NOT NULL,
  codigo_dane   VARCHAR(10)  NULL,
  id_pais       INT          NOT NULL,
  CONSTRAINT pk_ciudad    PRIMARY KEY (id_ciudad),
  CONSTRAINT fk_ciudad_pais
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE genero (
  id_genero     INT          NOT NULL AUTO_INCREMENT,
  nombre_genero VARCHAR(80)  NOT NULL,
  descripcion   VARCHAR(255) NULL,
  CONSTRAINT pk_genero    PRIMARY KEY (id_genero),
  CONSTRAINT uq_genero    UNIQUE      (nombre_genero)
);

CREATE TABLE plataforma (
  id_plataforma     INT         NOT NULL AUTO_INCREMENT,
  nombre_plataforma VARCHAR(80) NOT NULL,
  fabricante        VARCHAR(80) NULL,
  CONSTRAINT pk_plataforma  PRIMARY KEY (id_plataforma),
  CONSTRAINT uq_plataforma  UNIQUE      (nombre_plataforma)
);

CREATE TABLE desarrollador (
  id_desarrollador INT          NOT NULL AUTO_INCREMENT,
  nombre_dev       VARCHAR(120) NOT NULL,
  pais_origen      VARCHAR(80)  NULL,
  sitio_web        VARCHAR(200) NULL,
  CONSTRAINT pk_desarrollador PRIMARY KEY (id_desarrollador)
);

CREATE TABLE metodo_pago (
  id_metodo     INT         NOT NULL AUTO_INCREMENT,
  nombre_metodo VARCHAR(80) NOT NULL,
  activo        TINYINT(1)  NOT NULL DEFAULT 1,
  CONSTRAINT pk_metodo_pago PRIMARY KEY (id_metodo),
  CONSTRAINT uq_metodo      UNIQUE     (nombre_metodo),
  CONSTRAINT ck_metodo_activo CHECK (activo IN (0, 1))
);

CREATE TABLE estado_compra (
  id_estado     INT          NOT NULL AUTO_INCREMENT,
  nombre_estado VARCHAR(60)  NOT NULL,
  descripcion   VARCHAR(200) NULL,
  CONSTRAINT pk_estado_compra PRIMARY KEY (id_estado),
  CONSTRAINT uq_estado        UNIQUE      (nombre_estado)
);

-- ─────────────────────────────────────────────────────────────
--  TABLAS PRINCIPALES (transaccionales)
-- ─────────────────────────────────────────────────────────────

CREATE TABLE usuario (
  id_usuario      INT          NOT NULL AUTO_INCREMENT,
  nombre          VARCHAR(100) NOT NULL,
  apellido        VARCHAR(100) NOT NULL,
  email           VARCHAR(150) NOT NULL,
  contrasena      VARCHAR(255) NOT NULL,
  telefono        VARCHAR(20)  NULL,
  fecha_nac       DATE         NULL,
  id_ciudad       INT          NULL,
  tipo_usuario    ENUM('cliente','admin') NOT NULL DEFAULT 'cliente',
  fecha_registro  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  activo          TINYINT(1)   NOT NULL DEFAULT 1,
  CONSTRAINT pk_usuario       PRIMARY KEY (id_usuario),
  CONSTRAINT uq_usuario_email UNIQUE      (email),
  CONSTRAINT ck_usuario_activo CHECK (activo IN (0, 1)),
  CONSTRAINT fk_usuario_ciudad
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
    ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE INDEX idx_usuario_email ON usuario(email);

CREATE TABLE juego (
  id_juego           INT           NOT NULL AUTO_INCREMENT,
  titulo             VARCHAR(200)  NOT NULL,
  descripcion        TEXT          NULL,
  precio             DECIMAL(10,2) NOT NULL,
  stock_licencias    INT           NOT NULL DEFAULT 0,
  id_genero          INT           NULL,
  id_plataforma      INT           NULL,
  id_desarrollador   INT           NULL,
  fecha_lanzamiento  DATE          NULL,
  imagen_url         VARCHAR(255)  NULL,
  activo             TINYINT(1)    NOT NULL DEFAULT 1,
  CONSTRAINT pk_juego         PRIMARY KEY (id_juego),
  CONSTRAINT ck_juego_precio  CHECK (precio >= 0),
  CONSTRAINT ck_juego_stock   CHECK (stock_licencias >= 0),
  CONSTRAINT ck_juego_activo  CHECK (activo IN (0, 1)),
  CONSTRAINT fk_juego_genero
    FOREIGN KEY (id_genero) REFERENCES genero(id_genero)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_juego_plataforma
    FOREIGN KEY (id_plataforma) REFERENCES plataforma(id_plataforma)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_juego_dev
    FOREIGN KEY (id_desarrollador) REFERENCES desarrollador(id_desarrollador)
    ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE INDEX idx_juego_titulo ON juego(titulo);

CREATE TABLE compra (
  id_compra    INT           NOT NULL AUTO_INCREMENT,
  id_usuario   INT           NOT NULL,
  id_metodo    INT           NULL,
  id_estado    INT           NOT NULL,
  fecha_compra DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  total        DECIMAL(12,2) NOT NULL,
  referencia   VARCHAR(60)   NULL,
  CONSTRAINT pk_compra        PRIMARY KEY (id_compra),
  CONSTRAINT uq_compra_ref    UNIQUE      (referencia),
  CONSTRAINT ck_compra_total  CHECK (total >= 0),
  CONSTRAINT fk_compra_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_compra_metodo
    FOREIGN KEY (id_metodo) REFERENCES metodo_pago(id_metodo)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_compra_estado
    FOREIGN KEY (id_estado) REFERENCES estado_compra(id_estado)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE INDEX idx_compra_usuario ON compra(id_usuario);
CREATE INDEX idx_compra_fecha   ON compra(fecha_compra);

CREATE TABLE detalle_compra (
  id_detalle   INT           NOT NULL AUTO_INCREMENT,
  id_compra    INT           NOT NULL,
  id_juego     INT           NOT NULL,
  cantidad     INT           NOT NULL DEFAULT 1,
  precio_unit  DECIMAL(10,2) NOT NULL,
  subtotal     DECIMAL(12,2) NOT NULL,
  CONSTRAINT pk_detalle       PRIMARY KEY (id_detalle),
  CONSTRAINT ck_det_cantidad  CHECK (cantidad > 0),
  CONSTRAINT ck_det_precio    CHECK (precio_unit >= 0),
  CONSTRAINT fk_detalle_compra
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_detalle_juego
    FOREIGN KEY (id_juego) REFERENCES juego(id_juego)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE licencia (
  id_licencia       INT          NOT NULL AUTO_INCREMENT,
  id_detalle        INT          NOT NULL,
  clave             VARCHAR(100) NOT NULL,
  fecha_asignacion  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_expiracion  DATE         NULL,
  usada             TINYINT(1)   NOT NULL DEFAULT 0,
  CONSTRAINT pk_licencia      PRIMARY KEY (id_licencia),
  CONSTRAINT uq_licencia_clave UNIQUE      (clave),
  CONSTRAINT ck_lic_usada      CHECK (usada IN (0, 1)),
  CONSTRAINT fk_licencia_detalle
    FOREIGN KEY (id_detalle) REFERENCES detalle_compra(id_detalle)
    ON UPDATE CASCADE ON DELETE CASCADE
);

-- ============================================================
--  FIN DDL
-- ============================================================