
# Memo para la dirección de Filamenta Lab

## Qué hemos visto

El análisis de los trabajos de impresión 3D permite identificar cuatro resultados importantes:

1. **Rentabilidad:** el tipo de pieza que menos ingresos genera por hora es **{{ pregunta_1.tipo_pieza[0] }}**, con **{{ pregunta_1.ingreso_hora[0] }} €/hora**.

2. **Consumo:** el operario que más filamento consume por hora es **{{ pregunta_2.operario[0] }}**, con **{{ pregunta_2.g_hora[0] }} gramos por hora**.

3. **Incidencias:** la impresora con más incidencias es **{{ pregunta_3.impresora[0] }}**, con **{{ pregunta_3.incidencias_100h[0] }} incidencias por cada 100 horas de impresión**.

4. **Temperatura:** la impresora que más tiempo pasa fuera del rango recomendado es **{{ pregunta_4.impresora[0] }}**, con **{{ pregunta_4.minutos_fuera_rango[0] }} minutos y **{{ pregunta_4.lecturas_fuera_rango[0] }} lecturas fuera de rango**.

## Qué recomendamos

**1. Revisar la rentabilidad de las piezas.**

Conviene analizar los costes y precios del tipo de pieza que menos ingresos genera por hora, para comprobar si resulta rentable mantener sus condiciones actuales.

**2. Analizar el consumo de filamento.**

Recomendamos revisar el consumo del operario que presenta el valor más elevado para determinar si se debe al tipo de piezas que fabrica, a su complejidad o a un posible desperdicio de material.

**3. Priorizar el mantenimiento de la impresora con más incidencias.**

La impresora **{{ pregunta_3.impresora[0] }}** presenta **{{ pregunta_3.incidencias_100h[0] }} incidencias por cada 100 horas**, por lo que conviene revisar su funcionamiento.

**4. Revisar la temperatura de las boquillas.**

La impresora **{{ pregunta_4.impresora[0] }}** acumula **{{ pregunta_4.minutos_fuera_rango[0] }} minutos fuera del rango recomendado.

Recomendamos revisar la calibración, los sensores y el sistema de control de temperatura, especialmente si coincide con la impresora que presenta más incidencias.

## Qué no sabemos todavía

Los resultados permiten detectar problemas, pero hay algunas limitaciones:

- **Rentabilidad:** hemos analizado los ingresos por hora, pero no el beneficio real. Para calcularlo necesitaríamos incorporar todos los costes de producción.
- **Consumo:** un mayor consumo de filamento no significa necesariamente que un operario trabaje peor. Necesitaríamos conocer la complejidad y el tamaño de las piezas fabricadas.
- **Incidencias:** hemos utilizado las incidencias por cada 100 horas para comparar impresoras, pero sería conveniente conocer la gravedad y las causas de cada incidencia.
- **Temperatura:** hemos supuesto que la temperatura registrada se mantiene hasta la siguiente medición. Las lecturas intermedias que no se registraron podrían modificar la duración estimada fuera del rango. Tampoco podemos asegurar que las desviaciones sean la causa de las incidencias.

## Cómo se ha hecho

Los datos originales se almacenaron en la capa bronce del lakehouse.

Después se limpiaron y transformaron en la capa plata, corrigiendo los problemas detectados sin modificar los archivos originales.

En la capa oro se construyeron las cuatro consultas que responden a las preguntas de negocio.

También se incorporaron pruebas de calidad para comprobar que no se pierden trabajos, que las relaciones entre las tablas sean correctas y que el consumo de filamento cumpla el rango establecido de 0,1 a 1 gramo por minuto.

El test de consumo detectó nueve registros incorrectos antes de la corrección, mientras que la ejecución final de dbt terminó con 31 comprobaciones satisfactorias.

Las cifras del portal se obtienen automáticamente de las consultas, lo que permite actualizar los resultados cuando se incorporen nuevos datos.
