-- Q7
-- Your query goes here.
drop view if exists max_entry_view;

create view max_entry_view as
    select * from rail_ridership where total_offs == (select max(total_offs) from rail_ridership);

select day_type, period_start_time, season, line_id, station_name, total_offs
    from max_entry_view join time_periods on max_entry_view.time_period_id == time_periods.time_period_id
    join stations on max_entry_view.station_id == stations.station_id;
