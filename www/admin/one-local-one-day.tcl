# www/admin/one-local-one-day.tcl

ad_page_contract {

    @param local_url The local/originating URL
    @param query_date The date for the clickthrough count

    @author Philip Greenspun (philg@mit.edu)
    @creation-date 1997
    @cvs-id $Id$
} {
    local_url
    query_date   
} -properties {
    context:onevalue
    urls:multirow
}

set context [list [list "all-from-local?[export_url_vars local_url]" "Clickthroughs from local URL"] "On $query_date"]


set parent_package_id [clickthrough_parent_package_id]

template::query one_local_one_day urls multirow "
    select foreign_url, click_count
      from clickthrough_log
     where local_url = :local_url
       and entry_date = :query_date
       and package_id = :parent_package_id
     order by foreign_url"

ad_return_template

