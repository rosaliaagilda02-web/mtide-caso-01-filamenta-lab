
# 2 · El oro

## Nuestro modelo de datos

Hemos creado un modelo de datos que permite analizar los trabajos de impresión 3D de Filamenta Lab de forma organizada.

La tabla `fact_trabajos` contiene {{ fact_trabajos.filas }} trabajos, con una fila por pedido. Cada registro incluye información sobre el operario, la impresora, el tipo de pieza, los minutos de impresión, el filamento consumido, los ingresos y las incidencias.

Esta tabla se relaciona con tres dimensiones: `dim_operario`, `dim_impresora` y `dim_tipo_pieza`. Estas permiten estudiar los resultados desde diferentes perspectivas sin duplicar los trabajos.

## Pregunta 1. ¿Qué tipo de pieza genera menos ingresos por hora?

El tipo de pieza que genera menos ingresos por hora de impresión es **{{ pregunta_1.tipo_pieza[0] }}**, con **{{ pregunta_1.ingreso_hora[0] }} €/hora**.

Esto indica que esta categoría obtiene menos ingresos en relación con el tiempo de impresión utilizado. Por tanto, sería conveniente revisar sus precios y tiempos de producción.

## Pregunta 2. ¿Qué operario consume más filamento por hora?

El operario con mayor consumo de filamento por hora es **{{ pregunta_2.operario[0] }}**, con **{{ pregunta_2.g_hora[0] }} gramos por hora**.

Este resultado permite identificar dónde se concentra un mayor consumo de material. Sin embargo, no significa necesariamente que el operario trabaje de forma menos eficiente, ya que el consumo también depende del tipo de pieza que imprime.

## Pregunta 3. ¿Qué impresora acumula más incidencias?

La impresora con más incidencias relativas es **{{ pregunta_3.impresora[0] }}**, con **{{ pregunta_3.incidencias_100h[0] }} incidencias por cada 100 horas de impresión**.

Este resultado sugiere que sería recomendable revisar su mantenimiento y funcionamiento para reducir las incidencias y evitar posibles costes adicionales.

## Comparación con la Jornada 3

Después de incorporar la nueva remesa y corregir los errores de consumo, las tres conclusiones principales se mantienen.

Las figuras siguen generando menos ingresos por hora, Nerea Molina continúa registrando el mayor consumo de filamento y la impresora PRN-31 sigue acumulando más incidencias relativas.

Aunque los valores han cambiado ligeramente al incorporar nuevos trabajos, las posiciones principales se mantienen. Esto permite confirmar que los problemas identificados en el análisis inicial siguen siendo relevantes para Filamenta Lab.
