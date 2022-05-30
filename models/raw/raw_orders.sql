{{
    config(amterialized='table')
}}

with orders as (
    SELECT * FROM RAW.GLOBALMART.ORDERS
),

final as (
    SELECT * FROM orders
)

SELECT * FROM final