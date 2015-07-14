---
url: /services/
layout: pageminimal
codrops: false
gridlayout: true
title: "services"
image:
  feature: services.jpg
---
<ul class="cbp-ig-grid">
{% for service in site.data.services   %}
	<li>
		<a href="{{ site_url }}/{{ service.url }}">
			<span class="fa-stacked"><i class="fa fa-{{ service.icon }} fa-4x"></i></span>
			<h4 class="cbp-ig-title">{{ service.name }}</h4>
			<span class="cbp-ig-category">{{ service.title }}</span>
		</a>
	</li>

	{% endfor %}
	</ul>
