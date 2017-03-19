---
layout: page
permalink: /CertificateAuthorities/
title: Certificate Authories
description: All your identity are belong to us
codrops: false
<!-- gridlayout: true -->
image:
  feature: hex0.jpg
---

{% for row in (0..3) %}
{% assign offset = row | times: 3 %}
<div class="row">
{% for CA in site.data.cas limit:3 offset: offset %}
    <div class="col-sm-3">
    <div class="thumbnail">
      <img src="{{ site_url }}/images/{{ CA.flag }}" alt="...">
      <div class="caption">
        {{ CA.name }}
        <p><a href="{{ CA.url }}" class="btn btn-primary text-center" role="button">Go</a></p>
      </div> <!-- caption -->
    </div> <!-- thumbnail -->
  </div> <!-- col -->
  {% endfor %}
  </div> <!-- row -->
{% endfor %}
