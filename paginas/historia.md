# El {{ historia_incidencias.prn31_pct[0] }} % de las incidencias del taller salen de PRN-31, con 5 veces la tasa del resto: revisar la máquina antes de finales de abril

PRN-31 acumula {{ historia_incidencias.incidencias_prn31[0] }} incidencias, el {{ historia_incidencias.prn31_pct[0] }} % de
todas las del taller, con {{ historia_incidencias.incidencias_100h_prn31[0] }} incidencias por cada 100 horas de impresión
frente a {{ historia_incidencias.incidencias_100h_taller[0] }} de media. Es también la máquina que más tiempo pasa con la
boquilla fuera del rango de su material, PETG: {{ historia_temperatura.minutos_prn31[0] }} de los
{{ historia_temperatura.minutos_totales[0] }} minutos que suma el taller. Proponemos retirarla para revisión antes del
30 de abril y reasignar sus trabajos PETG mientras tanto.

```grafico
titular: El 53 % de las incidencias del taller salen de PRN-31, que imprime lo mismo que las otras
modelo: pregunta_3
barras: impresora → incidencias_100h
destacar: PRN-31
referencia: historia_incidencias.incidencias_100h_taller · media del taller
```

```grafico
tipo: calor
titular: El patrón aguanta semana a semana: PRN-31 acumula incidencias todas las semanas
modelo: historia_incidencias_semana
filas: impresora
columnas: semana
valor: incidencias
destacar: PRN-31
```

## Qué proponemos

1. **Retirar PRN-31 del servicio para revisión** del termistor y del control de temperatura de la boquilla
   (Taller / Producción, **antes del 30 de abril de 2026**).
2. **Reasignar la cola de trabajos PETG a PRN-59**, la otra impresora PETG, mientras dura la revisión
   (Taller / Producción).

## Qué no sabemos todavía

- Que el tiempo fuera de rango **cause** las incidencias: coinciden en la misma máquina, pero el parte no dice
  qué tipo de fallo es cada incidencia (warping, despegado…), así que la relación es una hipótesis bien fundada, no un hecho.
- No tenemos datos de mantenimiento anterior ni de precios por máquina: no podemos descartar valor de reventa
  o reparación en la decisión.
- Límite de periodo: son nueve semanas, del 2 de febrero al 10 de abril de 2026; ninguna tendencia de largo plazo
  se puede ver con esta muestra.

## La misma historia para cada audiencia

- **Comité de dirección (5 segundos):** «La mitad de las incidencias del taller salen de una sola impresora».
- **Taller / Producción (1 minuto):** «PRN-31 sufre {{ historia_incidencias.incidencias_100h_prn31[0] }} incidencias por
  100 horas, 4 veces la media del taller», y pasa ese tiempo con su PETG fuera de rango. Acción 1: revisión completa
  antes del 30 de abril. Acción 2: el PETG va a PRN-59 mientras tanto.
- **Equipo de datos (5 minutos):** «Incidencias por 100 h de impresión», del parte diario del 2 de febrero al
  10 de abril de 2026: {{ historia_terreno.lineas[0] }} líneas tras quitar duplicados entre remesas y corregir los
  minutos fuera de rango con la mediana de su tipo de pieza. Fuente: sensores de boquilla (pregunta_4) y parte diario (stg_parte).
