<master src="/www/default-master">
<property name=title>Clickthroughs to @foreign_url@</property>

<h2>Clickthroughs to <a href="@foreign_url@">@foreign_url@</a></h2>

@context_bar@

<hr>

<ul>
  <multiple name="urls">
    <li>@urls.entry_date@ : 
	<a href="one-foreign-one-day?foreign_url=<%=[ns_urlencode @foreign_url@]%>&query_date=<%=[ns_urlencode @urls.entry_date@]%>">
	  @urls.n_clicks@</a>
  </multiple>
</ul>
