SELECT
R_HASHKEY,
R_REGIONKEY,
R_NAME,
R_COMMENT,
R_LOAD_DTS AS LOAD_DTS,
'SF_SAMPLE' AS SRC
FROM {{ ref('staging__region') }}
{%- if is_incremental() %}
  where LOAD_DTS > (select max(LOAD_DTS) from {{ this }})
{% endif -%}