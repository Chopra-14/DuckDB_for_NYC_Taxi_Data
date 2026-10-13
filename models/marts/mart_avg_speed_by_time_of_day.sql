SELECT
    CASE
        WHEN EXTRACT(HOUR FROM pickup_datetime) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM pickup_datetime) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM pickup_datetime) BETWEEN 17 AND 20 THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day_bucket,
    AVG(CASE WHEN EXTRACT(EPOCH FROM (dropoff_datetime - pickup_datetime)) = 0 THEN 0
         ELSE (trip_distance / (EXTRACT(EPOCH FROM (dropoff_datetime - pickup_datetime)) / 3600.0))
    END) AS average_speed_mph
FROM {{ ref('int_trips_with_zones_and_details') }}
WHERE trip_distance >= 0
GROUP BY time_of_day_bucket
ORDER BY time_of_day_bucket;
