---
layout: page
permalink: /sitrep
title: So, how are we doing today ?
info: "Attention on deck"
tags: [sitrep]
image:
  feature:
---
<!-- suggestion - captain kirk yelling on the deck of the enterprise -->

<!-- we really need a nice dashboard here -->
<div class="panel">
<div class="panel-heading">
<h2 class="post-info">ROC Services</h2>
</div>
<div class="panel-content">
<ul class="list-group">
{% for service in site.data.services %}
{% if service.roc_service == true %}
<li class="list-group-item"><span class="badge alert-unknown">Beats me...</span>
<a href="{{ service.url }}" class="nav-pills">{{ service.name }}</a><p class="post-info small">{{ service.title }}</p>
  </li>
{% endif %}
{% endfor %}
</ul>
</div>
</div>

<div class="panel">
<div class="panel-heading">
<h2 class="post-info">Grid Services</h2>
</div>
<div class="panel-content">
<ul class="list-group">
{% for service in site.data.services %}
{% if service.grid_service == true %}
<li class="list-group-item"><span class="badge alert-unknown">Who knows...</span>
<a href="{{ service.url }}" class="nav-pills">{{ service.name }}</a><p class="post-info small">{{ service.title }}</p></li>
{% endif %}
{% endfor %}
</ul>
</div>
</div>

<div class="panel">
<div class="panel-heading">
<h2 class="post-info">Dev Cluster</h2>
</div>
<div class="panel-content">
<!--
<iframe src="https://premium.boundary.com/embed/e.f1625487ea?d-w=2&d-h=1&d-pad=15&d-rrange=60&d-header=0&d-slider=0&d-legend=1&d-light=1&d-bg=000000&d-sg-cpu=0-0-1-1&d-sg-mem=1-0-1-1#null" ></iframe> -->
</div>
</div>
