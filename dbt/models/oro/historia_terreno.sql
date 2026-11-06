-- ORO · la historia: el terreno. Una fila con las cifras de contexto del taller.
select
    count(*)                                               as lineas,
    count(distinct operario)                               as operarios,
    count(distinct impresora)                              as impresoras,
    count(distinct tipo_pieza)                             as tipos_pieza,
    round(sum(minutos) / 60.0, 0)                          as horas_impresion,
    round(sum(importe_eur), 0)                             as facturacion,
    round(sum(importe_eur) / count(*), 2)                  as media_linea,
    round(median(importe_eur), 2)                          as mediana_linea,
    min(fecha)                                             as desde,
    max(fecha)                                             as hasta
from {{ ref('fact_trabajos') }}
