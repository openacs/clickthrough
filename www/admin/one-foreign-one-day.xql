<?xml version="1.0"?>
<queryset>
<fullquery name="one_foreign_one_day">
	<querytext>
    select local_url, click_count
      from clickthrough_log
     where foreign_url = :foreign_url
       and entry_date = :query_date
       and package_id = :parent_package_id
     order by local_url
	</querytext>
</fullquery>
</queryset>












