<master src="master">
<property name=title>Clickthroughs by foreign URL: summary report</property>
<property name="context">@context@</property>

Note: this page may be slow to generate; it requires a tremendous amount of chugging by the RDBMS.

<ul>
  <multiple name="urls">
    <li><a href="one-url-pair?local_url=<%=[ns_urlencode @urls.local_url@]%>&foreign_url=<%=[ns_urlencode @urls.foreign_url@]%>">
	  @urls.foreign_url@ (from @urls.local_url@): @urls.n_clicks@</a>
  </multiple>
</ul>

