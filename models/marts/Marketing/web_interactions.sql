with users as (
    select * from {{ref('dim_users')}}

),

events as (
     select * from {{ref('fct_events')}}

),

fecha as (
     select * from {{ref('dim_date')}}
),

final as (

    select
         users.user_id
        ,users.first_name
        ,users.last_name
        ,users.email
        ,users.gender
        ,users.birth_year
        ,users.state
        ,users.country
        ,users.zipcode
        ,fecha.date_day
        ,fecha.week_end_date
        ,fecha.day_of_week_name
        ,events.session_id
        ,events.page_url
        ,events.created_at_utc
        ,events.checkout_amount
        ,events.package_shipped_amount
        ,events.add_to_cart_amount
        ,events.page_view_amount
    from users
    inner join events 
         on users.user_id = events.user_id
    left join fecha
         on cast(events.created_at_utc as date) = fecha.date_day
)

select * from final
