{{ config(materialized='table', sort='timestamp')}}

with product as (
    SELECT * FROM RAW.GLOBALMART.PRODUCT
),

final as (
    SELECT * FROM product
)

SELECT * FROM final