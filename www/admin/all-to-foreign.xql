<?xml version="1.0"?>
<queryset>

<fullquery name="all_to_foreign">
	<querytext>
	    select entry_date, sum(click_count) as n_clicks 
      from clickthrough_log
     where foreign_url = :foreign_url
       and package_id = :parent_package_id
     group by entry_date
     order by entry_date desc
	</querytext>
</fullquery>
</queryset>
