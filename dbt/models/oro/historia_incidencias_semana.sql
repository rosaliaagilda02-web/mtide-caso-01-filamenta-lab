-- ORO · la historia: incidencias por impresora y semana (mapa de calor).
select
    strftime(fecha, '%Y-%W') as semana,
    impresora || ' · ' || strftime(fecha, '%Y-%W') as id_semana_impresora,
    impresora,
    strftime(fecha, '%Y-%W') as semana_txt,
    count(*) filter (where con_incidencia) as incidencias
from {{ ref('fact_trabajos') }}
group by semana, impresora, id_semana_impresora, semana_txt
order by semana, impresora
