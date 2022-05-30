{{
    config(materialized='table')
}}

with orders as (
    SELECT
    -- from raw orders 
    orderid,
    orderdate,
    shipdate,
    shipmode,
    customerid,
    productid,
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
    o.orderid,
    o.orderdate,
    o.shipdate,
    o.shipmode,
    o.orderprofit,
    c.customername,
    c.segment,
    c.country,
    p.category,
    p.productname, 
    p.subcategory
    FROM orders as o
    LEFT JOIN customer AS c ON orders.customerid = customer.customerid
    LEFT JOIN product AS p ON orders.productid = product.productid
),

final as (
    SELECT *
    FROM customer_orders
)

SELECT * FROM final