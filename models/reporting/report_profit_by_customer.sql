{{
    config(
        materialized='view'
    )
}}

with profit_by_customer as (
    SELECT
        customerid,
        segment,
        country,
        sum(orderprofit) as profit
    FROM {{ ref('stg_orders') }}
    GROUP BY 
       customerid,
        segment,
        country
),

final as (
    SELECT *
    FROM profit_by_customer
)

SELECT * FROM final