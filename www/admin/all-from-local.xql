<?xml version="1.0"?>
<queryset>
<fullquery name="all_from_local">
	<querytext>
    select entry_date, sum(click_count) as n_clicks
      from clickthrough_log
     where local_url = :local_url
       and package_id = :parent_package_id
     group by entry_date
     order by entry_date desc
	</querytext>
</fullquery>
</queryset>
