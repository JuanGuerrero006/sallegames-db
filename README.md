# 🎮 SalleGames — Base de Datos OLTP

> Sistema de información relacional para una plataforma digital de comercialización de videojuegos.  
> Segunda Entrega — Curso de Bases de Datos

---

## 👥 Equipo de trabajo

| Nombre | Rol en el proyecto |
|---|---|
| Omar Forero Cáceres | Diseño del modelo E-R y diagrama EER en MySQL Workbench |
| Keily Valentina Lasso Guatavita | Normalización, DDL y carga de datos |
| Juan Diego Guerrero | DML, documentación y diario de campo |

---

## 📋 Descripción del proyecto

SalleGames es una plataforma digital de venta de licencias de videojuegos pensada para el mercado colombiano. El sistema gestiona usuarios, catálogo de juegos, compras y asignación de licencias digitales.

La base de datos es de tipo **OLTP** (Online Transaction Processing) con enfoque mixto **CRM + ERP**, implementada en **MySQL 8.x**.

El modelo cuenta con **12 tablas**: 5 principales (transaccionales) y 7 auxiliares (catálogos).

---

## 📁 Archivos del repositorio

| Archivo | Descripción |
|---|---|
| `sallegames_DDL.sql` | Crea la base de datos `sallegames_db` y todas las tablas con sus restricciones, llaves primarias, foráneas e índices |
| `sallegames_DML.sql` | Inserta los datos de prueba (INSERT), aplica modificaciones (UPDATE) y elimina registros (DELETE) |
| `sallegames_FLUJO_compra.sql` | Consultas paso a paso para ver el flujo completo de una compra: usuario → compra → juegos → licencias |
| `sallegames_LIMPIAR_datos.sql` | Borra todos los datos de las tablas sin eliminar la estructura, útil para reiniciar y volver a correr el DML |

---

## ▶️ Cómo usar este proyecto

**Requisito:** tener instalado MySQL 8.x y MySQL Workbench.

```sql
-- Paso 1: Crear la estructura
-- Abrir sallegames_DDL.sql y ejecutar completo

-- Paso 2: Cargar los datos
-- Abrir sallegames_DML.sql y ejecutar completo

-- Paso 3: Explorar el flujo
-- Abrir sallegames_FLUJO_compra.sql
-- Ejecutar cada bloque por separado (seleccionar + Ctrl+Shift+Enter)

-- Si quieres reiniciar desde cero:
-- Ejecutar sallegames_LIMPIAR_datos.sql y luego el DML de nuevo
```

---

## 🗂️ Estructura del modelo

```
pais ──────────── ciudad ──────────── usuario
                                         │
                                       compra ──── metodo_pago
                                         │         estado_compra
                                    detalle_compra
                                         │
                              juego ─────┘──── licencia
                                │
                    genero ─────┤
                    plataforma ─┤
                    desarrollador
```

---

## 🔧 Motor de base de datos

- **MySQL 8.x**
- Administrado con **MySQL Workbench**
- Codificación: `utf8mb4` / `utf8mb4_unicode_ci`
