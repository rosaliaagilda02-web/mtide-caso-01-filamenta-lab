
select distinct
    operario
from {{ ref('stg_parte') }}
where operario is not null
