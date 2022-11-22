WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server__dbo','products') }}
    ),

renamed_casted AS (
    SELECT
         product_id
        ,inventory
        ,name
        ,price
        ,_fivetran_deleted as date_deleted
        ,_fivetran_synced as date_load
    FROM src_products
    )

SELECT * FROM renamed_casted