with products as (
    select * from {{ ref('stg_sql_server__dbo_products') }}

),

orders as (
    select * from {{ ref('stg_sql_server__dbo_orders') }}

),

products_orders as (

    select
        orders.order_id,
        orders.first_name,
        customers.last_name,
        customers.email,
        products.product_id
        sum(products.product_id) as total_quantity_products
        avg(between estimated_delivery_at and delivered_at_utc) as tiempo_promedio_envio,
    from products
    left join customers on 
          products.user_id = tiempo.date_day
   
)

final as

select * from final