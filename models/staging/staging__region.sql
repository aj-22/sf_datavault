SELECT
R_REGIONKEY,
R_NAME,
R_COMMENT,
{{ SHA_binary(Columns = [
    'R_NAME',
    'R_COMMENT'
]) }} AS R_HASHKEY,
CURRENT_TIMESTAMP() AS R_LOAD_DTS
FROM {{ source('TPCH','REGION') }}
{%- if is_incremental() %}
  where R_LOAD_DTS > (select max(R_LOAD_DTS) from {{ this }})
{% endif -%}