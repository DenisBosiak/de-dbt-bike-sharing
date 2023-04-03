{{ config(materialized='view') }}

SELECT
    CAST(start_date AS date) AS start_date,		
    CAST(start_time AS time) AS start_time,
    CAST(start_station_code AS int) AS start_station_code,			
    CAST(end_date AS date) AS end_date,			
    CAST(end_time AS time) AS end_time,
    CAST(end_station_code AS int) AS end_station_code,			
    CAST(duration_sec AS FLOAT64) AS duration_sec,			
    CAST(is_member AS int) AS is_member,	
    {{ get_driver_type_description('is_member') }} AS is_member_description,	
    CAST(yearid AS int) AS yearid			
FROM {{ source('staging', 'sharing_trips') }}
WHERE start_date >= '2011-01-01'
    AND start_date < '2021-01-01'
-- dbt var: is_test_run
{% if var('is_test_run', default=true) %}

    LIMIT 100

{% endif %}