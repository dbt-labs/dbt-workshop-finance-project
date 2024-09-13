with 

source as (

    select * from {{ source('jaffle_shop', 'customers') }}

),

renamed as (

    select
        null as row_id,
        id as customer_id,
        first_name,
        last_name

    from source

)

select * from renamed
