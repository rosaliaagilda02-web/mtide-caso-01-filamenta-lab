
with lecturas_ordenadas as (
    select
        e.impresora,
        i.material,
        e.ts_lectura,
        e.temp_boquilla_c,
        m.temp_min_c,
        m.temp_max_c,
        lead(e.ts_lectura) over (
            partition by e.impresora
            order by e.ts_lectura, e.lectura_id
        ) as siguiente_lectura
    from {{ ref('stg_eventos') }} e
    join {{ ref('stg_impresoras') }} i
        on e.impresora = i.impresora
    join {{ ref('stg_materiales') }} m
        on i.material = m.material
),

intervalos as (
    select
        *,
        date_diff(
            'second',
            ts_lectura,
            siguiente_lectura
        ) as segundos
    from lecturas_ordenadas
    where siguiente_lectura is not null
)

select
    impresora,
    material,
    count(*) filter (
        where temp_boquilla_c < temp_min_c
           or temp_boquilla_c > temp_max_c
    ) as lecturas_fuera_rango,
    round(
        sum(
            case
                when temp_boquilla_c < temp_min_c
                  or temp_boquilla_c > temp_max_c
                then segundos
                else 0
            end
        ) / 60.0,
        2
    ) as minutos_fuera_rango
from intervalos
group by impresora, material
order by minutos_fuera_rango desc
