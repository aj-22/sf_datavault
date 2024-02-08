SELECT
{{ SHA_binary(Columns = [
  'O_SRC',
  'O_ORDERKEY',
  'O_CUSTKEY'
])}} AS LCO_HASHKEY,

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
FROM {{ ref('staging__orders') }} 