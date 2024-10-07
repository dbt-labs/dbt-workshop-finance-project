{% test type_of_field(model, column_name, value) %}

select typeof({{ column_name }})
from {{ model }}
where typeof({{ column_name }}) <> {{ value }}

{% endtest %}