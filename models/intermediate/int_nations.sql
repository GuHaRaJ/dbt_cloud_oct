{{ 
  config(
    materialized = 'incremental',
    unique_key = 'nation_id'
  ) 
}}

WITH int_nat AS (
    SELECT *
    FROM {{ ref('stg_nations') }}
    {% if is_incremental() %}
        WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})
    {% endif %}
)
SELECT *
FROM int_nat
