<master>
<property name=title>@local_url@ -&gt; @foreign_url@</property>
<property name="context">@context@</property>

<h2>
  <a href="@local_url@">@local_url@</a> 
  -&gt; 
  <a href="@foreign_url@">@foreign_url@</a>
</h2>

<ul>
  <multiple name="urls">
    <li>@urls.entry_date@ : @urls.click_count@</li>
  </multiple>
</ul>


<h4>Still not satisfied?</h4>

Get a report of:

<ul>
  <li><a href="all-to-foreign?foreign_url=<%=[ns_urlencode @foreign_url@]%>">all clickthroughs to @foreign_url@</a>
      (lumping together all the referring pages)</li>
  <li><a href="all-from-local?local_url=<%=[ns_urlencode @local_url@]%>">all clickthroughs from @local_url@</a>
      (lumping together all the foreign URLs)</li>
</ul>

