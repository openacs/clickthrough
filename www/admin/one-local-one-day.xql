<?xml version="1.0"?>
<queryset>
<fullquery name="one_local_one_day">
	<querytext>
    select foreign_url, click_count
      from clickthrough_log
     where local_url = :local_url
       and entry_date = :query_date
       and package_id = :parent_package_id
     order by foreign_url
	</querytext>
</fullquery>
</queryset>

