with demo as (
    select * from {{ ref('demographic_data') }}
),

final as (

select
    user_id,
    uniform(1950,2003,random(1)) as birth_year,
    case
       when sex=0 then 'male'
       else 'female'
    end as gender,
    case
       when children=0 then 'no children'
       else 'has children'
    end as children,
    case
       when marital_status=0 then 'not married'
       else 'married'
    end as marital_status
from demo
)
select* from final
