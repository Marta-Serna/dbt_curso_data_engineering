with orders as (
    select * from {{ ref('fct_orders') }}
),

order_items as (
    select * from {{ ref('dim_order_items') }}
),

products as (
     select * from {{ ref('dim_products') }}
),

promos as (
     select * from {{ ref('dim_promos') }}
),

fecha as (
     select * from {{ ref('dim_date') }}
),

final as (
    select 
     orders.order_id,
     min(orders.created_at_utc) as first_order,
     max(orders.created_at_utc) as most_recent_order,
     count(orders.order_id) as total_orders,
     orders.created_at_utc,
     orders.order_cost_usd,
     orders.order_total_usd,
     order_items.product_id,
     products.name,
     products.inventory,
     products.price_usd,
     products.price_range,
     order_items.quantity,
     promos.promo_id,
     promos.promo_type,
     promos.discount_usd,
     fecha.day_of_week_name,
     fecha.quarter_of_year

    from orders
    left join order_items 
         on orders.order_id = order_items.order_id
    left join products 
         on order_items.product_id = products.product_id
    left join promos
         on orders.promo_id = promos.promo_id
    left join fecha
         on orders.created_at_utc = fecha.date_day
         
    group by
     orders.order_id,
     orders.created_at_utc,
     orders.order_cost_usd,
     orders.order_total_usd,
     order_items.product_id,
     products.name,
     products.inventory,
     products.price_usd,
     products.price_range,
     order_items.quantity,
     promos.promo_id,
     promos.promo_type,
     promos.discount_usd,
     fecha.day_of_week_name,
     fecha.quarter_of_year
)

select * from final
