select
    market_segment,
    sum(gross_item_sales_amount) as total_revenue
from {{ ref('foundational_project', 'fct_orders') }}
group by 1