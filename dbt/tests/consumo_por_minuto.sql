
select
    pedido,
    impresora,
    minutos,
    gramos_filamento,
    round(
        gramos_filamento / nullif(minutos, 0),
        3
    ) as gramos_por_minuto
from {{ ref('stg_parte') }}
where minutos > 0
    and not (
        impresora = 'PRN-16'
        and fecha_carga = '2026-04-11'
        and gramos_filamento / nullif(minutos, 0) between 0.1 and 1
    )
    and (
        gramos_filamento / nullif(minutos, 0) < 0.1
        or gramos_filamento / nullif(minutos, 0) > 1
    )
