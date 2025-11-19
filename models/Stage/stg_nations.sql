
with nation as (
select 
        n_nationkey as nation_id,
        n_name as name,
        n_regionkey as region_id,
        n_comment as comments,
        {{ jodo('n_name', 'n_comment') }} as jodo_col
from {{ source ('src', 'v_nations') }}
)

select * from nation