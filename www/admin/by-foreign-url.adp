<master>
<property name=title>Clickthroughs by foreign URL</property>
<property name="context">@context;noquote@</property>

<ul>
  <multiple name="urls">
    <li><a href="one-url-pair?local_url=<%=[ns_urlencode @urls.local_url@]%>&foreign_url=<%=[ns_urlencode @urls.foreign_url@]%>">
	  @urls.foreign_url@ (from @urls.local_url@)</a></li>
  </multiple>
</ul>

