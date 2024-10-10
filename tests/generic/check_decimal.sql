{% test check_decimal(model, column_name) %}

select
    {{ column_name }} 
from {{ model }}
where {{ column_name }} IS NOT TYPEOF DECIMAL

{% endtest %}