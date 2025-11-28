with source as (
    select * from {{ source('src_1', 'STG_EMPLOYEES') }}
),
changed as (
    select
    -- seqpay.nextVal as employee_key,
    employee_id as id,
    {{jodo('employee_first_name','employee_last_name')}} as name,
    employee_address as address,
    employee_city as city,
    employee_state as state,
    employee_zip_code,
    employee_mobile,
    {{phone('employee_fixedline')}} as employee_fixedline,
    employee_email,
    {{gender('employee_gender')}} as gender,
    employee_age,
    {{age_group('employee_age')}} as age_group,
    position_type,
    dealership_id,
    dealership_manager,
    salary,
    region
     from source
)
select * from changed