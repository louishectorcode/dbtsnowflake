{{ config(materialized='table', sort='timestamp')}}

with orders as (
    SELECT * FROM {{ source('globalmart', 'orders') }}
),

final as (
    SELECT * FROM orders
)

SELECT * FROM final