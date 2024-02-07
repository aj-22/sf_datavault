SELECT
C_CUSTKEY,
C_NAME,
C_ADDRESS,
C_NATIONKEY,
C_PHONE,
C_ACCTBAL,
C_MKTSEGMENT,
C_COMMENT,
{{ SHA_binary(Columns = [
  'C_NAME',
  'C_ADDRESS',
  'C_NATIONKEY',
  'C_PHONE',
  'C_ACCTBAL',
  'C_MKTSEGMENT',
  'C_COMMENT'
]) }} AS C_HASHKEY,
CURRENT_TIMESTAMP() AS C_LOAD_DTS
FROM {{ source('TPCH','CUSTOMER') }}
{%- if is_incremental() %}
  where C_LOAD_DTS > (select max(C_LOAD_DTS) from {{ this }})
{% endif -%}
