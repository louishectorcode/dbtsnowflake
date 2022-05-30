{{ config(materialized='table', sort='timestamp')}}

with customers as (
    SELECT * FROM {{ source('globalmart', 'customer') }}
),

final as (
    SELECT * FROM customers
)

SELECT * FROM final