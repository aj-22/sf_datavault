with link as (
SELECT
{{ SHA_binary(Columns = [
  'O_SRC',
  'O_ORDERKEY'
])}} AS O_HASHKEY,

{{ SHA_binary(Columns = [
  'O_SRC',
  'O_CUSTKEY'
])}} AS C_HASHKEY,
CURRENT_TIMESTAMP() as LINK_LOAD_DTS,
O_SRC AS SRC
FROM {{ ref('staging__orders') }} O
{%- if is_incremental() %}
  where LOAD_DTS > (select max(LOAD_DTS) from {{ this }})
{% endif -%}
)
SELECT
{{ SHA_binary(Columns = [
  'O_ORDERKEY',
  'O_CUSTKEY'
])}} AS LCO_HASHKEY,
O_HASHKEY,
C_HASHKEY,
LOAD_DTS
SRC
FROM link