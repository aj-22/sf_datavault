SELECT
{{ SHA_binary(Columns=['O_HASHKEY','C_HASHKEY'] ) }} AS LCO_HASHKEY,
O.O_HASHKEY,
C.C_HASHKEY,
O.O_LOAD_DTS as LOAD_DTS,
'SF_SAMPLE' AS SRC
FROM {{ ref('staging__orders') }} O
LEFT JOIN {{ ref('staging__customer') }} C
ON O.O_CUSTKEY = C.C_CUSTKEY
{%- if is_incremental() %}
  where LOAD_DTS > (select max(LOAD_DTS) from {{ this }})
{% endif -%}
