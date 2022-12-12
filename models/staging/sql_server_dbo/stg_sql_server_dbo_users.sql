with source as (
    select * 
    from {{ source('sql_server__dbo', 'users') }}
    ),

renamed_casted as (
    select
         user_id
        ,address_id
        ,first_name
        ,last_name
        ,phone_number
        ,email
        ,total_orders
        ,created_at as created_at_UTC
        ,updated_at as updated_at_UTC
        ,_fivetran_deleted as data_deleted
        ,_fivetran_synced as date_load
    from source
    )

select * from renamed_casted




