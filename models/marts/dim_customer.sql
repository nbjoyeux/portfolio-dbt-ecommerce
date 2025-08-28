select
  customer_id,
  any_value(country)                   as country,
  min(order_date)                      as first_order_date,
  max(order_date)                      as most_recent_order_date,
  count(distinct order_id)             as orders_lifetime
from {{ ref('stg_orders') }}
group by 1
