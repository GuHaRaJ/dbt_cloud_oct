{%macro jodo(col1,col2) %}
    {{col1}} || ' ' ||{{col2}}
{% endmacro %}


{% macro gender(gn) %}
CASE
    WHEN {{ gn }} = 'M' THEN 'Male'
    WHEN {{ gn }} = 'F' THEN 'Female'
    ELSE 'Unknown'
END
{% endmacro %}

{% macro age_group(employee_age) %}
CASE
    WHEN {{ employee_age }} < 25 THEN 'Youngster'
    WHEN {{ employee_age }} < 60 THEN 'Middle'
    ELSE 'Senior'
END
{% endmacro %}

{% macro phone(ph) %}
'(' || SUBSTR({{ ph }}, 1, 3) || ') ' || SUBSTR({{ ph }}, 4, 3) || '-' || SUBSTR({{ ph }}, 7)
{% endmacro %}



-- {% macro show_emps(col1, col2) %}
--     {% set result = col1 ~ ' ' ~ col2 %}
--     {{ log(result, info=True) }}
-- {% endmacro %}


{% macro show_employee() %}
  {% set query = "select name from " ~ ref('stg_employees') %}
  {% set results = run_query(query) %}
  {{ log(results.print_table(), info=True) }}
{% endmacro %}


-- {% macro show_employees() %}
--   {% set query = "select name from " ~ ref('stg_employees') %}
--   {% set results = run_query(query) %}
--   {% do run_query(results) %}
-- {% endmacro %}

{%macro create_stage()%}
    {%do run_query("create stage dbt_stage")%}
{% endmacro %}

{% macro unload_data() %}
    {% do run_query(
        "copy into @ANALYTICS.GGG.DBT_STAGE/nations/ from " ~ ref('stg_nations') ~ 
        " partition by (nation_id) file_format = (type = csv compression = none) header = true"
    ) %}
{% endmacro %}






