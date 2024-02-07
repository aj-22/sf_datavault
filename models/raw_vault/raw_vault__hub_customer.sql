SELECT
C_HASHKEY,
C_CUSTKEY,
CURRENT_TIMESTAMP() AS HUB_LOAD_DTS,
C_SRC AS SRC
FROM {{ ref('staging__customer') }}
{%- if is_incremental() %}
  where LOAD_DTS > (select max(LOAD_DTS) from {{ this }})
{% endif -%}