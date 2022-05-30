{{ config(materialized='table', sort='timestamp'}}

with orders as (
    SELECT * FROM RAW.GLOBALMART.ORDERS
),

final as (
    SELECT * FROM orders
)

SELECT * FROM final