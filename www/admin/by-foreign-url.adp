<master src="/www/default-master">
<property name=title>Clickthroughs by foreign URL</property>

<h2>Clickthroughs by foreign URL</h2>

@context_bar@

<hr>

<ul>
  <multiple name="urls">
    <li><a href="one-url-pair?local_url=<%=[ns_urlencode @urls.local_url@]%>&foreign_url=<%=[ns_urlencode @urls.foreign_url@]%>">
	  @urls.foreign_url@ (from @urls.local_url@)</a>
  </multiple>
</ul>

