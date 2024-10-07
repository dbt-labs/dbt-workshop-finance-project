with customers as (
    select * from {{ ref('stg_jaffle_shop__customers')}}
),

orders as (
    select * from {{ ref('fct_orders')}}
),

customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(amount_usd) as lifetime_value
    from orders
    group by 1
),

final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        case 
            when lifetime_value > 50 then 'tier1'
            when lifetime_value between 20 and 50 then 'tier2'
            when lifetime_value between 10 and 19 then 'tier3'
            when lifetime_value between 0 and 9 then 'tier4' 
        end as tier_name,
        customer_orders.lifetime_value
    from customers
    left join customer_orders using (customer_id)
)

select * from final
