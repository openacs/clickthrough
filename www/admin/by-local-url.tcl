# www/admin/by-local-url.tcl

ad_page_contract {

    @author Philip Greenspun (philg@mit.edu)
    @creation-date 1997
    @cvs-id $Id$
} {
    
} -properties {
    context_bar:onevalue
    urls:multirow
}

set context_bar [ad_context_bar "Clickthroughs by local URL"]


set parent_package_id [clickthrough_parent_package_id]

template::query urls multirow "
    select distinct local_url, foreign_url 
      from clickthrough_log
     where package_id = :parent_package_id
     order by local_url"

ad_return_template