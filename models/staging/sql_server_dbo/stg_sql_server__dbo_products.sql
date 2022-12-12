with source as (
    select * 
    from {{ source('sql_server__dbo','products') }}
    ),

renamed_casted as (
    select
         product_id,
         inventory,
         name,
         price as price_usd,
         _fivetran_deleted as data_deleted,
         _fivetran_synced as date_load
        from source
    )

select * from renamed_casted