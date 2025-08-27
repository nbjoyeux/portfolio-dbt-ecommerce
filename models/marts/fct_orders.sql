with lines as (
  select order_id, order_date, customer_id, quantity
  from {{ ref('stging_orders') }}
)
select
  order_id,
  customer_id,
  order_date,
  sum(quantity) as items_count
from lines
group by 1,2,3;
