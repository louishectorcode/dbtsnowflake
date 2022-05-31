with orders as (
    SELECT
    -- from raw orders 
    {{ dbt_utils.surrogate_key(['orderid', 'customerid', 'productid' ]) }} as sk_orders,
    orderid,
    orderdate,
    shipdate,
    shipmode,
    customerid,
    productid,
    ordersellingprice,
    ordercostprice,
    ordersellingprice - ordercostprice as orderprofit
    FROM {{ ref('raw_orders')}}
),

customer as (
    SELECT 
    customername,
    segment,
    country,
    customerid
    FROM {{ref('raw_customer')}}
),

product as (
    SELECT
    category,
    productname, 
    subcategory,
    productid
    from {{ ref('raw_product')}}
),

customer_orders as (
    SELECT 
    o.sk_orders,
    o.orderid,
    o.orderdate,
    o.shipdate,
    o.shipmode,
    o.orderprofit,
    o.ordersellingprice,
    o.ordercostprice,
    c.customerid,
    c.customername,
    c.segment,
    c.country,
    p.productid,
    p.category,
    p.productname, 
    p.subcategory,
    {{ markup('ordersellingprice', 'ordercostprice') }} as markup
    FROM orders as o
    LEFT JOIN customer AS c ON o.customerid = c.customerid
    LEFT JOIN product AS p ON o.productid = p.productid

    {{ limit_data_in_dev('orderdate') }}
),

final as (
    SELECT *
    FROM customer_orders
)

SELECT * FROM final