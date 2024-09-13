-- Q8
-- Your query goes here.
drop view if exists accepted_riderships_view;
drop view if exists above_average_view;

create view accepted_riderships_view as
    select * from rail_ridership where time_period_id == 'time_period_01' and direction == 0 and season == 'Fall 2018'
    and line_id == 'orange';
create view above_average_view as
    select * from accepted_riderships_view where total_ons >= (select avg(total_ons) from accepted_riderships_view);

select station_name, total_ons
    from above_average_view join stations on above_average_view.station_id == stations.station_id
    order by total_ons desc, station_name;
