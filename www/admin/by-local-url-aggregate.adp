<master src="/www/default-master">
<property name=title>Clickthroughs by local URL: summary report</property>

<h2>Clickthroughs by local URL: summary report</h2>

@context_bar@

<hr>

Note: this page may be slow to generate; it requires a tremendous amount of chugging by the RDBMS.

<ul>
  <multiple name="urls">
    <li><a href="one-url-pair?local_url=<%=[ns_urlencode @urls.local_url@]%>&foreign_url=<%=[ns_urlencode @urls.foreign_url@]%>">
	  @urls.local_url@ -&gt; @urls.foreign_url@ : @urls.n_clicks@</a>
  </multiple>
</ul>

