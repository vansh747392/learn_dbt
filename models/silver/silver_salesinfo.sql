with sales as
(
    select
        sales_id,
        product_sk,
        customer_sk,
        {{ multiply('quantity', 'unit_price') }} as calculated_gross_amount,
        gross_amount,
        payment_method
    from
        {{ ref('bronze_sales') }}
),

products as
(
    select
        product_sk,
        category
    from
        {{ ref('bronze_product') }}
),

customers as
(
    select
        customer_sk,
        gender
    from
        {{ ref('bronze_customer') }}
),

joined_query as
(
    select
        s.sales_id,
        s.gross_amount,
        s.payment_method,
        s.calculated_gross_amount,
        p.category,
        c.gender
    from
        sales s
    join
        products p
    on
        s.product_sk = p.product_sk
    join
        customers c
    on
        s.customer_sk = c.customer_sk
)

select
    category,
    gender,
    sum(gross_amount) as total_gross_amount
from
    joined_query
group by
    category,
    gender
order by
    total_gross_amount desc