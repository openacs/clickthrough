# www/admin/by-foreign-url-aggregate.tcl

ad_page_contract {

    @param minimum The minimum number of clickthroughs for the displayed URLs

    @author Philip Greenspun (philg@mit.edu)
    @creation-date 1997
    @cvs-id $Id$
} {
    {minimum 0}
} -properties {
    context_bar:onevalue
    urls:multirow
}

set context_bar [ad_context_bar "Clickthroughs by local URL"]


set parent_package_id [clickthrough_parent_package_id]

template::query by_foreign_url_aggregate urls multirow "
    select local_url, foreign_url, sum(click_count) as n_clicks
      from clickthrough_log
     where package_id = :parent_package_id
     group by local_url, foreign_url 
    having sum(click_count) >= :minimum
     order by foreign_url"

ad_return_template
