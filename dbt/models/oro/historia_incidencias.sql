-- ORO · la historia: las incidencias del taller, con el peso de PRN-31.
with f as (
    select * from {{ ref('fact_trabajos') }}
)
select
    count(*)                                                          as trabajos,
    sum(con_incidencia::int)                                          as incidencias_totales,
    count(*) filter (where impresora = 'PRN-31')                      as trabajos_prn31,
    count(*) filter (where impresora = 'PRN-31' and con_incidencia)   as incidencias_prn31,
    round(
        count(*) filter (where impresora = 'PRN-31' and con_incidencia) * 100.0
        / nullif(sum(con_incidencia::int), 0), 1)                     as prn31_pct,
    round(sum(minutos) / 60.0, 0)                                     as horas_totales,
    round(sum(minutos) filter (where impresora = 'PRN-31') / 60.0, 1) as horas_prn31,
    round(count(*) filter (where con_incidencia) * 6000.0
          / nullif(sum(minutos), 0), 2)                               as incidencias_100h_taller,
    round(count(*) filter (where impresora = 'PRN-31' and con_incidencia) * 6000.0
          / nullif(sum(minutos) filter (where impresora = 'PRN-31'), 0), 2) as incidencias_100h_prn31
from f
