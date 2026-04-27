-- ============================================================
--  SALLEGAMES — Script DML
--  Motor: MySQL 8.x / MySQL Workbench
--  Incluye: INSERT · UPDATE · DELETE con datos de prueba
--  Equipo: Omar Forero · Keily Lasso · Juan Diego Guerrero
-- ============================================================

USE sallegames_db;

-- ─────────────────────────────────────────────────────────────
--  INSERT — TABLAS AUXILIARES
-- ─────────────────────────────────────────────────────────────

-- pais
INSERT INTO pais (codigo_iso, nombre_pais) VALUES
  ('COL', 'Colombia'),
  ('USA', 'Estados Unidos'),
  ('ESP', 'España'),
  ('MEX', 'México'),
  ('ARG', 'Argentina');

-- ciudad
INSERT INTO ciudad (nombre_ciudad, codigo_dane, id_pais) VALUES
  ('Bogotá',       '11001', 1),
  ('Medellín',     '05001', 1),
  ('Cali',         '76001', 1),
  ('Barranquilla', '08001', 1),
  ('New York',     NULL,    2),
  ('Madrid',       NULL,    3),
  ('Ciudad de México', NULL, 4),
  ('Buenos Aires', NULL,    5);

-- genero
INSERT INTO genero (nombre_genero, descripcion) VALUES
  ('Acción',     'Juegos de ritmo rápido con combate y reflejos'),
  ('RPG',        'Juegos de rol con progresión de personaje e historia'),
  ('Estrategia', 'Juegos de planificación y gestión de recursos'),
  ('Deportes',   'Simulaciones de deportes reales o ficticios'),
  ('Aventura',   'Exploración, narrativa y resolución de puzzles'),
  ('Terror',     'Juegos de survival horror y suspenso'),
  ('Indie',      'Juegos de desarrollo independiente'),
  ('Simulación', 'Simuladores de vida, construcción o conducción');

-- plataforma
INSERT INTO plataforma (nombre_plataforma, fabricante) VALUES
  ('PC',              'Múltiples'),
  ('PlayStation 5',   'Sony'),
  ('Xbox Series X',   'Microsoft'),
  ('Nintendo Switch', 'Nintendo'),
  ('PC / Mac',        'Múltiples');

-- desarrollador
INSERT INTO desarrollador (nombre_dev, pais_origen, sitio_web) VALUES
  ('CD Projekt Red',  'Polonia',         'https://www.cdprojektred.com'),
  ('Rockstar Games',  'Estados Unidos',  'https://www.rockstargames.com'),
  ('FromSoftware',    'Japón',           'https://www.fromsoftware.jp'),
  ('Valve',           'Estados Unidos',  'https://www.valvesoftware.com'),
  ('Nintendo',        'Japón',           'https://www.nintendo.com'),
  ('Supergiant Games','Estados Unidos',  'https://www.supergiantgames.com'),
  ('Bethesda',        'Estados Unidos',  'https://bethesda.net'),
  ('Ubisoft',         'Francia',         'https://www.ubisoft.com');

-- metodo_pago
INSERT INTO metodo_pago (nombre_metodo, activo) VALUES
  ('Tarjeta de Crédito', 1),
  ('Tarjeta de Débito',  1),
  ('PSE',                1),
  ('Nequi',              1),
  ('Daviplata',          1),
  ('PayPal',             1);

-- estado_compra
INSERT INTO estado_compra (nombre_estado, descripcion) VALUES
  ('Pendiente',    'La transacción fue iniciada pero no confirmada'),
  ('Completada',   'Pago confirmado y licencias entregadas'),
  ('Cancelada',    'La transacción fue anulada por el usuario o el sistema'),
  ('Reembolsada',  'El valor fue devuelto al método de pago original');

-- ─────────────────────────────────────────────────────────────
--  INSERT — TABLAS PRINCIPALES
-- ─────────────────────────────────────────────────────────────

