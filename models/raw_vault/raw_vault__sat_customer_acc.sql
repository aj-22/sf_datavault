SELECT
{{ SHA_binary(Columns = [
  'C_SRC',
  'C_CUSTKEY'
])}} AS HASHKEY,
C_CUSTKEY,
C_ACCTBAL,
C_MKTSEGMENT,
C_COMMENT,
CURRENT_TIMESTAMP() AS SAT_LOAD_DTS,
{{ SHA_binary(Columns = [
  'C_SRC',
  'C_CUSTKEY',
  'C_ACCTBAL',
  'C_MKTSEGMENT',
  'C_COMMENT'
]) }} AS HASHDIFF,
C_SRC AS SRC
FROM {{ ref('staging__customer') }}