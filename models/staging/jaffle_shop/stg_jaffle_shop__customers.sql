with 

source as (

    select * from {{ source('jaffle_shop', 'customers') }}

),

renamed as (

    select
        id as customer_id,
        upper(first_name) as first_name,
        upper(last_name) as last_name
        

    from source

)

select * from renamed
