{{ 
    config(
        materialized='dynamic_table',
        target_lag='5 minutes',
        snowflake_warehouse='TRANSFORM_WH',
        refresh_mode='incremental'
    ) 
}}

with customer as (

    select *
    from {{ source('src', 'customers') }}

),

nation as (

    select *
    from {{ source('src', 'nations') }}

)

select
    n.n_name,
    count(distinct c.c_custkey)       as total_customers,
    sum(c.c_acctbal)              as total_account_balance
from nation n
join customer c 
    on n.n_nationkey = c.c_nationkey
group by n.n_name
order by total_customers desc
