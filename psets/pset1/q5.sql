-- Q5
-- Your query goes here.
select station_name, season, avg(number_service_days) as average_service_days
    from rail_ridership join stations on rail_ridership.station_id == stations.station_id
    group by station_name, season order by average_service_days desc, season, station_name;
