# Pruebas del lector OCR

- **Proyecto:** bingo-app (Flutter + Google ML Kit)
- **Fecha:** 30 de octubre de 2026
- **Dispositivo:** celular Android físico
- **Método:** fotos de tablas reales cargadas desde la galería, recortadas en la app y comparadas casilla por casilla contra la tabla física.

## Cómo se mide

| Columna | Qué significa |
|---|---|
| Bien leídas | Casillas con el número correcto en la posición correcta (máximo 24) |
| En amarillo | Casillas marcadas para que el usuario las revise |
| Falsas alarmas | Casillas bien leídas que igual quedaron en amarillo |
| Mal sin aviso | Casillas con un número equivocado y **sin** amarillo. Es el indicador más importante: el usuario no tiene cómo notarlo |

**Metas de la Fase 3:** 90 % de casillas bien leídas (21,6 de 24) y 0 errores sin aviso.

---

## Versión 1 del intérprete

| # | Modelo de tabla | Bien leídas | En amarillo | Falsas alarmas | Mal sin aviso | Causa de lo que faltó |
|---|---|---|---|---|---|---|
| 1 | Roja, números hasta 90 | 3 | 15 | 0 | 7 | No es bingo de 75 balotas |
| 2 | Encabezado negro | 23 | 3 | 2 | 0 | El 70 se leyó "7o" (letra o) |
| 3 | Colores, mapache | 24 | 1 | 1 | 0 | — |
| 4 | Azul, monstruo | 22 | 4 | 2 | 0 | "9" y "23" pegados se leyeron "92" |
| 5 | Blanca, FREE SPACE | 24 | 1 | 1 | 0 | — |
| 6 | Blanca, FREE SPACE (repetida) | 23 | 1 | 0 | 0 | El 8 se leyó dos veces: "88" |
| 7 | Azul, ".es" en el centro | 24 | 1 | 1 | 0 | — |

**Resumen v1 (tablas de 75 balotas, pruebas 2 a 7):** 140 de 144 casillas bien leídas (97 %), 0 errores sin aviso, 7 falsas alarmas.

## Mejoras aplicadas en la versión 2

1. Una "o" pegada a un dígito se interpreta como 0.
2. Dos cifras pegadas no se unen si el número empezaría por 0 o pasaría de 75.
3. Aviso en pantalla cuando la tabla parece de otro formato (por ejemplo, 90 balotas).

Cada mejora quedó cubierta por una prueba automática en `test/dominio/interpretar_carton_test.dart`.

---

## Versión 2 del intérprete

| # | Modelo de tabla | Bien leídas | En amarillo | Falsas alarmas | Mal sin aviso | Observación |
|---|---|---|---|---|---|---|
| 1 | Roja, números hasta 90 | No aplica | 17 | — | Con aviso | Se mostró el aviso de formato no compatible ✅ |
| 2 | Encabezado negro | 24 | 1 | 1 | 0 | Antes 23. Leyó correctamente el 70 |
| 4 | Azul, monstruo | 24 | 3 | 3 | 0 | Antes 22. Ya no une el "9" con el "23" |
| 8 | Verde, "España" en el centro (nueva) | 22 | 2 | 0 | 0 | El OCR ubicó mal el recuadro del 4 ("4."); se perdieron el 4 y el 28, ambos en amarillo |

### Comparación en las fotos repetidas (pruebas 2 y 4)

| Versión | Bien leídas | Mal sin aviso |
|---|---|---|
| v1 | 45 de 48 (94 %) | 0 |
| v2 | 48 de 48 (100 %) | 0 |

### Resumen v2 (tablas de 75 balotas: pruebas 2, 4 y 8)

- Casillas bien leídas: **70 de 72 (97 %)**. Meta: 90 %. ✅
- Errores sin aviso: **0**. Meta: 0. ✅
- Tabla de otro formato: **detectada y advertida**. ✅
- Falsas alarmas: 4, todas en números de una cifra de la columna B.

---

## Conclusiones

1. El lector cumple las metas de la Fase 3 con margen.
2. Cuando falla, falla de forma segura: las casillas que no puede leer quedan en amarillo y ningún número equivocado pasa sin aviso.
3. Trabajar a nivel de caracteres (y no con el encabezado B-I-N-G-O) fue la decisión clave: el encabezado se leyó mal en casi todas las fotos ("BINGC", "BDN", "BI", "NG").

## Pendientes

- Repetir con la versión 2 las pruebas 3, 5, 6 y 7.
- Reducir falsas alarmas en números de una cifra: comparar su posición con la de los otros números de una cifra de la misma columna, en lugar de con el promedio de toda la columna.
- La corrección de la "o" está verificada con prueba automática; en la repetición de la prueba 2 el OCR leyó el 0 directamente, así que falta una foto real que la confirme.
- Evaluar soporte para bingo de 90 balotas en una versión futura.
