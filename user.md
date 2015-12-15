---
layout: page
permalink: /user/
title: User info
codrops: false
gridlayout: true
image:
  feature: Marvin-Gaye-Featured-Image.jpg
---

----

<!-- introduction row -->
<div role="tabpanel">
  <!-- Nav tabs -->
  <ul class="nav nav-tabs nav-justified" role="tablist">
    <li role="presentation"><a href="#prospective" aria-controls="prospective" role="tab" data-toggle="tab"><i class="fa fa-question"></i> Prospective Users</a></li>
    <li role="presentation"><a href="#new" aria-controls="new" role="tab" data-toggle="tab"><i class="fa fa-user-plus"></i> New Users</a></li>
    <li role="presentation"><a href="#howto" aria-controls="howto" role="tab" data-toggle="tab"><i class="fa fa-info"></i> How To ... </a></li>
    <li role="presentation"><a href="#services" aria-controls="services" role="tab" data-toggle="tab"><i class="fa fa-user fa-spin"></i> Services</a></li>
  </ul>
<div class="tab-content">

<div role="tabpanel" class="tab-pane fade in active" id="prospective">
<br><p class="post-info text-justify">
If you're thinking about using the platform you've come to the right place. Here are some of the benefits of joining the Africa-Arabia e-Science communities.</p>
<h2> Transparent access to computing resources </h2>
Most modern research relies on computing.
<h2> Secure collaboration </h2>
</div>

<div role="tabpanel" class="tab-pane fade in active" id="new">
Info for new users
</div>

<div role="tabpanel" class="tab-pane fade in active" id="howto">
how to do stuff
</div>

<div role="tabpanel" class="tab-pane fade in active" id="services">
<h1 class="text-center">Users-facing services</h1>

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
</div>
