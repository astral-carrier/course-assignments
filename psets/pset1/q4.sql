-- Q4
-- Your query goes here.
create view if not exists aggregates_by_route_view as
    select route_id, count(station_id) as total_stations, sum(distance_from_last_station_miles) as total_miles
        from station_orders where distance_from_last_station_miles not null group by route_id;
create view if not exists route_data_view as
    select route_id, direction, route_name
        from routes;

select route_data_view.route_id, direction, route_name, total_stations, total_miles
    from route_data_view join aggregates_by_route_view abrv on route_data_view.route_id = abrv.route_id;