with users as (
    select * from {{ref('dim_users_info')}}

),

events as (
     select * from {{ref('fact_events')}}

),

users_events as (

    select
         users.user_id
        ,users.first_name
        ,users.last_name
        ,users.email
        ,events.checkout_amount
        ,events.package_shipped_amount
        ,events.add_to_cart_amount
        ,events.page_view_amount
    from users
    inner join events on
        users.user_id = events.user_id

)
select * from users_events
