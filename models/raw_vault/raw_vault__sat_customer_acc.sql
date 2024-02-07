SELECT
{{ SHA_binary(Columns = [
  'C_SRC',
  'C_CUSTKEY'
])}} AS HASHKEY,,
C_ACCTBAL,
C_MKTSEGMENT,
C_COMMENT,
CURRENT_TIMESTAMP() AS SAT_LOAD_DTS,
{{ SHA_binary(Columns = [
  'C_ACCTBAL',
  'C_MKTSEGMENT',
  'C_COMMENT'
]) }} AS HASHDIFF,
C_SRC AS SRC
FROM {{ ref('staging__customer') }}
{%- if is_incremental() %}
  where LOAD_DTS > (select max(LOAD_DTS) from {{ this }})
{% endif -%}