with source as (
    select * 
    from {{ source('sql_server__dbo', 'users') }}
    ),

renamed_casted as (
    select
         user_id
        ,address_id
        ,first_name
        ,last_name
        ,phone_number
        ,email
        ,created_at as created_at_UTC
        ,updated_at as updated_at_UTC
        ,_fivetran_deleted as date_data_deleted
        ,_fivetran_synced as date_data_load
    from source
    )

select * from renamed_casted

--se borra total orders por no tener valores, no tiene sentido que esté en la tabla de users. puede ser calculado y
--añadido a users posteriormente


