SELECT
    {{ source('nyc_taxi', 'taxi_zone_lookup') }}.LocationID AS location_id,
    {{ source('nyc_taxi', 'taxi_zone_lookup') }}.Borough AS borough,
    {{ source('nyc_taxi', 'taxi_zone_lookup') }}.Zone AS zone
FROM {{ source('nyc_taxi', 'taxi_zone_lookup') }}
