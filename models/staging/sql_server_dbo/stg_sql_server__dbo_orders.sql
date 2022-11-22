WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server__dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
         order_id
        ,user_id
        ,order_cost
        ,delivered_at
        ,tracking_id
        ,shipping_service
        ,shipping_cost
        ,created_at
        ,promo_id
        ,estimated_delivery_at
        ,status
        ,address_id
        ,order_total
        ,_fivetran_deleted as date_deleted
        ,_fivetran_synced as date_load
    FROM src_orders
    )
    when delivered_at = not null
    when _fivetran_deleted = not null

SELECT * FROM renamed_casted