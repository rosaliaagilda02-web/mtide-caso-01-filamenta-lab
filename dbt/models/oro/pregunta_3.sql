
select
    impresora,
    count(*) as trabajos,
    count(*) filter (where con_incidencia = true) as incidencias,
    round(
        count(*) filter (where con_incidencia = true) * 6000.0
        / nullif(sum(minutos), 0),
        2
    ) as incidencias_100h
from {{ ref('fact_trabajos') }}
group by impresora
order by incidencias_100h desc
