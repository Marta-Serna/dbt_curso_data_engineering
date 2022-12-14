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
        ,cast(created_at as date) as created_at_utc
        ,updated_at as updated_at_utc
        ,_fivetran_deleted as data_deleted
        ,_fivetran_synced as date_load
    from source
    )

select * from renamed_casted




