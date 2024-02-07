SELECT
N_NATIONKEY,
N_NAME,
N_REGIONKEY,
N_COMMENT,
{{ SHA_binary(Columns = ['N_NAME', 'N_COMMENT'] ) }} AS N_HASHKEY,
CURRENT_TIMESTAMP() AS N_LOAD_DTS
FROM {{ source('TPCH','NATION') }}
{%- if is_incremental() %}
  where N_LOAD_DTS > (select max(N_LOAD_DTS) from {{ this }})
{% endif -%}