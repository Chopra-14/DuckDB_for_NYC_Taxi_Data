SELECT
    pickup_hour,
    pickup_zone,
    COUNT(*) AS trip_count,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY COUNT(*)) OVER (PARTITION BY pickup_zone) AS zone_median_hourly_trips,
    CASE WHEN COUNT(*) > 2 * PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY COUNT(*)) OVER (PARTITION BY pickup_zone)
         THEN TRUE ELSE FALSE END AS is_surge_period
FROM (
    SELECT
        DATE_TRUNC('hour', pickup_datetime) AS pickup_hour,
        pickup_zone AS pickup_zone
    FROM {{ ref('int_trips_with_zones_and_details') }}
) AS hourly
GROUP BY pickup_hour, pickup_zone
ORDER BY pickup_hour, pickup_zone;
