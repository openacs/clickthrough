# www/admin/all-to-foreign.tcl

ad_page_contract {

    @param foreign_url The foreign URL

    @author Philip Greenspun (philg@mit.edu)
    @creation-date 1997
    @cvs-id $Id$
} {
    foreign_url
} -properties {
    context:onevalue
    urls:multirow
}

set context [list "Clickthroughs to foreign URL"]


set parent_package_id [clickthrough_parent_package_id]

template::query all_to_foreign urls multirow "
    select entry_date, sum(click_count) as n_clicks 
      from clickthrough_log
     where foreign_url = :foreign_url
       and package_id = :parent_package_id
     group by entry_date
     order by entry_date desc"

ad_return_template
