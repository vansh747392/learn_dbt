with returns as(
    select
        sales_id,
        product_sk,
        store_sk,
        returned_qty,
        refund_amount
    from
        {{ ref('bronze_returns') }}
),

products as
(
    select
        product_sk,
        category
    from
        {{ ref('bronze_product') }}
),

stores as
(
    select
        store_sk,
        store_name,
        region
    from
        {{ ref('bronze_store') }}
),

joined_query as
(
    select
        r.sales_id,
        r.refund_amount,
        r.returned_qty,
        p.category,
        s.store_name,
        s.region
    from
        returns r
    join
        products p
    on
        r.product_sk = p.product_sk
    join
        stores s
    on
        r.store_sk = s.store_sk
)

select
    category,
    store_name,
    region,
    sum(refund_amount) as total_refund_amount,
    sum(returned_qty) as total_returned_qty
from
    joined_query
group by
    category,
    store_name,
    region
order by
    category,
    store_name,
    region