WITH src_budget_products AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

renamed_casted AS (
    SELECT
         _row as budget_id
        ,product_id
        ,quantity
        ,to_varchar(year(month)*100 + month(month)) as year_month_id
        ,_fivetran_synced as date_load
    FROM src_budget_products
    )

SELECT * FROM renamed_casted