-- ORO · la historia: el tiempo con la boquilla fuera del rango de su material.
with p as (
    select * from {{ ref('pregunta_4') }}
)
select
    round(sum(minutos_fuera_rango), 1)                                        as minutos_totales,
    round(sum(minutos_fuera_rango) filter (where impresora = 'PRN-31'), 1)    as minutos_prn31,
    round(sum(minutos_fuera_rango) filter (where impresora = 'PRN-31') * 100.0
          / nullif(sum(minutos_fuera_rango), 0), 1)                           as prn31_pct,
    round(sum(minutos_fuera_rango) filter (where material = 'PETG'), 1)        as minutos_petg,
    round(sum(minutos_fuera_rango) filter (where material <> 'PETG'), 1)       as minutos_otro_material
from p
