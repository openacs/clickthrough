# www/admin/all-from-local.tcl

ad_page_contract {

    @param local_url The local/originating URL

    @author Philip Greenspun (philg@mit.edu)
    @creation-date 1997
    @cvs-id $Id$
} {
    local_url
} -properties {
    context:onevalue
    urls:multirow
}

set context [list "Clickthroughs from local URL"]


set parent_package_id [clickthrough_parent_package_id]

template::query all_from_local urls multirow "
    select entry_date, sum(click_count) as n_clicks
      from clickthrough_log
     where local_url = :local_url
       and package_id = :parent_package_id
     group by entry_date
     order by entry_date desc"

ad_return_template
