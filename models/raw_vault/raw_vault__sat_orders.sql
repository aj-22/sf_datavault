SELECT
{{ SHA_binary(Columns = [
  'O_SRC',
  'O_ORDERKEY'
])}} AS HASHKEY,,
O_ORDERSTATUS,
O_TOTALPRICE,
O_ORDERDATE,
O_ORDERPRIORITY
O_CLERK,
O_SHIPPRIORITY,
O_COMMENT,
CURRENT_TIMESTAMP() AS SAT_LOAD_DTS,
{{ SHA_binary(Columns = [
  'O_ORDERSTATUS',
  'O_TOTALPRICE',
  'O_ORDERDATE',
  'O_ORDERPRIORITY',
  'O_CLERK',
  'O_SHIPPRIORITY',
  'O_COMMENT'
] ) }} AS O_HASHDIFF,
O_SRC AS SRC
FROM {{ ref('staging__orders') }}
{%- if is_incremental() %}
  where LOAD_DTS > (select max(LOAD_DTS) from {{ this }})
{% endif -%}
