-- Q10
-- Your query goes here.
drop view if exists season_riderships_view;
drop view if exists aggregated_view;
drop view if exists bypass_ratio_view;
drop view if exists max_bypass_station_view;
drop view if exists max_station_routes;

create view season_riderships_view as
    select * from rail_ridership where season == 'Fall 2019';
create view aggregated_view as
    select *, cast(sum(average_flow) as real) as a, cast(sum(average_ons + average_offs) as real) as b
        from season_riderships_view group by station_id;
create view bypass_ratio_view as
    select station_id, (a - b) / a as bypass_ratio from aggregated_view;
create view max_bypass_station_view as
    select * from bypass_ratio_view where bypass_ratio == (select max(bypass_ratio) from bypass_ratio_view);
create view max_station_routes as
    select station_orders.station_id, bypass_ratio, route_id
        from max_bypass_station_view join station_orders on max_bypass_station_view.station_id == station_orders.station_id;

select distinct station_name, line_name, bypass_ratio
    from max_station_routes join routes on max_station_routes.route_id == routes.route_id
    join lines on routes.line_id == lines.line_id
    join stations on max_station_routes.station_id == stations.station_id
    order by line_name;
