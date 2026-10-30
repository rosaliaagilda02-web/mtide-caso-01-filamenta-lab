
select
    upper(trim(impresora)) as impresora,
    upper(trim(material)) as material
from {{ source('bronce', 'impresoras') }}
