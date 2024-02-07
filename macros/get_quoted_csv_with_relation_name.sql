 {% macro get_quoted_csv_with_relation_name(column_names, relation_name) %} 
  
    {% set quoted = [] %} 
    {%- set relation -%}
        {{ relation_name }}
    {%- endset -%}

    {% for col in column_names -%} 
        {%- do quoted.append(  relation + "." + adapter.quote(col)) -%} 
    {%- endfor %} 

    {%- set dest_cols_csv = quoted | join(', ') -%} 
    {{ return(dest_cols_csv) }} 
  
 {% endmacro %} 