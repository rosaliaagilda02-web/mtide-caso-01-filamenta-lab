# Cómo se construyó la historia

## Paso 1 · De tema a decisión

| Nivel | En Filamenta Lab | Qué obliga a hacer |
|---|---|---|
| Tema | «Las incidencias del taller» | Nada: admite cualquier gráfico |
| Pregunta | «¿Incidencias por cada 100 horas de impresión?» | Una tasa que compare máquinas con cargas parecidas, y una base: la media del taller |
| Decisión | «¿Retiramos PRN-31 del servicio para revisión antes del 30 de abril?» | Quién (Taller / Producción), cuándo (30 de abril) y qué (revisión + reasignar el PETG) |

**La prueba:** después de leer la portada, Taller / Producción saca PRN-31 del servicio o decide seguir con ella.

## Paso 2 · Qué se mueve en los datos

### 2a · El terreno: Filamenta Lab en nueve semanas

```cifras
{{ historia_terreno.lineas[0] }} | líneas de trabajo limpias
{{ historia_terreno.impresoras[0] }} | impresoras en servicio
{{ historia_terreno.operarios[0] }} | operarios
{{ historia_terreno.horas_impresion[0] }} | horas de impresión
{{ historia_terreno.facturacion[0] }} | euros facturados
```

```grafico
titular: Incidencias por cada 100 horas de impresión, por impresora
modelo: pregunta_3
barras: impresora → incidencias_100h
orden: desc
```

PRN-31 se separa a simple vista: 6,6 frente a un taller que se mueve entre 0 y 1,2.

```grafico
tipo: linea
titular: Facturación por día, febrero a abril de 2026
modelo: historia_dia
x: fecha
y: importe
```

La línea describe, no afirma: ningún día destaca; el negocio es estable. Lo que se mueve no es la demanda.

```grafico
tipo: histograma
titular: Importe por línea de trabajo
modelo: fact_trabajos
columna: importe_eur
```

La media de una línea son {{ historia_terreno.media_linea[0] }} €, pero la mitad está por debajo de
{{ historia_terreno.mediana_linea[0] }} €: hay trabajos caros (cosplay, maquetas) que estiran la media.

### 2b · El disparador: una tasa, no un volumen

En bruto, PRN-31 acumula {{ historia_incidencias.incidencias_prn31[0] }} incidencias. La cifra útil es la misma dividida
por lo que corresponde: por horas de impresión. Con carga parecida a la de las demás
({{ historia_incidencias.trabajos_prn31[0] }} trabajos de {{ historia_incidencias.trabajos[0] }}), PRN-31 concentra el
{{ historia_incidencias.prn31_pct[0] }} % de las incidencias del taller.

**El hallazgo:** PRN-31 sufre {{ historia_incidencias.incidencias_100h_prn31[0] }} incidencias por cada 100 horas,
unas 5 veces la media del taller ({{ historia_incidencias.incidencias_100h_taller[0] }}); su rango de temperatura blanco,
PETG, es también el material con más tiempo fuera de rango ({{ historia_temperatura.minutos_petg[0] }} min, y el
{{ historia_temperatura.prn31_pct[0] }} % de ese total es de PRN-31). Es una hipótesis, no un hecho: el parte no
dice qué tipo de fallo es cada incidencia.

Y aguanta semana a semana: el mapa de calor enciende PRN-31 en cada semana, sin que ninguna otra lo haga.

### 2c · Qué lo puede explicar

- **Anomalía:** sí. PRN-31 se separa de un taller homogéneo (6,6 frente a ≤ 1,2).
- **Cambio significativo:** no. Con nueve semanas no se puede ver tendencia; el patrón es estable en el tiempo.
- **Fuerzas del mercado:** no aplica directamente; la demanda es estable y las máquinas trabajan lo mismo.
- **Iniciativas propias:** el parte no registra mantenimientos ni cambios de boquilla; no se puede separar. Hipótesis:
  una boquilla deteriorada o un termistor descalibrado explicaría tanto el tiempo fuera de rango como las incidencias.

