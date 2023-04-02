{{ config(materialized='table') }}

WITH trips AS (
    SELECT *
    FROM {{ ref('stg_bike_trips') }}
),

dim_stations AS (
    SELECT *
    FROM {{ ref('stg_stations') }}
),

dim_weather AS (
    SELECT *
    FROM {{ ref('stg_weather') }}
)

SELECT 
    trips.yearid,
    trips.start_date,
    trips.start_time,
    trips.start_station_code,
    start_station.station_name AS start_station_name,
    start_station.latitude AS start_station_latitude,
    start_station.longitude AS start_station_longitude,
    trips.end_date,
    trips.end_time,
    trips.end_station_code,
    end_station.station_name AS end_station_name,
    end_station.latitude AS end_station_latitude,
    end_station.longitude AS end_station_longitude,  
    trips.duration_sec,
    trips.is_member,
    weather.precipitation,
    weather.specific_humidity,			
    weather.relative_humidity,		
    weather.surface_pressure,		
    weather.temperature_range,			
    weather.earth_skin_temperature,		
    weather.dew_frost_point,				
    weather.wet_bulb_temperature,			
    weather.max_temperature,		
    weather.min_temperature,
    weather.avg_temperature_per_day 
FROM trips
INNER JOIN dim_stations AS start_station ON start_station.station_code = trips.start_station_code
                                         AND start_station.yearid = trips.yearid   
INNER JOIN dim_stations AS end_station ON end_station.station_code = trips.end_station_code
                                        AND end_station.yearid = trips.yearid
INNER JOIN dim_weather AS weather ON weather.`date` = trips.start_date