with customers as (
    select * from {{ ref ('foundational_project','stg_customers')}}
),
orders as (
    select * from {{ ref ('foundational_project','fct_orders')}}
),
customer_orders as (
    select
        customer_key,
        min (order_date) as first_order_date,
        max (order_date) as most_recent_order_date,
        count(order_key) as number_of_orders,
        sum(gross_item_sales_amount) as lifetime_value
    from orders
    group by 1
),
 final as (
    select
        customers.customer_key,
        customers.name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce (customer_orders.number_of_orders, 0) as number_of_orders,
        customer_orders.lifetime_value
    from customers
    left join customer_orders using (customer_key)
)
select * from final
