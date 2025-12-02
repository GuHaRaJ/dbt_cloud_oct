{{ config(materialized='incremental')}}
with supps as(
    select
    supplier_id,
    supplier_name,
    account_balance,
    phone_number,
    supplier_address,
    nation_name,
    region_name,
    updated_time
    from {{ref('int_suppliers')}}

    {% if is_incremental() %}
    where updated_time < (select max(updated_time) from {{this}})
    {% endif %}
)

select *, {{dbt_meta()}}
from supps