WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server__dbo', 'addresses') }}
    ),

renamed_casted AS (
    SELECT
         address_id
        ,address
        ,country
        ,zipcode
        ,state
        ,_fivetran_deleted as date_deleted
        ,_fivetran_synced as date_load
    FROM src_addresses
    )

SELECT * FROM renamed_casted