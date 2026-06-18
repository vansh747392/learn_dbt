{% set inc_flag = 1 %}
{% set last_load = 3 %}

{% set col_name = ["sales_id", "date_sk", "net_amount"] %}

SELECT

    {% for col in col_name %}
        {{ col }}
        {% if not loop.last %}, {% endif %}
    {% endfor %}

FROM
    {{ref('bronze_sales')}}

{% if inc_flag == 1 %}

    WHERE date_sk > {{ last_load }}

{% endif %}