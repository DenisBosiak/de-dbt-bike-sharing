{{ config(materialized='view') }}

with Weather as
(
    SELECT *
    FROM {{ source('staging', 'weather') }}
)

SELECT 
    CAST([date] AS date) AS [date]				
    CAST(prectot AS float) AS precipitation				
    CAST(qv2m AS float) AS specific_humidity			
    CAST(rh2m AS float) AS relative_humidity		
    CAST(ps AS float) AS surface_pressure 		
    CAST(t2m_range AS float) AS temperature_range			
    CAST(ts AS float) AS earth_skin_temperature		
    CAST(t2mdew AS float) AS dew_frost_point				
    CAST(t2mwet AS float) AS wet_bulb_temperature			
    CAST(t2m_max AS float) AS max_temperature			
    CAST(t2m_min AS float) AS min_temperature
    CAST(t2m AS float) AS avg_temperature_per_day 			    
FROM Weather
-- dbt var: is_test_run
{% if var('is_test_run', default=true) %}

    LIMIT 100

{% endif %}