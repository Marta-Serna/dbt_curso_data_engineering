 {{ config(
    materialized='incremental', 
    unique_key='user_id'
    ) 
    }}

with users as (
  select * from {{ref('stg_sql_server_dbo_users')}}
),

demographics as (
   select * from {{ref('stg_demographic_data')}}
),

addresses as (
   select * from {{ref('stg_sql_server__dbo_addresses')}}
),

final as (
  select
      users.user_id,
      first_name,
      last_name,
      gender,
      birth_year,
      phone_number,
      email,
      marital_status,
      children,
      users.address_id,
      address,
      state,
      country,
      zipcode,
      created_at_utc,
      updated_at_utc,
      users.date_load,
      users.data_deleted

   from users
   left join demographics
          on users.user_id = demographics.user_id
   left join addresses
          on users.address_id = addresses.address_id
)
select * from final

{% if is_incremental() %}

  where date_load > (select max(date_load) from {{ this }})

{% endif %}