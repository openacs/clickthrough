<master>
<property name=title>Clickthroughs to @foreign_url@ on @query_date@</property>
<property name="context">@context@</property>

<h2>Clickthroughs to <a href="@foreign_url@">@foreign_url@</a> on @query_date@</h2>

<ul>
  <multiple name="urls">
    <li> from <a href="@urls.local_url@">@urls.local_url@</a> : @urls.click_count@
  </multiple>
</ul>

