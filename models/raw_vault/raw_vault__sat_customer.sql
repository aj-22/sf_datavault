SELECT
C_HASHKEY,
C_NAME,
C_ADDRESS,
C_NATIONKEY,
C_PHONE,
C_ACCTBAL,
C_MKTSEGMENT,
C_COMMENT,
C_LOAD_DTS AS LOAD_DTS,
'SF_SAMPLE' AS SRC
FROM {{ ref('staging__customer') }}
{%- if is_incremental() %}
  where LOAD_DTS > (select max(LOAD_DTS) from {{ this }})
{% endif -%}