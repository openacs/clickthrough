<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="clickthrough_cache_sweeper.update_clickthrough_log_sql">      
      <querytext>
      
			update clickthrough_log 
			   set click_count = click_count + :cached_click_count
			 where local_url = :cached_local_url 
			   and foreign_url = :cached_foreign_url
			   and package_id = :cached_package_id
			   and trunc(entry_date) = trunc(sysdate)
		    
      </querytext>
</fullquery>

 
</queryset>
