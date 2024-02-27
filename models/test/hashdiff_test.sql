{{ config(
  enabled= false) 
}}

select 
SHA1_BINARY(UPPER(ARRAY_TO_STRING(ARRAY_CONSTRUCT(value1, value2, value3),'^'))) as hashdiff,
id,
value1,
value2,
value3,
current_timestamp() ts
from {{ source('TEST','SRC') }}