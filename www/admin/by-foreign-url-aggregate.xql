<?xml version="1.0"?>
<queryset>

<fullquery name="by_foreign_url_aggregate">
	<querytext>
    select local_url, foreign_url, sum(click_count) as n_clicks
      from clickthrough_log
     where package_id = :parent_package_id
     group by local_url, foreign_url 
    having sum(click_count) >= :minimum
     order by foreign_url
	</querytext>
</fullquery>
</queryset>