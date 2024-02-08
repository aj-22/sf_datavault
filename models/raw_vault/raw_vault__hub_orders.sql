SELECT
{{ SHA_binary(Columns = [
  'O_SRC',
  'O_ORDERKEY'
])}} AS HASHKEY,
O_ORDERKEY,
CURRENT_TIMESTAMP() AS HUB_LOAD_DTS,
O_SRC AS SRC
FROM {{ ref('staging__orders') }}