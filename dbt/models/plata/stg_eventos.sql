
select
    lectura_id,
    upper(trim(impresora)) as impresora,
    ts_lectura::timestamp as ts_lectura,
    temp_boquilla_c::double as temp_boquilla_c
from {{ source('bronce', 'eventos') }}
