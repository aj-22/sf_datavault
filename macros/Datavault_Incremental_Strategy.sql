{% macro get_incremental_hashdiff_insert_sql(arg_dict) %}

  {% do return(insert_with_hashdiff(arg_dict["target_relation"], arg_dict["temp_relation"], arg_dict["unique_key"], arg_dict["dest_columns"], arg_dict["incremental_predicates"])) %}

{% endmacro %}


{% macro insert_with_hashdiff(target_relation, temp_relation, unique_key, dest_columns, incremental_predicates) %}

    {%- set dest_cols_csv = get_quoted_csv(dest_columns | map(attribute="name")) -%}
    {%- set dest_cols_csv_with_relation_name = get_quoted_csv_with_relation_name(dest_columns | map(attribute="name"), temp_relation) -%}

    insert into {{ target_relation }} ({{ dest_cols_csv }})
    (
        select {{ dest_cols_csv_with_relation_name }}
        from {{ temp_relation }}
        left join {{ target_relation }} on {{ target_relation }}.{{ unique_key }} = {{ temp_relation }}.{{ unique_key }} 
        where {{ target_relation }}.{{ unique_key }} is NULL
    )


{% endmacro %}