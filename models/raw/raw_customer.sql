{{ config(materialized='table', sort='timestamp')}}

with customers as (
    SELECT * FROM RAW.GLOBALMART.CUSTOMER
),

final as (
    SELECT * FROM customers
)

SELECT * FROM final