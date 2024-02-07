SELECT
N_HASHKEY,
N_NATIONKEY,
N_NAME,
N_REGIONKEY,
N_COMMENT,
N_LOAD_DTS AS LOAD_DTS,
'SF_SAMPLE' AS SRC
FROM {{ ref('staging__nation') }}
{%- if is_incremental() %}
  where LOAD_DTS > (select max(LOAD_DTS) from {{ this }})
{% endif -%}