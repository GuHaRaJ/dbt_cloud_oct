

with customers as (
    select * from {{ ref('stg_customers') }}
),
nations as (
    select * from {{ ref('stg_nations') }}
),
regions as (
    select * from {{ ref('stg_regions') }}
)

select 
    c.*, 
from customers c
join nations n
    on n.nation_id = c.nation_id
join regions r
    on r.region_id = n.region_id
