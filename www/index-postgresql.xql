<?xml version="1.0"?>
<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>
<fullquery name="parent_package_sql">
	<querytext>
select sn2.object_id as parent_package_id, 
                                   site_node__url(sn2.node_id) as parent_package_url
                              from site_nodes sn1, site_nodes sn2 
                             where sn1.object_id = :clickthrough_package_id 
                               and sn1.parent_id = sn2.node_id
	</querytext>
</fullquery>
</queryset>