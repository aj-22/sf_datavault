SELECT
O_HASHKEY,
O_ORDERSTATUS,
O_TOTALPRICE,
O_ORDERDATE,
O_ORDERPRIORITY
O_CLERK,
O_SHIPPRIORITY,
O_COMMENT,
O_LOAD_DTS AS LOAD_DTS,
'SF_SAMPLE' AS SRC
FROM {{ ref('staging__orders') }}
{%- if is_incremental() %}
  where LOAD_DTS > (select max(LOAD_DTS) from {{ this }})
{% endif -%}
