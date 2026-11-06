-- ORO · la historia: una fila por día, para ver la evolución del taller.
select
    fecha,
    count(*)                          as trabajos,
    round(sum(importe_eur), 0)        as importe,
    round(sum(minutos) / 60.0, 1)     as horas
from {{ ref('fact_trabajos') }}
group by fecha
order by fecha
