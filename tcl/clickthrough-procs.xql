<?xml version="1.0"?>
<queryset>

<fullquery name="clickthrough_parent_package_id.parent_package_id_sql">      
      <querytext>
      
      select sn2.object_id as parent_package_id
        from site_nodes sn1, site_nodes sn2 
       where sn1.object_id = :clickthrough_package_id 
         and sn1.parent_id = sn2.node_id
      </querytext>
</fullquery>

 
<fullquery name="clickthrough_parent_package_id.parent_package_id_sql">      
      <querytext>
      
      select sn2.object_id as parent_package_id
        from site_nodes sn1, site_nodes sn2 
       where sn1.object_id = :clickthrough_package_id 
         and sn1.parent_id = sn2.node_id
      </querytext>
</fullquery>

 
</queryset>
