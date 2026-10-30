
select
    tipo_pieza,
    count(*) as trabajos,
    sum(minutos) as minutos,
    round(
        sum(importe_eur) * 60.0 / nullif(sum(minutos), 0),
        2
    ) as ingreso_hora
from {{ ref('fact_trabajos') }}
group by tipo_pieza
order by ingreso_hora asc
