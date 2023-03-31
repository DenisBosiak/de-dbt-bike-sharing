{{ config(materialized='view') }}

with Weather as
(
    SELECT *
    FROM {{ source('staging', 'weather') }}
)

SELECT 
    CAST(`date` AS date) AS `date`,				
    CAST(prectot AS FLOAT64) AS precipitation,				
    CAST(qv2m AS FLOAT64) AS specific_humidity,			
    CAST(rh2m AS FLOAT64) AS relative_humidity,		
    CAST(ps AS FLOAT64) AS surface_pressure,		
    CAST(t2m_range AS FLOAT64) AS temperature_range,			
    CAST(ts AS FLOAT64) AS earth_skin_temperature,		
    CAST(t2mdew AS FLOAT64) AS dew_frost_point,				
    CAST(t2mwet AS FLOAT64) AS wet_bulb_temperature,			
    CAST(t2m_max AS FLOAT64) AS max_temperature,		
    CAST(t2m_min AS FLOAT64) AS min_temperature,
    CAST(t2m AS FLOAT64) AS avg_temperature_per_day 			    
FROM Weather
-- dbt var: is_test_run
{% if var('is_test_run', default=true) %}

    LIMIT 100

{% endif %}