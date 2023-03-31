{{ config(materialized='view') }}

with Stations as
(
    SELECT *
    FROM {{ source('staging', 'stations') }}
)

SELECT 
    CAST(code AS int) AS station_code,
    CAST(name AS varchar(200)) AS station_name,
    CAST(latitude AS float) AS latitude,
    CAST(longitude AS ) AS longitude,
    CAST(yearid AS int) AS yearid 
FROM Stations
-- dbt var: is_test_run
{% if var('is_test_run', default=true) %}

    LIMIT 100

{% endif %}