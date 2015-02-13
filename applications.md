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

<div role="tabpanel">
  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation"><a href="#compilers" aria-controls="compilers" role="tab" data-toggle="tab">Compilers</a></li>
    <li role="presentation"><a href="#libraries" aria-controls="libraries" role="tab" data-toggle="tab">Libraries</a></li>
    <li role="presentation"><a href="#frameworks" aria-controls="framweworks" role="tab" data-toggle="tab">Frameworks</a></li>
  </ul>
<div class="tab-content">

{% include compilers.html %}
{% include libraries.html %}
{% include frameworks.html %}


</div>
</div>

## How about something Continental ?

Want something from another VO ? Our sites support several [EGI](https://wiki.egi.eu/wiki/CVMFS_Task_Force#Configurations) and [WLCG](https://wiki.egi.eu/wiki/CVMFS_Task_Force#Configurations) VOs (ATLAS and ALICE primarily.)
