-- Q4
-- Your query goes here.
drop view if exists aggregates_by_route_view;
drop view if exists route_data_view;

create view aggregates_by_route_view as
    select route_id, count(station_id) as total_stations, sum(distance_from_last_station_miles) as total_miles
        from station_orders where distance_from_last_station_miles not null group by route_id;
create view route_data_view as
    select route_id, direction, route_name
        from routes;

select route_data_view.route_id, direction, route_name, total_stations, total_miles
    from route_data_view join aggregates_by_route_view abrv on route_data_view.route_id = abrv.route_id
    order by total_stations desc, total_miles desc;