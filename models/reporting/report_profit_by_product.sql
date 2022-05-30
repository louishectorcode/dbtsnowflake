with profit_by_product as (
    SELECT
    productid,
    productname,
    category,
    subcategory,
    sum(orderprofit) as profit
    FROM {{ ref('stg_orders') }}
    GROUP BY 
        productid,
        productname,
        category,
        subcategory
),

final as (
    SELECT *
    FROM profit_by_product
)

SELECT * FROM final