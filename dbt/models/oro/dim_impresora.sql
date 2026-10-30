
select distinct
    impresora
from {{ ref('stg_parte') }}
where impresora is not null
