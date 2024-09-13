-- Q9
-- Your query goes here.
drop view if exists station_route_counts_view;
drop view if exists max_routes_station_view;
drop view if exists max_station_routes_view;

create view station_route_counts_view as
    select *, count(route_id) as route_count from station_orders group by station_id;
create view max_routes_station_view as
    select station_id, route_count from station_route_counts_view where route_count == (select max(route_count) from station_route_counts_view);
create view max_station_routes_view as
    select station_orders.station_id, route_id, route_count
        from station_orders join max_routes_station_view on station_orders.station_id == max_routes_station_view.station_id;

select station_name, routes.route_id, line_id, route_count
    from max_station_routes_view join stations on stations.station_id == max_station_routes_view.station_id
    join routes on max_station_routes_view.route_id == routes.route_id;
