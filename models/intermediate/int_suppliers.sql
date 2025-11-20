{{ config(
    tags='sample'
) }}

with supplier as (
    select * from {{ ref('stg_suppliers') }}
),
nations as (
    select * from {{ ref('stg_nations') }}
),
regions as (
    select * from {{ ref('stg_regions') }}
)

select 
    c.*
from supplier c
join nations n
    on n.nation_id = c.nation_id
join regions r
    on r.region_id = n.region_id
