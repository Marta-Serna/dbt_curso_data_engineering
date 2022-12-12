WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server__dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
         order_id
        ,user_id
        ,case
            when promo_id = ''then''
            else {{dbt_utils.surrogate_key (['promo_id'])}}
        end as promo_id
        ,address_id
        ,cast(created_at as date) as created_at_utc
        ,order_cost as order_cost_usd
        ,order_total as order_total_usd
        ,shipping_service
        ,shipping_cost as shipping_cost_usd
        ,status as order_status
        ,tracking_id
        ,cast(estimated_delivery_at as date) as estimated_delivery_at_utc
        ,cast(delivered_at as date) as delivered_at_utc
        ,_fivetran_deleted as data_deleted
        ,_fivetran_synced as date_load

    FROM src_orders
    )
 
SELECT * 
FROM renamed_casted
