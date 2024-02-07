SELECT
R_REGIONKEY,
R_NAME,
R_COMMENT,
CURRENT_TIMESTAMP() AS R_LOAD_DTS,
'SF_SAMPLE' AS R_SRC
FROM {{ source('TPCH','REGION') }}
{%- if is_incremental() %}
  where R_LOAD_DTS > (select max(R_LOAD_DTS) from {{ this }})
{% endif -%}