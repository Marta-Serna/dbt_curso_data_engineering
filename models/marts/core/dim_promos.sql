{{ config(
    materialized='incremental', 
    unique_key='promo_id'
    ) 
    }}

with promos as (
    select * from {{ref('stg_sql_server__dbo_promos')}}

),

final as (

    select
       promo_id,
       promo_type,
       discount_usd,
       promo_status,
       data_deleted,
       date_load
    from promos
)
select * from final

{% if is_incremental() %}

  where date_load > (select max(date_load) from {{ this }})

{% endif %}