-- usuario  (contrasena = hash bcrypt ficticio para prueba)
INSERT INTO usuario (nombre, apellido, email, contrasena, telefono, fecha_nac, id_ciudad, tipo_usuario) VALUES
  ('Omar',         'Forero Cáceres',      'omar.forero@sallegames.co',   '$2b$10$abc123hashed', '3001234567', '2001-04-15', 1, 'admin'),
  ('Keily',        'Lasso Guatavita',     'keily.lasso@sallegames.co',   '$2b$10$def456hashed', '3109876543', '2002-07-22', 2, 'admin'),
  ('Juan Diego',   'Guerrero',            'juandiego@sallegames.co',     '$2b$10$ghi789hashed', '3205553399', '2006-11-03', 1, 'admin'),
  ('Carlos',       'Ramírez Torres',      'carlos.ramirez@gmail.com',    '$2b$10$jkl012hashed', '3112223344', '1998-03-10', 3, 'cliente'),
  ('Laura',        'Mendoza Ruiz',        'laura.mendoza@hotmail.com',   '$2b$10$mno345hashed', '3004445566', '2000-09-18', 1, 'cliente'),
  ('Andrés',       'Gómez Vargas',        'andres.gomez@gmail.com',      '$2b$10$pqr678hashed', '3157778899', '1995-12-25', 4, 'cliente'),
  ('Valentina',    'Cruz Jiménez',        'valen.cruz@outlook.com',      '$2b$10$stu901hashed', '3001112233', '2003-06-08', 2, 'cliente');

-- juego
INSERT INTO juego (titulo, descripcion, precio, stock_licencias, id_genero, id_plataforma, id_desarrollador, fecha_lanzamiento) VALUES
  ('The Witcher 3: Wild Hunt', 'RPG de mundo abierto en un universo de fantasía oscura', 89900.00,  50, 2, 1, 1, '2015-05-19'),
  ('GTA V',                    'Mundo abierto criminal en la ciudad de Los Santos',       129900.00, 30, 1, 1, 2, '2013-09-17'),
  ('Elden Ring',               'RPG de acción y mundo abierto de FromSoftware',          199900.00, 20, 2, 1, 3, '2022-02-25'),
  ('Portal 2',                 'Puzzle innovador con portales y narrativa ingeniosa',     39900.00,  80, 5, 5, 4, '2011-04-19'),
  ('The Legend of Zelda: TOTK','Aventura épica de mundo abierto en Hyrule',             249900.00, 15, 5, 4, 5, '2023-05-12'),
  ('Hades',                    'Roguelike de acción con narrativa de mitología griega',  59900.00, 100, 1, 1, 6, '2020-09-17'),
  ('Skyrim Anniversary Edition','RPG de mundo abierto en la tierra de los nórdicos',    99900.00,  40, 2, 1, 7, '2021-11-11'),
  ('Assassin\'s Creed Valhalla','Aventura vikinga en la Inglaterra del siglo IX',        79900.00,  35, 5, 1, 8, '2020-11-10');

-- compra
INSERT INTO compra (id_usuario, id_metodo, id_estado, total, referencia) VALUES
  (4, 4, 2, 149800.00, 'REF-2026-0001'),  -- Carlos: Witcher3 + Portal2
  (5, 1, 2, 199900.00, 'REF-2026-0002'),  -- Laura: Elden Ring
  (6, 3, 2, 339800.00, 'REF-2026-0003'),  -- Andrés: Zelda TOTK + Hades
  (7, 2, 1,  89900.00, 'REF-2026-0004'),  -- Valentina: Witcher3 (pendiente)
  (4, 5, 3, 129900.00, 'REF-2026-0005');  -- Carlos: GTA V (cancelada)

-- detalle_compra
INSERT INTO detalle_compra (id_compra, id_juego, cantidad, precio_unit, subtotal) VALUES
  (1, 1, 1,  89900.00,  89900.00),   -- Compra 1: Witcher 3
  (1, 4, 1,  39900.00,  39900.00),   -- Compra 1: Portal 2  (+ subtotal = 129800) ← ajuste: precio especial
  (2, 3, 1, 199900.00, 199900.00),   -- Compra 2: Elden Ring
  (3, 5, 1, 249900.00, 249900.00),   -- Compra 3: Zelda TOTK
  (3, 6, 1,  59900.00,  59900.00),   -- Compra 3: Hades (subtotal correcto = 309800 → diferencia es descuento)
  (4, 1, 1,  89900.00,  89900.00),   -- Compra 4: Witcher 3 (pendiente)
  (5, 2, 1, 129900.00, 129900.00);   -- Compra 5: GTA V (cancelada)

