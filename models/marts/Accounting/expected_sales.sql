with budget as (
    select * from {{ref('fct_budget')}}

),

products as (
     select * from {{ref('dim_products')}}
),

final as (
     select
        sum(budget.quantity) as expected_budget_month,
        sum(products.price_usd) as expected_profits_month,
        budget.year_month_id

     from budget 
     left join products
           on budget.product_id = products.product_id

     group by
     budget.year_month_id

)
select * from final