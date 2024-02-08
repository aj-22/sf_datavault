SELECT
{{ SHA_binary(Columns = [
  'R_SRC',
  'R_REGIONKEY'
])}} AS HASHKEY,
R_REGIONKEY,
R_NAME,
R_COMMENT,
R_LOAD_DTS AS REF_LOAD_DTS,
{{ SHA_binary(Columns = [
    'R_NAME',
    'R_COMMENT'
]) }} AS HASHDIFF,
R_SRC AS SRC
FROM {{ ref('staging__region') }}