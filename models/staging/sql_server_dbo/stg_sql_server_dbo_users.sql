WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server__dbo', 'users') }}
    ),

renamed_casted AS (
    SELECT
         user_id
        ,updated_at
        ,last_name
        ,created_at
        ,phone_number
        ,total_orders
        ,first_name
        ,address_id
        ,email
        ,_fivetran_deleted as date_deleted
        ,_fivetran_synced as date_load
    FROM src_users
    )

SELECT * FROM renamed_casted