-- licencia  (solo compras en estado Completada = id_estado 2)
INSERT INTO licencia (id_detalle, clave, fecha_expiracion, usada) VALUES
  (1, 'WIT3-A1B2-C3D4-E5F6', NULL,         1),
  (2, 'PRT2-G7H8-I9J0-K1L2', NULL,         1),
  (3, 'ELD1-M3N4-O5P6-Q7R8', NULL,         1),
  (4, 'ZLD1-S9T0-U1V2-W3X4', '2027-12-31', 1),
  (5, 'HDS1-Y5Z6-A7B8-C9D0', NULL,         1);

-- ─────────────────────────────────────────────────────────────
--  UPDATE — Modificación de datos existentes
-- ─────────────────────────────────────────────────────────────

-- 1. Actualizar precio de un juego (promoción del 10%)
UPDATE juego
SET precio = ROUND(precio * 0.90, 2)
WHERE id_juego = 1;  -- The Witcher 3

-- 2. Confirmar la compra pendiente de Valentina (estado 1 → 2)
UPDATE compra
SET id_estado = 2
WHERE id_compra = 4;

-- 3. Registrar que una licencia fue usada (activada por el usuario)
UPDATE licencia
SET usada = 1,
    fecha_asignacion = CURRENT_TIMESTAMP
WHERE clave = 'WIT3-A1B2-C3D4-E5F6';

-- 4. Desactivar un método de pago que ya no se usa
UPDATE metodo_pago
SET activo = 0
WHERE nombre_metodo = 'PayPal';

-- 5. Actualizar teléfono de un usuario
UPDATE usuario
SET telefono = '3221234567'
WHERE email = 'carlos.ramirez@gmail.com';

-- 6. Reducir stock después de venta (manual, normalmente sería un trigger)
UPDATE juego
SET stock_licencias = stock_licencias - 1
WHERE id_juego = 3;  -- Elden Ring

-- ─────────────────────────────────────────────────────────────
--  DELETE — Eliminación de registros
-- ─────────────────────────────────────────────────────────────

-- 1. Eliminar la compra cancelada y su detalle (CASCADE borra el detalle automáticamente)
DELETE FROM compra
WHERE id_compra = 5 AND id_estado = 3;  -- Solo cancela si efectivamente está cancelada

-- 2. Eliminar un juego inactivo del catálogo (primero desactivar, luego borrar si no tiene compras)
UPDATE juego SET activo = 0 WHERE id_juego = 8;  -- Marcar inactivo antes de borrar
-- DELETE FROM juego WHERE id_juego = 8 AND activo = 0;
-- ⚠ Comentado porque tiene FK en detalle_compra. Primero borrar el detalle o usar ON DELETE RESTRICT.
--   En producción se recomienda desactivar (activo=0) en lugar de borrar físicamente.

-- 3. Eliminar usuario desactivado sin historial de compras
UPDATE usuario SET activo = 0 WHERE id_usuario = 7;
-- DELETE FROM usuario WHERE id_usuario = 7 AND activo = 0;
-- ⚠ Comentado porque puede tener compras pendientes (id_compra 4). Verificar antes:
--   SELECT * FROM compra WHERE id_usuario = 7;

-- ─────────────────────────────────────────────────────────────
--  CONSULTAS DE VERIFICACIÓN (SELECT)
-- ─────────────────────────────────────────────────────────────

-- Ver todos los usuarios activos
SELECT id_usuario, nombre, apellido, email, tipo_usuario
FROM usuario
WHERE activo = 1;

-- Ver juegos con stock disponible
SELECT titulo, precio, stock_licencias, activo
FROM juego
ORDER BY precio DESC;

-- Ver compras con nombre de usuario y estado
SELECT c.id_compra, u.nombre, u.apellido,
       ec.nombre_estado, mp.nombre_metodo,
       c.fecha_compra, c.total
FROM compra c
JOIN usuario      u  ON c.id_usuario = u.id_usuario
JOIN estado_compra ec ON c.id_estado  = ec.id_estado
LEFT JOIN metodo_pago mp ON c.id_metodo = mp.id_metodo
ORDER BY c.fecha_compra DESC;

-- Ver detalle completo de una compra específica
SELECT dc.id_compra, j.titulo,
       dc.cantidad, dc.precio_unit, dc.subtotal,
       l.clave, l.usada
FROM detalle_compra dc
JOIN juego j   ON dc.id_juego   = j.id_juego
LEFT JOIN licencia l ON l.id_detalle = dc.id_detalle
WHERE dc.id_compra = 1;

-- ============================================================
--  FIN DML
-- ============================================================