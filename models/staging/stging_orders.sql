with src as (
  select * from {{ source('ecommerce','raw_orders') }}
),
clean as (
  select
      cast(INVOICENO   as varchar)              as order_id,
      cast(CUSTOMERID  as varchar)              as customer_id,
      try_to_timestamp_ntz(INVOICEDATE)         as order_ts,
      to_date(try_to_timestamp_ntz(INVOICEDATE)) as order_date,
      nullif(upper(COUNTRY), '')                as country,
      nullif(DESCRIPTION, '')                   as product_name,
      try_to_number(QUANTITY)                   as quantity
  from src
)
select * from clean
