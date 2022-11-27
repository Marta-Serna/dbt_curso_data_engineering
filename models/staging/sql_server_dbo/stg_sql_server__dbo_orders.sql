with source as (
    select * 
    from {{ source('sql_server__dbo', 'orders') }}
    ),

renamed_casted as (
    select 
         order_id
        ,user_id as costumer_id --quitar si es más lioso
        ,address_id
        ,order_cost as order_cost_$
        ,order_total as order_total_$
        ,shipping_service
        ,shipping_cost as shipping_cost_$
        ,promo_id
        ,created_at as created_at_UTC
        ,status as order_status
        ,estimated_delivery_at as estimated_delivery_at_UTC
        ,delivered_at as delivered_at_UTC
        ,tracking_id
        ,_fivetran_deleted as date_data_deleted
        ,_fivetran_synced as data_data_load
    from source
    )
select * from renamed_casted
