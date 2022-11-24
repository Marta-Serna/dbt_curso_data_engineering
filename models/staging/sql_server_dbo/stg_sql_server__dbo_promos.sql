with source as (
    select * 
    from {{ source('sql_server__dbo', 'promos') }}
    ),

renamed_casted as (
    select 
        {{ dbt_utils.surrogate_key([
        'promo_id']) 
        }} as promo_id 
        ,promo_id as promo_type
        ,discount as discount_$
        ,status as promo_status
        ,_fivetran_deleted as date_deleted
        ,_fivetran_synced as date_load
    from source
    ) 
select * from renamed_casted
