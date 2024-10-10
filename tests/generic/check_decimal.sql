{% test check_decimal(model, column_name) %}

select
    {{ column_name }} 
from {{ model }}
where typeof({{ column_name }}) <> DECIMAL

{% endtest %}