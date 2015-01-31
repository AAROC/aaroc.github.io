---
layout: page
permalink: /acronyms/
title: Say What ?!
tags: [acronyms]
image:
  feature:
---
# A guide to the technobabble

Here are some descriptions of the acronyms and technical terms used. If you have a suggestion for one, or find one missing, please [open a ticket](https://github.com/AAROC/aaroc.github.io/issues/new?title=%22acronym%20request%22&labels=acronym&body=%22Hi,%20I%20suggest%20the%20following%20acronym%20for%20your%20website%22) to suggest one for us.



{% assign acronyms = site.data.acronyms | sort: 'name' %}
{% for acronym in acronyms %}
  <div class="row">
  <div class="md-col-3"><h2 class="post-info"><a href="{{ acronym.url }}">{{ acronym.name }}</a>:</h2></div><div class="md-col-3">{{ acronym.description }}</div>
  </div>
{% endfor %}
