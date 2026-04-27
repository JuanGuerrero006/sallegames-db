-- ============================================================
--  SALLEGAMES — Limpiar todos los datos (sin borrar tablas)
--  Útil para volver a correr el DML desde cero
--  Motor: MySQL 8.x / MySQL Workbench
-- ============================================================

USE sallegames_db;

-- Desactivar verificación de FK temporalmente para poder borrar en cualquier orden
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE licencia;
TRUNCATE TABLE detalle_compra;
TRUNCATE TABLE compra;
TRUNCATE TABLE juego;
TRUNCATE TABLE usuario;
TRUNCATE TABLE metodo_pago;
TRUNCATE TABLE estado_compra;
TRUNCATE TABLE desarrollador;
TRUNCATE TABLE plataforma;
TRUNCATE TABLE genero;
TRUNCATE TABLE ciudad;
TRUNCATE TABLE pais;

-- Reactivar verificación de FK
SET FOREIGN_KEY_CHECKS = 1;

-- Verificar que quedó vacío
SELECT 'pais'           AS tabla, COUNT(*) AS registros FROM pais           UNION ALL
SELECT 'ciudad',                  COUNT(*)              FROM ciudad          UNION ALL
SELECT 'genero',                  COUNT(*)              FROM genero          UNION ALL
SELECT 'plataforma',              COUNT(*)              FROM plataforma      UNION ALL
SELECT 'desarrollador',           COUNT(*)              FROM desarrollador   UNION ALL
SELECT 'metodo_pago',             COUNT(*)              FROM metodo_pago     UNION ALL
SELECT 'estado_compra',           COUNT(*)              FROM estado_compra   UNION ALL
SELECT 'usuario',                 COUNT(*)              FROM usuario         UNION ALL
SELECT 'juego',                   COUNT(*)              FROM juego           UNION ALL
SELECT 'compra',                  COUNT(*)              FROM compra          UNION ALL
SELECT 'detalle_compra',          COUNT(*)              FROM detalle_compra  UNION ALL
SELECT 'licencia',                COUNT(*)              FROM licencia;