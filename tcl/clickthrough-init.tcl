
# /packages/clickthrough/tcl/clickthrough-init.tcl
# @author Nuno Santos (nuno@arsdigita.com)
# @creation-date 2000-11-22
# @cvs-id $Id$


# create a single, shared cache array and schedule a single cache sweeper for all clickthrough instances
if {![nsv_exists clickthrough_cache total_clicks]} {

    # total number of cached clicks
    nsv_set clickthrough_cache total_clicks 0

    # create a shared mutex for accessing cache
    nsv_set clickthrough_mutex mutex [ns_mutex create]

    # schedule cache sweeper to run every X seconds
    # if a clickthrough application has been created.
    if { [apm_package_id_from_key clickthrough] != 0 } {
        ad_schedule_proc [ad_parameter -package_id [apm_package_id_from_key clickthrough] CacheSweeperInterval] clickthrough_cache_sweeper
    }
}

