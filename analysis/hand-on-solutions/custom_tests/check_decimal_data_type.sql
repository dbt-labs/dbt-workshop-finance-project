{% test check_decimal_data_type(model, column_name) %}
    
select 
    {{ column_name }},
    typeof({{ column_name }}) as {{ column_name }}_data_type
from {{ model}}
where typeof({{ column_name }}) <> 'DECIMAL'

{% endtest %}
