<master src="/www/default-master">
<property name=title>Clickthroughs for @package_name@</property>

<h2>Clickthroughs for @package_name@</h2>

@context_bar@

<hr>

<ul>
  <li><a href="by-foreign-url">by foreign URL</a>
  <li><a href="by-local-url">by local URL</a>
</ul>

<h4>Summary Reports (expensive queries, may take a long time)</h4>

<ul>
  <li>by foreign URL:
      <a href="by-foreign-url-aggregate">all</a> | 
      <a href="by-foreign-url-aggregate?minimum=10">limit to those with 10 or more</a>
  <li><a href="by-local-url-aggregate">by local URL</a>
</ul>
