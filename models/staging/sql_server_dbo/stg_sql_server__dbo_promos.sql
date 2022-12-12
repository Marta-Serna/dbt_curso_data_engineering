WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server__dbo', 'promos') }}
    ),

renamed_casted AS (
    SELECT
        {{ dbt_utils.surrogate_key([
         'promo_id'])
        }} as promo_id
        ,promo_id as promo_type
        ,discount as discount_usd
        ,status as promo_status
        ,_fivetran_deleted as data_deleted
        ,_fivetran_synced as date_load
    FROM src_promos
    )

select * from renamed_casted
