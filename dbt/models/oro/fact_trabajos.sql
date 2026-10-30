
select
    pedido,
    fecha,
    operario,
    impresora,
    tipo_pieza,
    minutos,
    gramos_filamento,
    importe_eur,
    case
        when incidencia is not null
             and trim(incidencia) <> ''
        then true
        else false
    end as con_incidencia
from {{ ref('stg_parte') }}
