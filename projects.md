---
layout: page
permalink: /projects/
title: Projects
tags: [projects]
image:
  feature: Austria-Zero_Pic_work-in-progress.jpg
---

----

<div class="md-col-3">
<span class="h1 post-title">"... Necessity is the mother of invention..."</span>
</div>

We've built something usable, but will it last ?  Never ones to rest on our laurels, are always working to develop new ideas and requests into usable services. We identify projects as semi-mature blocks of work which require consistent, knowledgeable development in order to take them from idea to service. We are always on the look out for collaborators, so if one of these projects hits you in the sweet spot, why not get in touch and collaborate. Almost all projects are published via [Zenodo](https://zenodo.org/collection/user-sa-einfra-commons) and collaborators are included as authors.

----

<span class="h1 post-title">"If only..."</span>
If you would like to propose a project, please feel free !

----

# Current Projects

<!-- later we will include "completed projects" -->
{% for project in site.data.projects %}

<p class="h2 blog-title">{{ project.name }}</p>
<span class="blog-info">{{ project.description }}</span>

<ul class="col-md-3 nav nav-pills nav-justified">
{% for link in project.links %}
<li><a href="{{ link.url}}"><i class="fa fa-{{ link.icon }}"></i> {{ link.name }}</a></li>
{% endfor %}
</ul>

----

{% endfor %}
