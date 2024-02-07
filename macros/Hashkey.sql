{% macro Hashkey(source, key_column) %}
SHA1_BINARY(UPPER(ARRAY_TO_STRING(ARRAY_CONSTRUCT(
    source, NVL(TRIM( {{key_column}}::VARCHAR ),'-1' )
), '^')))
{% endmacro %}