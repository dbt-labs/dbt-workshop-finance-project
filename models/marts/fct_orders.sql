with orders as  (
    select * from {{ ref('stg_jaffle_shop__orders' )}}
),

payments as (
    select * from {{ ref('stg_stripe__payment') }}
),

order_payments as (
    select
        order_id,
        sum(case when status = 'success' then amount_usd end) as amount_usd

    from payments
    group by 1
),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        case when year(orders.order_date) < 2025 and month(orders.order_date) in (1,2,3)
            then 'Q1 '||year(orders.order_date)
             when year(orders.order_date) < 2025 and month(orders.order_date) in (4,5,6)
            then 'Q2 '|| year(orders.order_date)
            when year(orders.order_date) < 2025 and month(orders.order_date) in (7,8,9)
            then 'Q3 '|| year(orders.order_date)
            when year(orders.order_date) < 2025 and month(orders.order_date) in (10,11,12) 
            then 'Q4 '||year(orders.order_date) 
            when month(orders.order_date) in (1,2,3)
            then 'Q2 '||year(orders.order_date)
             when month(orders.order_date) in (4,5,6)
            then 'Q3 '|| year(orders.order_date)
            when month(orders.order_date) in (7,8,9)
            then 'Q4 '|| year(orders.order_date)
            when month(orders.order_date) in (10,11,12) 
            then 'Q1 '||year(orders.order_date)
            else 'CHECK'
        end as fiscal_quarter, 
        coalesce(order_payments.amount_usd, 0) as amount_usd

    from orders
    inner join order_payments using (order_id)
)

select * from final
order by customer_id