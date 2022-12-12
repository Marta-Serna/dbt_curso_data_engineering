with source as (
    select * 
    from {{ source('sql_server__dbo', 'events') }}
    ),

renamed_casted as (
    select
         event_id
        ,user_id
        ,event_type
        ,product_id
        ,order_id
        ,session_id
        ,page_url
        ,created_at as created_at_utc
        ,_fivetran_deleted as data_deleted
        ,_fivetran_synced as date_load
    from source
    )

select * from renamed_casted