---
layout: page
permalink: /user/
title: User info
codrops: false
gridlayout: true
image:
  feature: Marvin-Gaye-Featured-Image.jpg
---

<h1 class="text-center">Users-facing services</h1>

What will you do with the grid today ? 

<ul class="cbp-ig-grid">
{% for service in site.data.userservices %}
  <li>
    <a href="{{ site_url }}/{{ service.url }}">
      <span class="fa-stacked"><i class="fa fa-{{ service.icon }} fa-4x"></i></span>
      <h5 class="cbp-ig-title">{{ service.name }}</h5>
      <span class="cbp-ig-category">{{ service.title }}</span>
    </a>
  </li>
{% endfor %}
</ul>
