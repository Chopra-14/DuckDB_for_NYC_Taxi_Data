SELECT
    CAST(CONCAT(CAST(t.tpep_pickup_datetime AS VARCHAR), '_', CAST(t.PULocationID AS VARCHAR), '_', CAST(t.DOLocationID AS VARCHAR)) AS VARCHAR) AS trip_id,
    t.tpep_pickup_datetime AS pickup_datetime,
    t.tpep_dropoff_datetime AS dropoff_datetime,
    CAST(t.PULocationID AS INTEGER) AS pickup_location_id,
    CAST(t.DOLocationID AS INTEGER) AS dropoff_location_id,
    CAST(t.trip_distance AS DOUBLE) AS trip_distance,
    CAST(t.payment_type AS INTEGER) AS payment_type
FROM {{ source('nyc_taxi', 'yellow_tripdata') }} AS t
WHERE t.tpep_pickup_datetime IS NOT NULL
