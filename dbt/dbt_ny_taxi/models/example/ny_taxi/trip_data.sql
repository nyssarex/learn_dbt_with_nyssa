with source_table as (
    SELECT  
a.index
, b."Borough" as from_borough
, b."Zone" as from_zone
,tpep_pickup_datetime
, c."Borough" as to_Borough
, c."Zone" as to_zone
, tpep_dropoff_datetime
, trip_distance
, passenger_count
,case when "RatecodeID"= 1 then 'Standard rate'
	  when "RatecodeID"=2 then 'JFK'
	  when "RatecodeID"=3 then 'Newark'
	  when "RatecodeID"=4 then 'Nassau/Westchester'
	  when "RatecodeID"=5 then 'Negotiated fare'
	  when "RatecodeID"=6 then 'Group ride'
	  end as type_of_rate
,case when payment_type=1 then 'Credit card'
	  when payment_type=2 then 'Cash'
	  when payment_type=3 then 'No charge'
	  when payment_type=4 then 'Dispute'
	  when payment_type=5 then 'Unknown'
	  when payment_type=6 then 'Voided trip'
	  end as type_of_payment
, fare_amount
, extra
, mta_tax
, tip_amount
, tolls_amount
, total_amount
, congestion_surcharge
, "Airport_fee"
	FROM {{source('ny_taxi','yellow_taxi_data')}} a
	left join {{source('ny_taxi','taxi_zone_area')}} b on a."PULocationID" = b."LocationID" 
	left join {{source('ny_taxi','taxi_zone_area')}} c on a."DOLocationID" = c."LocationID" 
)

select * from source_table
	