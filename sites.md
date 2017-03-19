---
url: sites
layout: pageminimal
codrops: false
gridlayout: true
title: Production Grid Sites
headline: Find out more about the sites on the grid
image:
  feature: blurred_lines.jpeg
discourse: true
---
<ul class="cbp-ig-grid">
{% for kaka in site.data.sites   %}
	<li>
		<a href="{{ kaka.url }}">
		<img src="../images/{{ kaka.logo }}" class="img-responsive center-block img-square">
			<h3 class="cbp-ig-title">{{ kaka.name }}</h3>
			<span class="cbp-ig-category">{{ kaka.description }}</span>
		</a>
	</li>

	{% endfor %}
	</ul>
