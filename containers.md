---
layout: page
permalink: /containers/
title: Our Containers
headline: Packaged just right
tags: [middleware, containers, docker, DevOps]
image:
  feature: burn.jpg
---

<div class="col-md-8">

<h1>Why we do containers </h1>

<ol>
  <li>because they are awesome.</li>
  <li>because we can test them</li>
  <li>because you can easily use them</li>
  <li>because they are portable</li>
</ol>

Containers can't solve everything, but they go a long way to making life easier for those of us testing and developing service configurations.

<h2>AAROC on Docker Hub</h2>

We maintain our containers in automated build repositories on Docker hub (see the <a href="https://hub.docker.com/u/aaroc/dashboard/">AAROC Docker hub Dashboard</a>).
The docker repos are linked to Github repos.

</div>

<div class="col-md-4">

<h2 class="post-header">Containers we maintain.</h2>

<table class="table table-hover table-responsive">
  <thead>
    <td>Name</td>
    <td>Docker Hub</td>
    <td><i class="fa fa-github"></i></td>
    <td>Status</td>
  </thead>
{% for container in site.data.containers %}
    <tr>
      <td>{{ container.name }}</td>
      <td><a href="{{ container.registry.url}}">{{ container.registry.name }}</a></td>
      <td><a href="https://github.com/{{ container.repo }}">{{ container.repo }}</a></td>
      <td><img href="{{ container.travis.job }}" src="{{ container.travis.badge }}"></td>
    </tr>
{% endfor %}
</table>

Interested in contributing ? <a href="http://discourse.sci-gaia.eu/">Discuss with us</a>
</div>
