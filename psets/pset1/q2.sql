-- Q2
-- Your query goes here.
drop view if exists first_station_names_view;
drop view if exists last_station_names_view;
drop view if exists line_names_view;

create view first_station_names_view as
    select route_id, station_name as first_station_name
        from routes join stations on first_station_id == station_id;
create view last_station_names_view as
    select route_id, station_name as last_station_name
        from routes join stations on last_station_id == station_id;
create view line_names_view as
    select route_id, line_name
        from routes join lines on routes.line_id == lines.line_id;

select line_name, direction_desc, first_station_name, last_station_name
    from routes join first_station_names_view fsn on routes.route_id = fsn.route_id
    join last_station_names_view lsn on routes.route_id = lsn.route_id
    join line_names_view lnv on routes.route_id = lnv.route_id
    order by line_name, direction_desc, first_station_name, last_station_name;