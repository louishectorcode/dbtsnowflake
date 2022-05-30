{{
    config(materialized='table')
}}

with orders as (
    SELECT *,
    ordersellingprice - ordercostprice as orderprofit
    FROM RAW.GLOBALMART.ORDERS
),

final as (
    SELECT * FROM orders
)

SELECT * FROM final