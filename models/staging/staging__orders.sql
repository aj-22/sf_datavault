SELECT
O_ORDERKEY,
O_CUSTKEY,
O_ORDERSTATUS,
O_TOTALPRICE,
O_ORDERDATE,
O_ORDERPRIORITY,
O_CLERK,
O_SHIPPRIORITY,
O_COMMENT,
{{ SHA_binary(Columns = [
  'O_ORDERSTATUS',
  'O_TOTALPRICE',
  'O_ORDERDATE',
  'O_ORDERPRIORITY',
  'O_CLERK',
  'O_SHIPPRIORITY',
  'O_COMMENT'
] ) }} AS O_HASHKEY,
CURRENT_TIMESTAMP() AS O_LOAD_DTS
FROM {{ source('TPCH','ORDERS') }} O
where O_ORDERDATE = '{{ var('load_date') }}'
{%- if is_incremental() %}
  and O_LOAD_DTS > (select max(O_LOAD_DTS) from {{ this }})
{% endif -%}
