<master src="master">
<property name=title>Clickthroughs by local URL</property>
<property name="context">@context@</property>

<ul>
  <multiple name="urls">
    <li><a href="one-url-pair?local_url=<%=[ns_urlencode @urls.local_url@]%>&foreign_url=<%=[ns_urlencode @urls.foreign_url@]%>">
	  @urls.local_url@ -&gt; @urls.foreign_url@</a>
  </multiple>
</ul>

