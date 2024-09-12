-- Q6
-- Your query goes here.
drop view if exists summer_entries_view;
drop view if exists max_entries;

create view summer_entries_view as
    select station_name, gated_entries from gated_station_entries join
        stations on stations.station_id == gated_station_entries.station_id and service_date regexp '^2021-0[678]-\d\d$';
create view max_entries as
    select max(gated_entries) from summer_entries_view;

select station_name, gated_entries from summer_entries_view where gated_entries == (select * from max_entries);
