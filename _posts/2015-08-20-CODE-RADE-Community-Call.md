---
layout: post
title:  'CODE-RADE Community Call'
description: 'Community call for the CODE-RADE project - Week 35 (2015)'
headline: "It's not called *continuous* integration for nothing."
category: blog
tags: [blog, CODE-RADE, sitrep]
image:
  feature:
  attribution:
comments: false
mathjax: false
discourse: false
---

# Community Calls

The project is gaining steam and we want to have a recurrent
Our first community call for CODE-RADE just happened in the [AAROC mconf space](http://mconf.sanren.ac.za/webconf)
If you want to comment or discuss this call, head over to [the discussion forum](http://discourse.sci-gaia.eu/t/code-rade-community-call-week-35)


# Roll-call

Present were @dmakweba Sean from TLABS, @smasoka and myself.  We'd like to start small, keep the door open and slowly grow the project...

It seemed that there were some problems with the mconf system - @smasoka and I managed a stable connection, but Sean got kicked out due to instability and @dmakweba couldn't hear very well.

# On the Agenda

## Website

The project needs a public website with better information, guides, dashboard, status, information, etc. This is being built under the new [CODE-RADE](https://github.com/AAROC/CODE-RADE) repo, in the <code>gh-pages</code> branch. Definitely still work in progress, but we can work on this. The current pages at [Applications]({{site_url}}/applications)and [CVMFS]({{ site_url }}/cvmfs) will stay, and will  be useful to end-users  but [CODE-RADE]({{site_url}}/CODE-RADE) will contain the documentation, links to publications etc.

## Project issues and planning

The scripts which build and check the applications are kept each in a separate repository - this means there are several repositories and if builds fail, issues need to be opened, tracked and eventually fixed. Since these issues are tied to a repo, it's easy to track which commit fixed them, but since there are many repos, it's hard to keep track of the overall status of the CODE-RADE project. We need a way to collect issues and present them in a holistic way in order to track the overall progress of  the project.  

There are also cross-cutting issues which may arise, which are only fixable by working on the Jenkins server, or some other central node of the platform.

In order to keep track of the issues, we can used things like [ontrack](http://nemerosa.github.io/ontrack/) or [Waffle.io](http://waffle.io). I particularly like Waffle.

## (Scholarly) Publishing the project

The time has come to work on scholarly output of the project - we need to submit articles to journals and conferences to get the narrative in the public domain, in a peer-reviewed way. We also need to think about keeping the slide decks and articles in a findable place.

### Conferences

We have a couple of upcoming opportunities to do this :

  1. OSSCOM in Amman, organised by ASREN - 10-13/09/2015
  1. [pyConZA](https://za.pycon.org/) in Johannesburg, with a Software Carpentry Bootcamp - 2-4/10/2015
  1. [The e-Research Africa conference](http://www.eresearch.ac.za) in Cape Town - 9-13/11/2015
  1. The Ubuntunet Connect Conference in Maputo - 17-20/11/2015
  1. The CHPC Conference in Pretoria 30/11/2015-04/12/2015

  We probably can't make OSSCOM, but we should submit presentations to E-Research Africa and the CHPC conference. @smasoka should be presenting at CHPC, whilst both I and @smasoka will present at e-Research Africa. I will present at Ubuntunet.


### Where to put our contributions

We should submit works to preprint servers which issue persistent identifiers and create a table on the project website with these links (could also be an iframe from Zenodo e.g.). We could also think about having an Africa-Grid Open Access Document and Data repository as part of DIRISA. This needs the Ansible playbook for Invenio to be finished. See [this topic on the forum](http://discourse.sci-gaia.eu/t/pre-beta-version-of-the-open-access-repository)

## This week's topics

### Update to end-user modulefiles

Modulefiles will be used to allow users submitting jobs or running applications locally on their laptops to easily set up shell environments. Modules should be configured according to the *site* in question - by *site*, we mean a particular configuration or state, *e.g.*

  * a generic laptop with no cluster, with a Debian OS (generic, gcc4)
  * a generic CEntOS site with standard middleware (gcc4-torque-openmpi)
  * a CEntOS site optimised for high performance (gcc5-slurm-openmpi)

These modules differ from those which we create during integration and then use to build applications against each other - they need to take the absolute minimum of parameters and need to be automatically set up by the end user. No variables to set, no special commands etc. A user or a script should simply be able to do something like

    #!/bin/bash
    source grid.sh # this is somewhere predefined on the site
    module add <site> # the tag that most represents your site - now you can add applications
    module add <app> # now you can run app on site with all the various configs
    <app> <parameters>


We might want to keep the modules in a repo, so that we can track issues with them - or the module could be added to the app repo by jenkins itself after jobs complete.

### Volunteer sites

We need some volunteer sites to actually mount the repos so that we can send jobs down there. :beers: to the first site who signs up. We have a handy Ansible playbook to help out.

### Jenkins development and future

Just two points :

  1. We've committed the Jenkins config to the repo on github, so it should be reproducible
  1. We are running out of space at UFS, so we need to start thinking about a beefier infrastructure.


# Next meeting

The next meeting will be

  :calendar:  31/08/2015 on mconf.
