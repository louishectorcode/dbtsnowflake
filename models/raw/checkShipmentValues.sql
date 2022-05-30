with check_shipment as (
    select distinct(shipmode)
    from {{ ref('raw_orders') }}
),

final as (
    select * from check_shipment
)

select * from final