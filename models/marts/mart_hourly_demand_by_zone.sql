SELECT
    DATE_TRUNC('hour', pickup_datetime) AS pickup_hour,
    pickup_zone AS pickup_zone,
    COUNT(*) AS trip_count
FROM {{ ref('stg_yellow_tripdata') }} AS trips
JOIN {{ ref('stg_taxi_zone_lookup') }} AS zones
  ON trips.pickup_location_id = zones.location_id
GROUP BY pickup_hour, pickup_zone
ORDER BY pickup_hour, pickup_zone;
