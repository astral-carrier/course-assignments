-- Q3
-- Your query goes here.
drop view if exists accepted_periods_view
drop view if exists selected_station_view

create view accepted_periods_view as
    select time_period_id from time_periods where time_period_id == 'time_period_06' or time_period_id == 'time_period_07';
create view selected_station_view as
    select station_id from stations where station_name == 'Kendall/MIT'

select season, line_id, direction, total_ons
    from rail_ridership join accepted_periods_view apv on rail_ridership.time_period_id = apv.time_period_id
    join selected_station_view ssv on rail_ridership.station_id = ssv.station_id
    order by season, direction;
