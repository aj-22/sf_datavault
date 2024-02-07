SELECT
N_NATIONKEY,
N_NAME,
N_REGIONKEY,
N_COMMENT,
CURRENT_TIMESTAMP() AS N_LOAD_DTS,
'SF_SAMPLE' AS N_SRC
FROM {{ source('TPCH','NATION') }}
{%- if is_incremental() %}
  where N_LOAD_DTS > (select max(N_LOAD_DTS) from {{ this }})
{% endif -%}