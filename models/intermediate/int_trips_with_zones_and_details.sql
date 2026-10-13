SELECT
    stg.trip_id,
    stg.pickup_datetime,
    stg.dropoff_datetime,
    stg.pickup_location_id,
    stg.dropoff_location_id,
    stg.trip_distance,
    stg.payment_type,
    pickup.zone AS pickup_zone,
    pickup.borough AS pickup_borough,
    dropoff.zone AS dropoff_zone,
    dropoff.borough AS dropoff_borough,
    EXTRACT(EPOCH FROM (stg.dropoff_datetime - stg.pickup_datetime)) AS trip_duration_seconds,
    CASE WHEN EXTRACT(EPOCH FROM (stg.dropoff_datetime - stg.pickup_datetime)) = 0 THEN 0
         ELSE (stg.trip_distance / (EXTRACT(EPOCH FROM (stg.dropoff_datetime - stg.pickup_datetime)) / 3600.0))
    END AS average_speed_mph
FROM {{ ref('stg_yellow_tripdata') }} AS stg
LEFT JOIN {{ ref('stg_taxi_zone_lookup') }} AS pickup
  ON stg.pickup_location_id = pickup.location_id
LEFT JOIN {{ ref('stg_taxi_zone_lookup') }} AS dropoff
  ON stg.dropoff_location_id = dropoff.location_id
WHERE stg.trip_distance >= 0
