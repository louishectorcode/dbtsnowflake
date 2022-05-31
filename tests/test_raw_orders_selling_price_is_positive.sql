with orders as (
    SELECT * FROM {{ ref('raw_orders') }}
),

final as (
    SELECT
        orderid,
        sum(ordersellingprice) as total_sp
    from orders
    group by orderid
    having total_sp < 0
)

select * from  final