{% test type_decimal(model, column_name) %}

select
    {{ column_name }},
    TYPEOF({{ column_name }}) AS {{ column_name }}_data_type
from {{ model }}
where TYPEOF({{ column_name }}) <> 'DECIMAL'

{% endtest %}