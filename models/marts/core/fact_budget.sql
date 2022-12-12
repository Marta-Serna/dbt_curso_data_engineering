{{ config(
    materialized='incremental',
    unique_key='budget_id'
    ) 
    }}

 with budget as (
    select * from {{ ref('stg_google_sheets_budget') }}
),

final as (

    select
         budget_id,
         product_id,
         quantity,
         month,
         date_load
    from budget
    )

select * from final

{% if is_incremental() %}

  where date_load > (select max(date_load) from {{ this }})

{% endif %}