## Paso 3 · Qué datos entran y cuáles se quedan fuera

| Dato candidato | ¿Pasa el filtro? | Dónde se usa |
|---|---|---|
| Incidencias por 100 h, por impresora | Sí: es la tasa del disparador | Portada, gráfico-mensaje |
| Incidencias por impresora y semana | Sí: demuestra que no es una racha puntual | Portada, segunda prueba |
| Minutos fuera de rango, por impresora y material | Sí: es la explicación plausible y la guía de la revisión | Portada y hallazgo |
| Carga de trabajo por impresora | No entra en la portada, pero es el control: sin carga igual, la tasa no dice nada | Aquí, en el hallazgo |
| Ingreso por hora, por tipo de pieza | No: no cambia la decisión de retirar la máquina | Fuera, por mucho que interese |
| Filamento por hora, por operario | No: describe al operario, no a la máquina | Fuera |
| Temperatura fuera de rango por semana | No: el mapa de incidencias ya demuestra la persistencia | Fuera |

Otra pasada del filtro (si la quito, ¿cambia la decisión?): los gráficos del 2a (línea de facturación e histograma)
describe el negocio; la decisión aguanta sin ellos: fuera.

```grafico
titular: La misma tasa con los datos tal como llegan y limpios: la conclusión aguanta
modelo: historia_contraste
barras: impresora → incidencias_100h_sin_limpiar, incidencias_100h_limpio
leyenda: tal como llegan, limpios
```

La limpieza (quitar 10 líneas duplicadas entre remesas, corregir minutos imposibles — desde {{ historia_terreno.lineas[0] }}
líneas limpias de 584 brutas — y los consumos de PRN-16 en kg) cambia la cifra 6,87 → 6,61, pero no cambia la decisión:
PRN-31 sigue multiplicando al resto.

```grafico
tipo: eje
titular: Mismas barras de tiempo fuera de rango, dos lecturas: el eje manda
modelo: pregunta_4
barras: impresora → minutos_fuera_rango
corte: 3
```

Con el eje cortado en tres minutos, PRN-31 parece muchas veces las demás; con el eje desde cero, sigue ganando, pero
con justicia: de ahí que todos los gráficos de barras de la portada empiecen en cero.

> **Alcance.** Parte diario de impresión del ERP de Filamenta Lab, del 2 de febrero al 10 de abril de 2026:
> 584 líneas llegadas en dos remesas (28/03 y 11/04), 10 duplicadas entre remesas, con minutos imposibles
> (−313 a 9.999) corregidos por la mediana de su tipo de pieza. Cifras: {{ historia_terreno.lineas[0] }} líneas limpias,
> {{ historia_terreno.horas_impresion[0] }} h de impresión, {{ historia_terreno.facturacion[0] }} € facturados.
> Temperatura: {{ historia_temperatura.minutos_totales[0] }} min fuera del rango del material.

Cada modelo `historia_*` lleva en `_oro.yml` su test `unique` y `not_null` en la columna que identifica la fila
(`fecha` en `historia_dia`, `id_semana_impresora` en el mapa de calor, `id_impresora` en el contraste); `dbt build` en verde.

## Las cinco comprobaciones

- **Hay una decisión detrás:** «¿Retiramos PRN-31 para revisión antes del 30 de abril?», la toma Taller / Producción.
- **El titular afirma:** leído solo dice qué hacer: «…revisar PRN-31 antes de finales de abril».
- **Cada cifra tiene fuente:** todas salen del lakehouse (`historia_*`, `pregunta_3`, `pregunta_4`), con periodo
  y filtros declarados en el alcance.
- **La evidencia es diversa:** la tasa por 100 h, su persistencia semanal (mapa de calor) y el tiempo fuera de rango
  apuntan en la misma dirección.
- **Lo que no cuadra se dice:** duplicados y minutos corregidos, la hipótesis causal sin comprobar y el límite de
  nueve semanas están declarados en la portada.
