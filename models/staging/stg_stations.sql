{{ config(materialized='view') }}

SELECT 
    CAST(code AS int) AS station_code,
    CAST(name AS string) AS station_name,
    CAST(latitude AS FLOAT64) AS latitude,
    CAST(longitude AS FLOAT64) AS longitude,
    CAST(yearid AS int) AS yearid 
FROM {{ source('staging', 'stations') }}
-- dbt var: is_test_run
{% if var('is_test_run', default=true) %}

    LIMIT 100

{% endif %}