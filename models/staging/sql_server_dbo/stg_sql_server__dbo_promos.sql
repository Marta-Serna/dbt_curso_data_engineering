WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server__dbo', 'promos') }}
    ),

renamed_casted AS (
    SELECT
         promo_id
        ,discount
        ,status
        ,_fivetran_deleted as date_deleted
        ,_fivetran_synced as date_load
    FROM src_promos
    )

SELECT * FROM renamed_casted