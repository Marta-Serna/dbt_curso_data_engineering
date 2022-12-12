with users as (

    select * from {{ ref('dim_users_info') }}

),

orders as (

    select * from {{ ref('stg_sql_server__dbo_orders') }}

),

users_orders as (

    select
        user_id,
        min(orders.created_at_utc) as first_order,
        max(orders.created_at_utc) as most_recent_order,
        count(order_id) as total_orders
    from orders
    group by user_id
),

final as (

    select
        users.user_id,
        users.created_at_utc as customer_created_at,
        users.updated_at_utc as customer_updated_at,
        users.first_name,
        users.last_name,
        users.phone_number,
        users.email,
        users.address,
        users.state,
        users.country,
        users.zipcode,
        users_orders.first_order,
        users_orders.most_recent_order,
        users_orders.total_orders
    from users
    right join users_orders on
        users.user_id = users_orders.user_id

)
select * from final
