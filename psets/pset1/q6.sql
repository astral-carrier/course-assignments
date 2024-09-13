-- Q6
-- Your query goes here.
drop view if exists summer_entries_view;

create view summer_entries_view as
    select station_name, sum(gated_entries) as gated_entries_sum
        from gated_station_entries join stations on stations.station_id == gated_station_entries.station_id and
                                                    service_date regexp '^2021-0[678]-\d\d$'
        group by station_name;

select station_name, gated_entries_sum
    from summer_entries_view where gated_entries_sum == (select max(gated_entries_sum) from summer_entries_view);
