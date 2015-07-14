---
layout: post
type: post
title: Iterating CVMFS
description: 'An update on our quest to deliver applications'
headline: 'Step 1: RTFM; Step 2: Repeat; Step3: Do it right this time...'
modified:
category: blog
tags: [cvmfs, CODE-RADE, CVMFS]
image:
  feature: patience-yoda.jpg
  attribution: 'http://quotesfans.com'
comments: true
mathjax:
discourse: true
---

# TL;DR

A quick update on the work we're doing in the [CODE-RADE](https://github.com/AAROC/CODE-RADE-project) to bring a continuous delivery capability to the applications which can run on our infrastructure. A workflow to test the delivery of applicaitons in CVMFS needs to be implemented *and it better be automated*.

# The problem at hand

So, we've gone to quite a significant length to develop a platform which allows almost anyone to contribute applications to the ROC's repository. By sending a pull request or a commit directly to a repo in [https://github.com/SouthAfricaDigitalScience] -- but what happens when an application is built ?

Applications are "delivered" to the sites via [CVMFS](http://cernvm.cern.ch/portal/cvmfs)[^maybedocker].

We need it to be checked against itself, but also run from the CVMFS repo to make sure that when it gets out into the "wild" - on the sites that mount the repo and execute the applications. One of the reasons we chose CVMFS as a delivery mechanism was to give the site administrators less overhead in managing applications.

# Basic Workflow

<figure id="Figure 1">
<img src="{{ site_url }}/images/code-rade-workflow-1.png" />
<figcaption>Figure 1: What happens once we've built the application ?</figcaption>
</figure>

The part of the workflow representing testing and integration shown in [Figure 1](#Figure 1) is the meat of the problem - how do you reliably test user-contributed applications before integrating them into a repository which will be used at all sites ? - but the issue still remains of *actually getting the software into the repo*.  Let's take a closer look at that...

## Slightly more detailed workflow.

So, once we have concluded the workflow in [Figure 1](#Figure 1), some orchestration has to happen :

  1. On the build node:
      1. shift new artifacts into the CVMFS server
      1. unmount the dev repo
  1. On the CVMFS server:
      1. Put cvmfs dev repo into transaction
      1. Run regression tests on the new code - this includes all of the functional tests of all of the existing applications, _as well as_ the new application.
      1. If all pass, publish the new dev repo
  1. On the build node:
      1. mount the dev repo
      1. run regression tests
  1. Send a message that the new application has passed all tests

***It is  now time for a human to take over and pull the code into the production repo which is mounted on all the sites.***

Unless I'm missing something obvious, this is the slightly more detailed workflow.... before you get all excited about publishing containers and all, Yoda has a message for you:

<img class="img-rounded img-responsive  center-block" src="{{ site_url}}/images/patience-yoda.jpg">

That will come, that will come. In the meantime, go listen to some rad music:

<br>

<iframe src="https://embed.spotify.com/?uri=spotify:album:5B4PYA7wNN4WdEXdIJu58a" align="middle" width="300" height="380" frameborder="0" allowtransparency="true">Pearl Jam</iframe>

<br>

... till next time ... :wave: :octocat: <img src="{{ site_url }}/images/jenkinslogo.svg" height="25px" />

# Footnotes and References

[^maybedocker]: The choice of CVMFS was made as it is the only high-performance read-only delivery mechanism out there, currently used heavily and well-tested  by the WLCG VO's. It's not the only choice and we want to make delivery possible via Docker as well. More on that later.
