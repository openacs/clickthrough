# www/admin/report.tcl

ad_page_contract {

    @author Philip Greenspun (philg@mit.edu)
    @creation-date 1997
    @cvs-id $Id$
} {    

} -properties {
    context:onevalue
    package_name:onevalue
}
 
# this really should be index.tcl but sadly due to legacy links 
#  (dating back to 1996 or so), it has to be "report.tcl"


set package_name [clickthrough_parent_package_instance_name]

set context [list]

ad_return_template
