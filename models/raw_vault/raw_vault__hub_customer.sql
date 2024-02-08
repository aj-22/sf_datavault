SELECT
{{ SHA_binary(Columns = [
  'C_SRC',
  'C_CUSTKEY'
])}} AS HASHKEY,
C_CUSTKEY,
CURRENT_TIMESTAMP() AS HUB_LOAD_DTS,
C_SRC AS SRC
FROM {{ ref('staging__customer') }}