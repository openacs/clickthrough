# www/admin/one-url-pair.tcl

ad_page_contract {

    @param local_url The local/originating URL
    @param foreign_url The foreign/destination URL

    @author Philip Greenspun (philg@mit.edu)
    @creation-date 1997
    @cvs-id $Id$
} {
    local_url
    foreign_url    
} -properties {
    context_bar:onevalue
    urls:multirow
}

set context_bar [ad_context_bar "Clickthroughs for one URL pair"]


set parent_package_id [clickthrough_parent_package_id]
template::query urls multirow "
    select entry_date, click_count
      from clickthrough_log
     where local_url = :local_url
       and foreign_url = :foreign_url
       and package_id = :parent_package_id
     order by entry_date desc"

ad_return_template
