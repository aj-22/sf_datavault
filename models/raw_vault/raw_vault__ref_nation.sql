SELECT
{{ SHA_binary(Columns = [
  'N_SRC',
  'N_NATIONKEY'
])}} AS N_HASHKEY,,
N_NATIONKEY,
N_NAME,
N_REGIONKEY,
N_COMMENT,
N_LOAD_DTS AS REF_LOAD_DTS,
{{ SHA_binary(Columns = [
  'N_NAME', 'N_REGIONKEY', 'N_COMMENT'
] ) }} AS HASHDIFF,
N_SRC AS SRC
FROM {{ ref('staging__nation') }}
{%- if is_incremental() %}
  where LOAD_DTS > (select max(LOAD_DTS) from {{ this }})
{% endif -%}