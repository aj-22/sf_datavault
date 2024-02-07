{%- macro SHA_binary(Columns) -%}
SHA1_BINARY(UPPER(ARRAY_TO_STRING(ARRAY_CONSTRUCT(
{% for column in Columns %} 
    NVL(TRIM( {{column}}::VARCHAR ),'-1' )
{%- if not loop.last -%}
,
{%- endif -%}
{%- endfor -%}
                                            ), '^')))
{%- endmacro -%}