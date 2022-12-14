with users as (
  select * from {{ref('dim_users')}}
),

orders as (
   select * from {{ref('fct_orders')}}
),

fecha as (
   select * from {{ref('dim_date')}}
),


final as (
  select
      users.user_id
     ,orders.order_id
     ,orders.created_at_utc as date_order_created
     ,users.first_name
     ,users.last_name
     ,users.email
     ,users.gender
     ,users.birth_year
     ,users.marital_status
     ,users.children
     ,users.state
     ,users.country
     ,users.zipcode
     ,users.created_at_utc
     ,users.updated_at_utc
     ,fecha.date_day
     ,fecha.month_name
     ,fecha.day_of_week_name
     ,fecha.quarter_of_year

  from users
  left join orders
       on users.user_id = orders.user_id
  left join fecha
       on cast(users.created_at_utc as date) = fecha.date_day
    
)
select* from final