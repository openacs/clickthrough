
ad_library {
    Tcl helper procs for the Clickthrough package.

    @author Nuno Santos (nuno@arsdigita.com)
    @creation-date 2000-11-16
    @cvs-id $Id$
}

ad_proc clickthrough_href {href_url} {
    Detects if a clickthrough instance is mounted beneath the current package 
    (ie, if the current package is interested in tracking clickthroughs). 
    Builds the href part of a clickthrough-enabled (or plain) HTML link based on the presence (or not) of such a clickthrough instance.

    @param href_url The URL to link to

    @author Nuno Santos (nuno@arsdigita.com)
    @creation-date 2000-11-16
    @cvs-id $Id$
} {
    set package_id [ad_conn package_id]

    # check to see if there is a clickthrough instance mounted below the current package mount point and
    #  if so, return the appropriate url (eg, /parent_package_url/click_url/); otherwise, return empty string
    set clickthrough_url [db_string clickthrough_url_sql "select site_node.url(sn2.node_id) 
          from site_nodes sn1, site_nodes sn2, apm_packages p 
         where sn1.object_id = :package_id
           and sn2.parent_id = sn1.node_id
           and sn2.object_id = p.package_id
           and p.package_key = 'clickthrough'" -default ""]

    if {[empty_string_p $clickthrough_url]} {
	# no clickthrough application mounted beneath this package's mounting point,
	# so just make plain link

	return $href_url
    } else {
	# a clickthrough application is available for logging this click,
	# so build appropriate link: 
	#  clickthrough_url = /parent_package_url/click_url/
	#  + extra_url = local page's relative url to package's root

	return "$clickthrough_url[ad_conn extra_url]?send_to=[ad_urlencode $href_url]"
    }
}


ad_proc clickthrough_link {href_url link_content {link_attributes ""}} {
    Detects if a clickthrough instance is mounted beneath the current package 
    (ie, if the current package is interested in tracking clickthroughs). 
    Builds a full clickthrough-enabled (or plain) HTML link based on the presence (or not) of such a clickthrough instance.

    @param href_url The URL to link to
    @param link_content The content that goes between the <A>...</A> tags
    @param link_attributes Any additional attributes to go inside the <A> tag

    @author Nuno Santos (nuno@arsdigita.com)
    @creation-date 2000-11-16
    @cvs-id $Id$
} {
    return "<a href=\"[clickthrough_href $href_url]\" $link_attributes>$link_content</a>"
}


ad_proc clickthrough_parent_package_id {} {
    Returns the package_id of the parent package of this clickthrough instance

    @author Nuno Santos (nuno@arsdigita.com)
    @creation-date 2000-11-16
    @cvs-id $Id$
} {
    set clickthrough_package_id [ad_conn package_id]

    set parent_package_id [db_string parent_package_id_sql "
      select sn2.object_id as parent_package_id
        from site_nodes sn1, site_nodes sn2 
       where sn1.object_id = :clickthrough_package_id 
         and sn1.parent_id = sn2.node_id"]

    return $parent_package_id
}

ad_proc clickthrough_parent_package_instance_name {} {
    Returns the instance_name of the parent package of this clickthrough instance

    @author Nuno Santos (nuno@arsdigita.com)
    @creation-date 2000-11-16
    @cvs-id $Id$
} {
    set clickthrough_package_id [ad_conn package_id]

    set parent_package_instance_name [db_string parent_package_id_sql "
      select instance_name
        from site_nodes sn1, site_nodes sn2, apm_packages p
       where sn1.object_id = :clickthrough_package_id 
         and sn1.parent_id = sn2.node_id
         and p.package_id = sn2.object_id"]

    return $parent_package_instance_name
}

ad_proc clickthrough_log_click {local_url foreign_url package_id} {
    Logs a clickthrough from a local URL to a foreign URL.

    @param local_url The local URL, origin of the clickthrough
    @param foreign_url The foreign URL, destination of the clickthrough
    @param package_id The id of the parent package of the local URL

    @author Nuno Santos (nuno@arsdigita.com)
    @creation-date 2000-11-16
    @cvs-id $Id$
} {
    # cache_key has the following format: 
    # <local_url><space><space>*Foreign*<space><space><foreign_url><space><space>*Package*<space><space><package_id>
    append cache_key $local_url "  *Foreign*  " $foreign_url "  *Package*  " $package_id

    if {[catch {
	# update or set the new click count for this local_url/foreign_url/package_id tuple
	if {[nsv_exists clickthrough_cache $cache_key]} {
	    nsv_incr clickthrough_cache $cache_key
	} else {
	    nsv_set clickthrough_cache $cache_key 1
	}

	# increment the total click count
	nsv_incr clickthrough_cache total_clicks
    } errmsg]} {
	ns_log Warning "Clickthrough counting failed -> local_url: '$local_url' ; foreign_url: '$foreign_url' ;  package_id: '$package_id' ; error message:\n$errmsg"
    }
}


ad_proc clickthrough_cache_sweeper {} {
    Periodicaly runs to see if cache has reached limit capacity. If so, dumps cache contents to database and resets cache.

    @author Nuno Santos (nuno@arsdigita.com)
    @creation-date 2000-12-04
    @cvs-id $Id$
} {
    if {[nsv_get clickthrough_cache total_clicks] >= [ad_parameter -package_id [apm_package_id_from_key clickthrough] MaxNumberOfCachedClicks]} {
        # reached cache maximum size -> make a copy (to later write to db) and clear cache

	ns_log debug "clickthrough_cache_sweeper: reached cache maximum size, dumping to database"

	# lock access to cache -- only during in memory cache copy, no DB access
	ns_mutex lock [nsv_get clickthrough_mutex mutex]
	
	array set cache_copy [nsv_array get clickthrough_cache]
	set new_cache(total_clicks) 0
	nsv_array reset clickthrough_cache [array get new_cache]

	# unlock access to cache
	ns_mutex unlock [nsv_get clickthrough_mutex mutex]


	# copy of cache must be written to database

	# don't include the "total_clicks" element in the search
	array unset cache_copy "total_clicks"
	
	set search_id [array startsearch cache_copy]

	# iterate through all the keys in the cache
	while {[array anymore cache_copy $search_id]} {
	    set cache_key [array nextelement cache_copy $search_id]
	    
	    # cache_key has the following format: 
	    # <local_url><space><space>*Foreign*<space><space><foreign_url><space><space>*Package*<space><space><package_id>
	    if {[regexp {^(.*)  \*Foreign\*  (.*)  \*Package\*  ([0-9]*)$} $cache_key match cached_local_url \
		    cached_foreign_url cached_package_id]} {

	        set cached_click_count $cache_copy($cache_key)
	    
	        # actually do the update/insert in the database
		db_transaction {
		    # update count, if appropriate row already exists
		    db_dml update_clickthrough_log_sql {
			update clickthrough_log 
			   set click_count = click_count + :cached_click_count
			 where local_url = :cached_local_url 
			   and foreign_url = :cached_foreign_url
			   and package_id = :cached_package_id
			   and trunc(entry_date) = trunc(sysdate)
		    }
		
		    set n_rows [db_resultrows]
		    if { $n_rows == 0 } {
			# there wasn't already a row there
			# let's insert one (but only one; in the very rare case that another thread is executing
			# this same code, we don't want to be left with two rows in the database for the same tuple)
		    
			if {[catch {db_dml insert_clickthrough_log_sql {
			    insert into clickthrough_log 
			      (local_url, foreign_url, entry_date, click_count, package_id)
			      select :cached_local_url, :cached_foreign_url, trunc(sysdate), :cached_click_count, :cached_package_id
			        from dual
			       where 0 = (select count(*)
			                    from clickthrough_log
			                   where local_url = :cached_local_url 
			                     and foreign_url = :cached_foreign_url
			                     and package_id = :cached_package_id
			                     and trunc(entry_date) = trunc(sysdate)) } } errmsg]} {
			        ns_log Warning "Clickthrough insert failed:  $errmsg"
			    }
		    }
		}
	    } else {
		ns_log Warning "clickthrough_cache_sweeper: error reading cache entry. Some clickthroughs may have been lost."
	    }
	}
	
	array donesearch cache_copy $search_id
    }
}


