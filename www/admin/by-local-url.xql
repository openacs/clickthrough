<?xml version="1.0"?>
<queryset>
<fullquery name="by_local_url">
	<querytext>

    select distinct local_url, foreign_url 
      from clickthrough_log
     where package_id = :parent_package_id
     order by local_url

	</querytext>
</fullquery>
</queryset>
