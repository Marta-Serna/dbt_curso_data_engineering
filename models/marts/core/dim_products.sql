{{ config(
    materialized='incremental',
    unique_key='product_id'
    ) 
    }}

with products as (
    select * from {{ ref('stg_sql_server__dbo_products') }}
),

final as (

    select
         product_id,
         inventory,
         name,
         price_usd,
         case
            when price_usd <= 25 then 'cheap'
            when price_usd >= 25 and price_usd <= 50 then 'affordable'
            else 'expensive'
         end as price_range,
         date_load,
         data_deleted

    from products
    )

select * from final

{% if is_incremental() %}

  where date_load > (select max(date_load) from {{ this }})

{% endif %}