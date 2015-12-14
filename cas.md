---
layout: page
permalink: /CertificateAuthorities/
title: Certificate Authories
description: All your identity are belong to us
codrops: false
gridlayout: true
image:
  feature: hex0.jpg
---

<h1 class="text-center post-title">Certificate Authorties</h1>
{% for row in (0..2) %}
<div class="row">
{% for CA in site.data.cas limit: 3 offset: row|times 3 %}
    <div class="col-sm-6 col-md-4">
    <div class="thumbnail">
      <img src="{{ site_url }}/images/Flag_of_{{ CA.name }}.svg" alt="...">
      <div class="caption">
        <h3>{{ CA.name }} CA</h3>
        <p><a href="{{ CA.url }}" class="btn btn-primary text-center" role="button">Go</a></p>
      </div> <!-- caption -->
    </div> <!-- thumbnail -->
  </div> <!-- col -->
  </row>
{% endfor %}
{% endfor %}
