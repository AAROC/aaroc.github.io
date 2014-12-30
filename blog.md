---
layout: page
permalink: /blog/
title: What's going on ?
tags: [blog]
image:
  feature: Marvin-Gaye-Featured-Image.jpg
---

# Listen up, we've got something to say

This is our pedestal, these are our thoughts.

{% for post in site.categories.blog %}
## [{{ post.title }}]({{ post.url }}).

Written on {{ post.date | date_to_string }}, tagged with
{% for tag in post.tags %}  *{{ tag }}* {% endfor %}
{% endfor %}
