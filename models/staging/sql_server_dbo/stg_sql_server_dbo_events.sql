with source as (
    select * 
    from {{ source('sql_server__dbo', 'events') }}
    ),

renamed_casted as (
    select
         event_id
        ,event_type
        ,product_id
        ,order_id
        ,user_id
        ,session_id
        ,page_url
        ,created_at as created_at_UTC
        ,_fivetran_deleted as date_data_deleted
        ,_fivetran_synced as date_data_load
    from source
    )

select * from renamed_casted