<master src="/www/default-master">
<property name=title>Clickthroughs from @local_url@</property>

<h2>Clickthroughs from <a href="@local_url@">@local_url@</a></h2>

@context_bar@

<hr>

<ul>
  <multiple name="urls">
    <li>@urls.entry_date@ : 
	<a href="one-local-one-day?local_url=<%=[ns_urlencode @local_url@]%>&query_date=<%=[ns_urlencode @urls.entry_date@]%>">
	  @urls.n_clicks@</a>
  </multiple>
</ul>

