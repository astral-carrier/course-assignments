-- Q10
-- Your query goes here.
drop view if exists season_riderships_view;
drop view if exists aggregated_view;
drop view if exists bypass_ratio_view;
drop view if exists max_bypasses_view;
drop view if exists max_bypass_stations_and_lines_view;

create view season_riderships_view as
    select * from rail_ridership where season == 'Fall 2019';
create view aggregated_view as
    select *, cast(sum(average_flow) as real) as a, cast(sum(average_ons + average_offs) as real) as b
        from season_riderships_view group by station_id, line_id;
create view bypass_ratio_view as
    select *, (a - b) / a as bypass_ratio from aggregated_view;
create view max_bypasses_view as
    select line_id, max(bypass_ratio) as max_bypass_ratio
        from bypass_ratio_view group by line_id;
create view max_bypass_stations_and_lines_view as
    select station_id, bypass_ratio_view.line_id, bypass_ratio
        from bypass_ratio_view join max_bypasses_view on bypass_ratio_view.line_id == max_bypasses_view.line_id
            and bypass_ratio_view.bypass_ratio == max_bypass_ratio;

select station_name, line_name, bypass_ratio
    from max_bypass_stations_and_lines_view join stations on
        max_bypass_stations_and_lines_view.station_id == stations.station_id
    join lines on max_bypass_stations_and_lines_view.line_id == lines.line_id
    order by line_name;
