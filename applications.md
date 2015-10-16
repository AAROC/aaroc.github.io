---
layout: page
permalink: /applications/
title: Supported Applications
headline: What you can run on the grid
tags: [glite, tutorial, basic, job submission, information system, authorisation, data management]
image:
  feature:
---

# What can I run ?

In order to execute applications, they need to be on the remote execution environment. One of the most popular ways of delivering applications is via [CVMFS](https://cernvm.cern.ch/filesystem).

## Straight from our Jenkins to you

Our build system performs continuous integration on applications which are supported by the infrastructure, as well as user-proposed applications. Below you can find the overview of the status of these. These are executable in local-only or under the [sagrid.ac.za](https://voms.sagrid.ac.za/voms/sagrid.ac.za).

<h2 class="post-info"><i class="fa fa-chevron-circle-right"></i> You can access these applications directly from your laptop, or cluster <a href="{{ site_url }}/cvmfs"> Find out how <i class="fa fa-chevron-circle-left"></i></a> </h2>

<div role="tabpanel">
  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation"><a href="#compilers" aria-controls="compilers" role="tab" data-toggle="tab">Compilers</a></li>
    <li role="presentation"><a href="#libraries" aria-controls="libraries" role="tab" data-toggle="tab">Libraries</a></li>
    <li role="presentation"><a href="#frameworks" aria-controls="framweworks" role="tab" data-toggle="tab">Frameworks</a></li>
    <li role="presentation"><a href="#python" aria-controls="framweworks" role="tab" data-toggle="tab">Python</a></li>
    <li role="presentation"><a href="#chemistry" aria-controls="chemistry" role="tab" data-toggle="tab">Chemistry</a></li>
    <li role="presentation"><a href="#requested" aria-controls="requested" role="tab" data-toggle="tab">Requested</a></li>

  </ul>

<div class="tab-content">



{% include compilers.html %}
{% include libraries.html %}
{% include frameworks.html %}
{% include python.html %}
{% include chemistry.html %}
{% include requested.html %}
<br>
<table class="table table-condensed">
<caption class="text-center">Legend</caption>
<tr>
  <td><i class="social-icons fa fa-check-circle-o" style="color: green"></i></td>
  <td>Published in CVMFS `apprepo` and modulefile available. Used at production sites and your milage wil be good :smile: </td>
</tr>
<tr>
  <td><i class="social-icons fa fa-flask" style="color:orange"></i></td>
  <td>Published in CVMFS `devrepo` - modulefile not guaranteed to be available, used for integration testing and early adopters. YMMV :smirk:</td>
</tr>
<tr>
  <td><i class="social-icons fa fa-times-circle-o" style="color:red"></i></td>
  <td>Not published anywhere yet.</td>
</tr>
</table>

<h2 class="post-title">Want to help or follow the development ? Check out our <a href="https://waffle.io/AAROC/CODE-RADE">waffle ironing board</a></h2>
<h2 class="post-title">Don't see what you want ? - <a href="https://github.com/AAROC/CODE-RADE/issues/new?labels=proposed">Propose a new application</a></h2>
</div>
</div>

## How about something Continental ?

Want something from another VO ? Our sites support several [EGI](https://wiki.egi.eu/wiki/CVMFS_Task_Force#Configurations) and [WLCG](https://wiki.egi.eu/wiki/CVMFS_Task_Force#Configurations) VOs (ATLAS and ALICE primarily.)
