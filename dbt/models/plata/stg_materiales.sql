
select
    upper(trim(material)) as material,
    temp_min_c::double as temp_min_c,
    temp_max_c::double as temp_max_c,
    coste_kg_eur::double as coste_kg_eur
from {{ source('bronce', 'materiales') }}
