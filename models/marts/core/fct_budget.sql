{{ config(
    materialized='incremental', 
    unique_key='budget_id'
    ) 
    }}


with budget as (
    select * from {{ ref('stg_google_sheets_budget') }}
),

dim_month as (
    select * from {{ ref('dim_month') }}
),

final as (

    select
        {{ dbt_utils.surrogate_key([
         'budget_id' , 'product_id' , 'budget.year_month_id'])
        }} as budget_id
        ,product_id
        ,quantity
        ,budget.year_month_id
        ,dim_month.quarter_of_year
        ,dim_month.month_name
        ,date_load

    from budget
    inner join dim_month
      on budget.year_month_id = dim_month.year_month_id
)

select * from final

{% if is_incremental() %}

  where date_load > (select max(date_load) from {{ this }})

{% endif %}