WITH src_order_items AS (
    SELECT * 
    FROM {{ source('sql_server__dbo','order_items') }}
    ),

renamed_casted AS (
    SELECT
         order_id
        ,product_id
        ,quantity
        ,_fivetran_deleted as date_deleted
        ,_fivetran_synced as date_load
    FROM src_order_items
    )

select

 {{ dbt_utils.surrogate_key([

                'order_id',

                'product_id'

            ])

        }} as order_items_id

 from renamed