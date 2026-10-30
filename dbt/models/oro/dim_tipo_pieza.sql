
select distinct
    tipo_pieza
from {{ ref('stg_parte') }}
where tipo_pieza is not null
