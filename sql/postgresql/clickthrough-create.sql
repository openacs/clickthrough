--
-- packages/clickthrough/sql/clickthorugh-create.sql
--
-- @author Philip Greenspun (philg@mit.edu)
-- @creation-date 1997
-- @cvs-id $Id$
--


create table clickthrough_log (
    -- URLs can't be too long or they won't be indexable in Oracle
    local_url	varchar(400) not null,   -- local URL does not include starting /
    foreign_url	varchar(400) not null,	  -- full URL on the foreign server
    entry_date	date,	                  -- clickthrough counts are daily counts
    click_count	integer default 0,
    package_id  constraint ct_log_package_id_fk
		references apm_packages(package_id),
    constraint ct_log_pk primary key (local_url, foreign_url, entry_date)
);
