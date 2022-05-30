{{ config(materialized='table', sort='timestamp')}}

with product as (
    SELECT * FROM {{ source('globalmart', 'product')}}
),

final as (
    SELECT * FROM product
)

SELECT * FROM final