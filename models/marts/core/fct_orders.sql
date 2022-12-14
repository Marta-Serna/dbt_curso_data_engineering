{{ config(
    materialized='incremental',
    unique_key='order_id'
    ) 
    }}

with orders as (
    select * from {{ ref('stg_sql_server__dbo_orders') }}
),

final as (

    select
        order_id
        ,user_id
        ,promo_id
        ,address_id
        ,created_at_utc
        ,order_cost_usd
        ,order_total_usd
        ,shipping_service
        ,shipping_cost_usd
        ,order_status
        ,tracking_id
        ,estimated_delivery_at_utc 
        ,delivered_at_utc 
        ,data_deleted
        ,date_load

    from orders
    )

select * from final

{% if is_incremental() %}

  where date_load > (select max(date_load) from {{ this }})

{% endif %}