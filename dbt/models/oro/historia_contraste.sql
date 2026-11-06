-- ORO · la historia: la misma cifra con los datos tal como llegan (bronce, con sus
-- duplicados y sus minutos imposibles) y con los datos limpios (plata/oro).
with sin_limpiar as (
    select
        impresora,
        count(*) filter (where incidencia is not null and trim(incidencia) <> '') as incidencias,
        sum(minutos::integer)                                                     as minutos
    from {{ source('bronce', 'parte') }}
    group by impresora
),
limpio as (
    select
        impresora,
        count(*) filter (where con_incidencia) as incidencias,
        sum(minutos) as minutos
    from {{ ref('fact_trabajos') }}
    group by impresora
)
select
    s.impresora,
    s.impresora || ' · ' || l.impresora as id_impresora,
    s.impresora as impresora_sucia,
    l.impresora as impresora_limpia,
    round(s.incidencias * 6000.0 / nullif(s.minutos, 0), 2) as incidencias_100h_sin_limpiar,
    round(l.incidencias * 6000.0 / nullif(l.minutos, 0), 2) as incidencias_100h_limpio
from sin_limpiar s
join limpio l using (impresora)
order by incidencias_100h_limpio desc
