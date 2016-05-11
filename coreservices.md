---
permalink: /coreservices/
layout: page
codrops: false
gridlayout: true
title: "Core Services"
image:
  feature: coreservices.jpg
---
<h1 class="text-center">Keeping it all humming along</h1>
  
<ul class="cbp-ig-grid">
{% for service in site.data.services  %}
  <li>
    <a href="{{ site_url }}/{{ service.url }}">
      <span class="fa-stacked"><i class="fa fa-{{ service.icon }} fa-4x"></i></span>
      <h5 class="cbp-ig-title">{{ service.name }}</h5>
      <span class="cbp-ig-category">{{ service.title }}</span>
    </a>
  </li>
{% endfor %}
</ul>
