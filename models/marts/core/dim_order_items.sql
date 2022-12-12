{{ config(
    materialized='incremental'
    ) 
    }}

with order_items as (
    select * 
    from {{ ref('stg_sql_server__dbo_order_items') }}
    ),

final as (
    select
        order_items_id,
        order_id,
        product_id,
        quantity,
        data_deleted,
        date_load
    from order_items
    )
select * from final

{% if is_incremental() %}

  where date_load > (select max(date_load) from {{ this }})

{% endif %}