with src as (
  select * from {{ source('ecommerce','RAW_ORDERS') }}
)
select
  nullif(trim(invoiceno), '')                          as order_id,
  try_to_number(customerid)                            as customer_id,
  try_to_date(invoicedate, 'MM/DD/YYYY HH24:MI')       as order_date,
  try_to_number(quantity)                              as quantity,
  trim(description)                                    as description,
  trim(country)                                        as country
from src
where customer_id is not null
  and order_date  is not null
  and nullif(trim(invoiceno), '') is not null
