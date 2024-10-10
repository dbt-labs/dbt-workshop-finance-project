{% test typeof(model, column_name, number) %}

select
    {{ column_name }} 
from {{ model }}
where IS_DECIMAL({{ column_name }}) = FALSE

{% endtest %}