{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}

    {# 1. If there is no custom configuration, just use the profile schema (DBT_G_DBT) #}
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {# 2. If there IS a custom config, check which environment we are in #}
    {%- else -%}

        {# If we are in 'prod', use the custom schema exactly as written (e.g. dw_production) #}
        {%- if target.name == 'prod' -%}
            {{ custom_schema_name | trim }}

        {# If we are in 'dev', prefix it with your user schema (e.g. DBT_G_DBT_dw_production) #}
        {%- else -%}
            {{ default_schema }}_{{ custom_schema_name | trim }}
        {%- endif -%}

    {%- endif -%}

{%- endmacro %}