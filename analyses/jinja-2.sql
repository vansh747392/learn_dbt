{%- set apple = ["red delicious","granny smith", "honeycrisp", "fuji", "golden delicious"] -%}

{% for i in apple %}
    {% if i != "granny smith" %}
        {{ i }}
    {% else %}
        i hate {{ i }}
    {% endif %}
{% endfor %}