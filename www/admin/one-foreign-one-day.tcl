# www/admin/one-foreign-one-day.tcl

ad_page_contract {

    @param foreign_url The foreign/destination URL
    @param query_date The date for the clickthrough count

    @author Philip Greenspun (philg@mit.edu)
    @creation-date 1997
    @cvs-id $Id$
} {
    foreign_url
    query_date  
} -properties {
    context_bar:onevalue
    urls:multirow
}

set context_bar [ad_context_bar [list "all-to-foreign?[export_url_vars foreign_url]" "Clickthroughs to foreign URL"] "On $query_date"]


set parent_package_id [clickthrough_parent_package_id]

template::query urls multirow "
    select local_url, click_count
      from clickthrough_log
     where foreign_url = :foreign_url
       and entry_date = :query_date
       and package_id = :parent_package_id
     order by local_url"

ad_return_template
