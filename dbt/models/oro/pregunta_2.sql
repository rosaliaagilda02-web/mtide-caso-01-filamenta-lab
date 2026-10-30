
select
    operario,
    count(*) as trabajos,
    sum(minutos) as minutos,
    round(
        sum(gramos_filamento) * 60.0 / nullif(sum(minutos), 0),
        2
    ) as g_hora
from {{ ref('fact_trabajos') }}
group by operario
order by g_hora desc
