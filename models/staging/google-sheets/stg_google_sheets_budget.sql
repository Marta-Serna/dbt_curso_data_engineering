WITH src_budget_products AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

renamed_casted AS (
    SELECT
         _row as budget_id
        ,product_id
        ,quantity
        ,month
        ,_fivetran_synced as date_load
    FROM src_budget_products
    )

SELECT * FROM renamed_casted