---
layout: page
permalink: /security/index.html
title: We have got your back.
headline: Security view, tools and updates from the CSIRT to you.
tags: [security, page]
image:
  feature: security.jpg
  attribution: '"Security" by https://www.flickr.com/photos/cezaryborysiuk/ https://www.flickr.com/photos/cezaryborysiuk/4510261399/'
---

<h1 class="text-center">It's dangerous out there</h1>
<div class="row">
<div class="col-md-6">
<h2 class="post-info">
InfoSec : Everyone's business</h2>
<p class="text-justify">
We work in a distributed environment that is highly interconnected and largely automted. Maintining information security across the services is the responsibility of not just the core system administrators, but all the communities which use the infrastructure. While we rely on <a href="https://www.egi.eu/about/policy/groups/EGI_Computer_Security_Incident_Response_Team_EGI_CSIRT.html">the EGI CSIRT</a> to provide analysis and alerts of security threats, as well as a level of security monitoring, however <em> prevention is better than cure</em>.
</p>
<h2 class="post-info">
Operational Security Services</h2>
<p class="text-justify alert alert-warning">Some links may require a personal certificate in your browser and priveliged roles</p>
<ul class="list-group">
<li class="list-group-item"><a href="https://wiki.egi.eu/wiki/EGI_CSIRT:TDG-NEW">Security Disssmination and Training </a></li>
<li class="list-group-item"><a href="https://wiki.egi.eu/wiki/EGI_CSIRT:SDG">Security Drills Group</a></li>
<li class="list-group-item"><a href="https://wiki.egi.eu/wiki/EGI_CSIRT:SMG">Security Monitoring Group</a></li>
<li class="list-group-item"><a href="https://wiki.egi.eu/wiki/EGI_CSIRT:IRTF">Incident Response Task Force</a></li>
</ul>
<p class="text-center text-warning">Suspect shenanigans ? Don't be hasty <a class="text-danger" href="https://wiki.egi.eu/wiki/EGI_CSIRT:Incident_reporting">Report an Incident</a> and follow procedure.
</p>
</div>
<div class="col-md-6">
<h2 class="post-info">Recent security-related announcements and posts</h2>
{% for post in site.categories.security | limit: 3 %}
<h3 class="post-header"><a href="{{ post.url }}">{{ post.title }}</a></h3>
Written on {{ post.date | date_to_string }}, tagged with
{% for tag in post.tags %}  <em>{{ tag }}</em>
{% endfor %}
{% endfor %}
<i class="fa fa-ellipsis-h"></i><a href="{{ site_url }}/categories/#security"> More</a>
</div>
</div>

# Lighten up

Hey, bad days happen to everyone, especially when information security is involved. If you get hacked or cracked or are just having a regular bad day, why not take a glance at <a href="http://securityreactions.tumblr.com/">Security Reactions</a> and take solace in the fact that at least you're not alone.
