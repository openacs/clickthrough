<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="clickthrough_href.clickthrough_url_sql">
      <querytext>
      select site_node__url(sn2.node_id)
          from site_nodes sn1, site_nodes sn2, apm_packages p
         where sn1.object_id = :package_id
           and sn2.parent_id = sn1.node_id
           and sn2.object_id = p.package_id
           and p.package_key = 'clickthrough'
      </querytext>
</fullquery>


<fullquery name="clickthrough_cache_sweeper.update_clickthrough_log_sql">      
      <querytext>

			update clickthrough_log
			   set click_count = click_count + :cached_click_count
			 where local_url = :cached_local_url
			   and foreign_url = :cached_foreign_url
			   and package_id = :cached_package_id
			   and trunc(entry_date) = trunc(current_time)

      </querytext>
</fullquery>

<fullquery name="clickthrough_cache_sweeper.insert_clickthrough_log_sql">
      <querytext>
       
              insert into clickthrough_log
                  (local_url, foreign_url, entry_date, click_count, package_id)
                  select :cached_local_url, :cached_foreign_url, trunc(current_time),
                      :cached_click_count, :cached_package_id
                  where 0 = (
                      select count(*)
                      from clickthrough_log
                      where local_url = :cached_local_url
                      and foreign_url = :cached_foreign_url
                      and package_id = :cached_package_id
                      and trunc(entry_date) = trunc(current_time)
                      )
        </querytext>
</fullquery>   

</queryset>
