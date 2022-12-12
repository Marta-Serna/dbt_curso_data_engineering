{{ config(
    materialized='incremental',
    unique_key='event_id'
    ) 
    }}

with events as (
    select * from {{ ref('stg_sql_server_dbo_events') }}
),

event_type as (
     select * from {{ ref('int_event_type') }}
),

final as (
    select
         event_id
        ,events.user_id
        ,product_id
        ,order_id
        ,checkout_amount
        ,package_shipped_amount
        ,add_to_cart_amount
        ,page_view_amount
        ,session_id
        ,page_url
        ,created_at_utc
        ,data_deleted
        ,date_load
    from events
    left join event_type on
        events.user_id = event_type.user_id
    )

select * from final

{% if is_incremental() %}

  where date_load > (select max(date_load) from {{ this }})

{% endif %}