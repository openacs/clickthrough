<?xml version="1.0"?>
<queryset>
<fullquery name="one_url_pair">
	<querytext>
    select entry_date, click_count
      from clickthrough_log
     where local_url = :local_url
       and foreign_url = :foreign_url
       and package_id = :parent_package_id
     order by entry_date desc
	</querytext>
</fullquery>
</queryset>