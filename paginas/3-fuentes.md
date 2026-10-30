
# 3 · Fuentes nuevas

## Incorporación de nuevas fuentes

En este bloque hemos incorporado tres archivos a la capa bronce de Filamenta Lab:

- `materiales.csv`: contiene los materiales, sus temperaturas recomendadas y su coste por kilogramo.
- `impresoras.csv`: indica qué material utiliza cada impresora.
- `lecturas_boquilla_2026-04-13.json`: contiene las mediciones de temperatura realizadas por los sensores.

Después creamos tres modelos de plata: `stg_materiales`, `stg_impresoras` y `stg_eventos`.

El registro contiene **{{ stg_eventos.filas }} lecturas de temperatura**, procedentes de ocho impresoras, registradas el 13 de abril de 2026.

## El problema de las lecturas desordenadas

Los sensores envían las mediciones por wifi y algunas llegan al servidor con retraso. Por eso, el orden en que aparecen los registros no coincide necesariamente con el momento en que se realizaron las mediciones.

Para resolverlo, utilizamos `ts_lectura`, que representa la fecha y hora real de cada medición.

Mediante la función SQL `LEAD()`, ordenamos las lecturas de cada impresora cronológicamente y calculamos el tiempo transcurrido hasta la siguiente medición.

De esta forma podemos estimar cuánto tiempo permanece cada impresora fuera del rango de temperatura recomendado para su material.

Si hubiéramos utilizado el orden de llegada, los intervalos de tiempo podrían haber sido incorrectos y los resultados del análisis no serían fiables.

## El test de consumo de filamento

Creamos el test singular `consumo_por_minuto.sql`, que comprueba que una impresora FDM consuma entre 0,1 y 1 gramo de filamento por minuto.

Para demostrar su funcionamiento, realizamos una prueba sobre los datos originales de la remesa del 11 de abril.

El test detectó **9 registros incorrectos**, debido a que determinados consumos de la impresora PRN-16 estaban expresados en kilogramos en lugar de gramos.

Después de aplicar la corrección en la capa plata, el test definitivo pasó correctamente, sin detectar incumplimientos.

Esto demuestra la importancia de realizar controles de calidad y corregir los datos antes de utilizarlos para tomar decisiones.

## Pregunta 4. ¿Qué impresora pasa más tiempo fuera de su temperatura recomendada?

La impresora que acumula más tiempo fuera del rango de temperatura de su material es **{{ pregunta_4.impresora[0] }}**, que utiliza **{{ pregunta_4.material[0] }}**.

Se han identificado **{{ pregunta_4.lecturas_fuera_rango[0] }} lecturas fuera del rango**, equivalentes a aproximadamente **{{ pregunta_4.minutos_fuera_rango[0] }} minutos**.

Esta impresora utiliza PETG, cuya temperatura recomendada se encuentra entre 230 y 250 °C.

## Relación con las incidencias del Bloque 2

En el Bloque 2 descubrimos que la impresora PRN-31 era la que presentaba más incidencias, con 6,61 por cada 100 horas de impresión.

Ahora observamos que esa misma impresora es también la que acumula más tiempo fuera de su rango de temperatura recomendado.

Esta coincidencia sugiere que las desviaciones de temperatura podrían estar relacionadas con las incidencias registradas.

Sin embargo, no podemos asegurar que sean la causa directa, ya que también podrían intervenir otros factores, como el mantenimiento, el estado de la máquina o las características de las piezas.

Por ello, recomendamos revisar la calibración y el sistema de control de temperatura de la PRN-31, así como realizar un seguimiento de sus incidencias.
