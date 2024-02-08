SELECT
{{ SHA_binary(Columns = [
  'C_SRC',
  'C_CUSTKEY'
])}} AS HASHKEY,
C_NAME,
C_ADDRESS,
C_NATIONKEY,
C_PHONE,
CURRENT_TIMESTAMP() AS SAT_LOAD_DTS,
{{ SHA_binary(Columns = [
  'C_SRC',
  'C_CUSTKEY',
  'C_NAME',
  'C_ADDRESS',
  'C_NATIONKEY',
  'C_PHONE'
]) }} AS HASHDIFF,
C_SRC AS SRC
FROM {{ ref('staging__customer') }}