{{ config(
    materialized='incremental', 
    unique_key='user_id'
    ) 
    }}
    
with users as (
  select * from {{ref('stg_sql_server_dbo_users')}}
),

addresses as (
  select * from {{ref('stg_sql_server__dbo_addresses')}}
),

demographics as (
   select * from {{ref('stg_demographic_data')}}
),


final as (

    select
        users.user_id,
        addresses.address_id,
        users.first_name,
        users.last_name,
        users.phone_number,
        users.email,
        users.created_at_utc,
        users.updated_at_utc,
        addresses.address,
        addresses.state,
        addresses.zipcode,
        addresses.country,
        demographics.age,
        demographics.sex,
        demographics.marital_status,
        demographics.children
    from 
        users
        inner join addresses
          on users.address_id = addresses.address_id
        inner join demographics
          on users.user_id = demographics.user_id
)

select * from final

{% if is_incremental() %}

  where date_load > (select max(date_load) from {{ this }})

{% endif %}