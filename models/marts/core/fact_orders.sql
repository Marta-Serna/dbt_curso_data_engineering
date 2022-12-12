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
        order_id,
        user_id,
        promo_id,
        address_id,
        created_at_utc,
        order_cost_usd,
        order_total_usd,
        shipping_service,
        shipping_cost_usd,
        order_status,
        tracking_id,
        data_deleted,
        date_load,
    case
    when estimated_delivery_at_utc = null then 'order not ready yet'
    else estimated_delivery_at_utc
    end as estimated_delivery_at_utc,
    case
    when delivered_at_utc = null then 'order not ready yet'
    else delivered_at_utc
    end as delivered_at_utc
    from orders
)

select * from final

{% if is_incremental() %}

 where date_load > (select max(date_load) from {{ this }})

{% endif %}