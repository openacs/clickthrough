<master src="/www/default-master">
<property name=title>Clickthroughs from @local_url@ on @query_date@</property>

<h2>Clickthroughs from <a href="@local_url@">@local_url@</a> on @query_date@</h2>

@context_bar@

<hr>

<ul>
  <multiple name="urls">
    <li>to <a href="@urls.foreign_url@">@urls.foreign_url@</a> : @urls.click_count@
  </multiple>
</ul>

