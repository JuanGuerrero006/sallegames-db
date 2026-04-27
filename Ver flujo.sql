-- ============================================================
--  SALLEGAMES — Ver una compra de inicio a fin
--  Ejecuta cada bloque por separado (selecciona + Ctrl+Shift+Enter)
--  Motor: MySQL 8.x / MySQL Workbench
-- ============================================================

USE sallegames_db;

-- ─────────────────────────────────────────────────────────────
--  PASO 1 — ¿Quién es el usuario que compró?
-- ─────────────────────────────────────────────────────────────

SELECT 
    u.id_usuario,
    CONCAT(u.nombre, ' ', u.apellido)  AS nombre_completo,
    u.email,
    u.telefono,
    c.nombre_ciudad                    AS ciudad,
    p.nombre_pais                      AS pais,
    u.tipo_usuario,
    u.fecha_registro
FROM usuario u
JOIN ciudad c ON u.id_ciudad = c.id_ciudad
JOIN pais   p ON c.id_pais   = p.id_pais
WHERE u.id_usuario = 5;   

-- ─────────────────────────────────────────────────────────────
--  PASO 2 — ¿Qué compras tiene ese usuario?
-- ─────────────────────────────────────────────────────────────

SELECT
    c.id_compra,
    c.fecha_compra,
    ec.nombre_estado                   AS estado,
    mp.nombre_metodo                   AS metodo_pago,
    c.total,
    c.referencia
FROM compra c
JOIN estado_compra ec ON c.id_estado = ec.id_estado
LEFT JOIN metodo_pago mp ON c.id_metodo = mp.id_metodo
WHERE c.id_usuario = 5  
ORDER BY c.fecha_compra DESC;

-- ─────────────────────────────────────────────────────────────
--  PASO 3 — ¿Qué juegos tiene esa compra?
-- ─────────────────────────────────────────────────────────────

SELECT
    dc.id_detalle,
    j.titulo                           AS juego,
    g.nombre_genero                    AS genero,
    pl.nombre_plataforma               AS plataforma,
    d.nombre_dev                       AS desarrollador,
    dc.cantidad,
    dc.precio_unit,
    dc.subtotal
FROM detalle_compra dc
JOIN juego       j  ON dc.id_juego       = j.id_juego
JOIN genero      g  ON j.id_genero       = g.id_genero
JOIN plataforma  pl ON j.id_plataforma   = pl.id_plataforma
JOIN desarrollador d ON j.id_desarrollador = d.id_desarrollador
WHERE dc.id_compra = 2;   

-- ─────────────────────────────────────────────────────────────
--  PASO 4 — ¿Qué licencias se generaron?
-- ─────────────────────────────────────────────────────────────

SELECT
    l.id_licencia,
    j.titulo                           AS juego,
    l.clave                            AS clave_activacion,
    l.fecha_asignacion,
    l.fecha_expiracion,
    CASE l.usada
        WHEN 1 THEN '✅ Activada'
        WHEN 0 THEN '⏳ Sin activar'
    END                                AS estado_licencia
FROM licencia l
JOIN detalle_compra dc ON l.id_detalle = dc.id_detalle
JOIN juego          j  ON dc.id_juego  = j.id_juego
WHERE dc.id_compra = 2;   

-- ─────────────────────────────────────────────────────────────
--  PASO 5 — RESUMEN COMPLETO en una sola consulta
--  (Todo junto: usuario → compra → juego → licencia)
-- ─────────────────────────────────────────────────────────────

SELECT
    CONCAT(u.nombre, ' ', u.apellido)  AS cliente,
    u.email,
    c.id_compra,
    c.fecha_compra,
    ec.nombre_estado                   AS estado_compra,
    mp.nombre_metodo                   AS metodo_pago,
    j.titulo                           AS juego,
    g.nombre_genero                    AS genero,
    pl.nombre_plataforma               AS plataforma,
    dc.precio_unit                     AS precio_pagado,
    l.clave                            AS licencia,
    CASE l.usada
        WHEN 1 THEN '✅ Activada'
        WHEN 0 THEN '⏳ Sin activar'
    END                                AS estado_licencia,
    c.total                            AS total_compra
FROM compra c
JOIN usuario        u  ON c.id_usuario      = u.id_usuario
JOIN estado_compra  ec ON c.id_estado       = ec.id_estado
LEFT JOIN metodo_pago mp ON c.id_metodo     = mp.id_metodo
JOIN detalle_compra dc ON dc.id_compra      = c.id_compra
JOIN juego          j  ON dc.id_juego       = j.id_juego
JOIN genero         g  ON j.id_genero       = g.id_genero
JOIN plataforma     pl ON j.id_plataforma   = pl.id_plataforma
LEFT JOIN licencia  l  ON l.id_detalle      = dc.id_detalle
WHERE c.id_compra = 2  
ORDER BY dc.id_detalle;