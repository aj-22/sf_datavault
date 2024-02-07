SELECT
C_CUSTKEY,
C_NAME,
C_ADDRESS,
C_NATIONKEY,
C_PHONE,
C_ACCTBAL,
C_MKTSEGMENT,
C_COMMENT,
CURRENT_TIMESTAMP() AS C_LOAD_DTS,
'SF_SAMPLE' AS C_SRC
FROM {{ source('TPCH','CUSTOMER') }}
{%- if is_incremental() %}
  where C_LOAD_DTS > (select max(C_LOAD_DTS) from {{ this }})
{% endif -%}
