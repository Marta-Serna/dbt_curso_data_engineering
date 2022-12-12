with users as (
  select * from {{ref('dim_users_info')}}
),