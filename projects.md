---
layout: page
permalink: /projects/
title: Projects
tags: [projects]
image:
  feature: constructocat2.jpg
---

----

<div class="md-col-3">
<span class="h1 post-title">"... Necessity is the mother of invention..."</span>
</div>

We've built something usable, but will it last ?  Never ones to rest on our laurels, are always working to develop new ideas and requests into usable services. We identify projects as semi-mature blocks of work which require consistent, knowledgeable development in order to take them from idea to service. They are larger bodies of work than <a href="{{site_url}}/campaigns">our campaigns</a> and represent to some extent research and development. Sometimes they are done in the context of University Master of Honours projects, while others are done in the context of international research projects.

We are always on the look out for collaborators, so if one of these projects hits you in the sweet spot, why not get in touch and collaborate. Almost all projects are published via [Zenodo](https://zenodo.org/collection/user-sa-einfra-commons) and collaborators are included as authors.

----


<span class="h1 post-title">"If only..."</span> Hey, we don't have a monopoly on good ideas, but we do want to build an infrastructure that can support them. If you have such a good idea and would like to implement it or even just try something out, why not propose a project - [please feel free]({{site_url}}/contact) !

<div role="tabpanel">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="#current" aria-controls="current" role="tab" data-toggle="tab">Current</a></li>
    <li role="presentation"><a href="#proposed" aria-controls="proposed" role="tab" data-toggle="tab">Proposed</a></li>
    <li role="presentation"><a href="#bluesky" aria-controls="bluesky" role="tab" data-toggle="tab">Blue-Sky</a><li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="current">
      <!-- current projects -->
      <span class="post-body">
        The projects we are currently working on include :
      </span>
      {% for project in site.data.projects %}
      {% if project.state == "current" %}
      <h2 class="blog-info">{{ project.name }}</h2>
      <span class="post-body">{{ project.description }}</span>
      {% if project.links != null %}
      <ul class="col-md-3 nav nav-pills nav-justified">
      {% for link in project.links %}
        <li><a href="{{ link.url}}"><i class="fa fa-{{ link.icon }}"></i><span class="post-info"> {{ link.name }}</span>{% if link.protected == true %} <i class="fa fa-lock"></i>{% endif %}</a></li>{% endfor %}
      </ul>
      {% endif %}
      {% endif %}
      {% endfor %}
    <!-- /current projects -->
  </div>

  <div role="tabpanel" class="tab-pane" id="proposed">
    <!-- proposed projects -->
    {% for project in site.data.projects %}
    {% if project.state == "proposed" %}
    <h2 class="blog-info">{{ project.name }}</h2>
    <span class="post-body">{{ project.description }}</span>
    {% if project.links != null %}
    <ul class="col-md-3 nav nav-pills nav-justified">
    {% for link in project.links %}
      <li><a href="{{ link.url}}"><i class="fa fa-{{ link.icon }}"></i> {{ link.name }}</a></li>
    {% endfor %}
    </ul>
    {% endif %}
    {% endif %}
    {% endfor %}
    <!-- /proposed projects -->
  </div>

<div role="tabpanel" class="tab-pane active" id="bluesky">
  <!-- current projects -->
  <span class="post-body">
    The projects we are currently working on include :
  </span>
  {% for project in site.data.projects %}
  {% if project.state == "bluesky" %}
  <h2 class="blog-info">{{ project.name }}</h2>
  <span class="post-body">{{ project.description }}</span>
  {% if project.links != null %}
  <ul class="col-md-3 nav nav-pills nav-justified">
  {% for link in project.links %}
    <li><a href="{{ link.url}}"><i class="fa fa-{{ link.icon }}"></i><span class="post-info"> {{ link.name }}</span>{% if link.protected == true %} <i class="fa fa-lock"></i>{% endif %}</a></li>{% endfor %}
  </ul>
  {% endif %}
  {% endif %}
  {% endfor %}
<!-- /current projects -->
</div>

  </div>
</div>
