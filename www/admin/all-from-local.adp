<master src="master">
<property name=title>Clickthroughs from @local_url@</property>
<property name="context">@context@</property>

Clickthroughs from <a href="@local_url@">@local_url@</a>

<ul>
  <multiple name="urls">
    <li>@urls.entry_date@ : 
	<a href="one-local-one-day?local_url=<%=[ns_urlencode @local_url@]%>&query_date=<%=[ns_urlencode @urls.entry_date@]%>">
	  @urls.n_clicks@</a></li>
  </multiple>
</ul>

