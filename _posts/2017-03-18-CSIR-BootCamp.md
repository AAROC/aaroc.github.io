---
layout: post
title: 'DevOps Bootcamp : CSIR '
updated: 2017-03-27 10:12:19 +0200
description: ''
headline: 'Time to build some more awesome'
category: blog
tags: [DevOps, Ansible, Automation, CI, CD]
image:
  feature: "AnsibleBootCampCSIR.jpg"
  attribution: "[James Pond](https://stocksnap.io/author/41685)"
comments: false
mathjax: false
discourse: true
---

## TL;DR

We're going to throw you in the DevOps deep end.

  * DevOps Bootcamp at the CSIR Meraka Institute, Pretoria - [Agenda and details](https://agenda.ct.infn.it/event/1271/)
  * Just click on "Apply to Participate"
  * Complete the [questionnaire](https://docs.google.com/forms/d/1BkMVXJkHji-fhu2UFJHtK0qbJfrW21Ctn4nf_eJS9tI/edit) before coming.

# Time to build some more awesome

At the Cyberinfrastructure Unit of  the CSIR, we're in the _infrastructure_ game. We build high-performance networking, compute and data infrastructure for research communities. However, that infrastructure is quite meaningless unless it is efficiently used, and this is done by exploiting the infrastructure through the services that it offers. Some of these services are built directly by our engineers, whilst others are built "out there" in the wild scientific world. But services should be easy to reproduce, scale, debug,  share.

The Africa-Arabia Regional Operations Centre (AAROC) operates a complex set of such services which run on infrastructure provided by several providers from across the continent. Orchestrating and maintaining a series of middleware stacks at several sites, which as a whole need to inter-operate with peer infrastructure abroad, is clearly a complex task. Ensuring that there is continuity in user experience (and indeed in some cases to user applications) is essential, as is reacting to changing environments, security threats and usage patterns. AAROC has adopted an "Executable Infrastructure" approach, focussing on the ability to express services and states _as code_, in order to better test, integrate and deliver them to sites.

## Basic skills for infrastructure competency

This philosophy emphasises agility, empathy, transparency, reproducibility and communication, and is part of the "DevOps" culture. During the course of the years, we have developed a format which aims to deliver _basic skills_ to infrastructure engineers, operations teams, and research software engineers - the _"bootcamp"_. This concept has been perfected by the [Software Carpentry](http://www.software-carpentry.org) movement, which aims similarly provide basic lab skills to modern scientists. In the case of Software Carpentry, the focus is on core tools for day-to-day research, such as using change control, or data analysis with Python or R. In the case of the DevOps bootcamp, we aim to do the same for e-Infrastructure. The goal is to build a common vocabulary, and wider understanding of how to best develop, deliver and deploy research platforms, and a better means for collaboration in doing so.

## Recent bootcamps

This will be the 4th DevOps Bootcamp, and the last one supported by the [Sci-GaIA project](http://www.sci-gaia.eu). During the course of the project - which will hold it's final conference in Pretoria[^FinalConf] to showcase the work done - we have held three bootcamps so far, in collaboration with :

  - [GARR](http://www.garr.it)[^GARR] - The [first bootcamp in Catania ](http://agenda.ct.infn.it/event/1180/other-view?view=indico_infn_meeting) aimed at delivering federated identity providers and services in a federation.
  - [eko-Konnect](http://www.eko-konnect.org)[^eko] - The [Lagos bootcamp](http://indico.wacren.net/event/25/) also focussed on orchestration of federated identity
  - [UbuntuNet](http://www.ubuntnet.net)[^UbuntuNet] - The [Entebbe bootcamp](https://events.ubuntunet.net/indico/event/5/) focussed more on core skills such as working with code, and then hacked participant projects related to eduroam deployment in the Great Lakes region.

Each bootcamp is a bit different, and participants get out of it what they put in. There is a short feedback period _before_ the event, where skill levels are assessed and interested parties are probed on what kind of projects they'll be bringing to the event. Over the course of two days, the basics are laid down and participants come away with a new set of skills and confidence in serving their scientific communities.

# What we'll cover

The scope of DevOps can be all-encompassing; just covering the toolsets exhaustively could take days. Instead of focussing on _all the tools_, we pick a few and then use it to demonstrate methodology. A short introduction, aimed at giving some context and peripheral vision to what we are doing is covered in the first session. We cover the practices of

  * Service modelling
  * Testing
  * Continuous Integration and Delivery
  * Code review
  * [Working Open](https://mozillascience.github.io/WOW-2017/) and aspects of [Community Health]()

and put them into action. The bootcamp alternates between short presentations and implementation sessions, where participants code[^OrIndividuals].

## Tools

> This is my rifle. <br>
> There are many like it, but this one is mine
  (From [The Rifleman's Creed](https://en.wikipedia.org/wiki/Rifleman's_Creed))

It is impossible to give a comprehensive insight to tools. There are several, each purporting to solve various problems faced in a DevOps environment. But DevOps is not a tool, it is a culture. We use [Ansible](http://www.ansible.com) as the basic tool for the bootcamp because of it's simplicity, human-readable nature, agentless architecture and vast set of built-in modules. However, we will also need others for testing[^Testing], communication, automation, _etc_.

The course also relies on [GitHub](https://github.com/) and assumes that participants have accounts on GitHub[^NoGithub]. The GitHub API will be used to manage repositories and access tokens, amongst other things, and the web interface is suggested for code reviews.

We will also be relying on [Linux Containers](https://en.wikipedia.org/wiki/LXC), and in particular [Docker](http://docker.com/) for a development environment and some testing. [Ansible Container](https://docs.ansible.com/ansible-container) will be used as part of the toolkit.

# Interested in attending ?

If all this sounds like fun, then come to the DevOps Bootcamp at the CSIR Meraka Institute **30 - 31 March 2017**. The sessions are open to all, space-permitting. ~~Further details (venue, registration, etc) will be posted soon. In the meantime, why not take a quick look at what you can do to get yourself ready.~~

**Update** :

  * Registration and agenda  : https://agenda.ct.infn.it/event/1271/
  * Apply to participate : Click on the "Apply to participate" link under **registration** on the agenda.
  * Preparation questionnaire : [Go to the questionnaire](https://docs.google.com/forms/d/1BkMVXJkHji-fhu2UFJHtK0qbJfrW21Ctn4nf_eJS9tI/edit)

## Preparation

> "Be prepared"
  ([Scouts Motto](https://en.wikipedia.org/wiki/Scout_Motto))

The bootcamp makes no assumptions about the skill of the participants, so there are zero formal requirements for attending the course.  Participants should however have a need to fulfill - a pet project, a service they are responsible for.

Familiarity with certain basic tools and skills will certainly be a bonus. The best place to work is on your own personal computer, so you should have  :

  * Linux[^Duh]
  * bash or other shell
  * git client (and optional IDE)
  * a good editor
  * [Docker Engine](https://store.docker.com/search?type=edition&offering=community)

... and a whole lot of grit.

<div class="text-center">
<iframe src="//giphy.com/embed/11zTEl7fbwml68" width="480" height="226.55999999999997" frameBorder="0" class="giphy-embed" allowFullScreen></iframe>
<p> </p>
<h2>See you all at the bootcamp !</h2>
</div>
<p> </p>

----

# References and Footnotes

[^FinalConf]: The Sci-GaIA User Forum and Final Conference - 23 and 24 March 2016. See [www.sci-gaia.eu/final-event](http://www.sci-gaia.eu/final-event). All welcome !
[^GARR]: GARR is the Italian NREN
[^eko]: eko-Konnect is the Lagos cluster of the Nigerian NREN (ngREN)
[^UbuntuNet]: The UbuntuNet Alliance is a regional REN for East and Southern Africa.
[^OrIndividuals]: This is usually done in pairs, but depends on the number of participants and projects.
[^Testing]: Tests can be written with [ServerSpec](http://serverspec.org/) or [Test Kitchen](http://kitchen.ci). For continuous integration, we will use mainly [Travis](https://travis-ci.org)
[^NoGithub]: If you have some kind of religious intolerance of GitHub, I guess we can find a way to accommodate that <code>¯\_(ツ)_/¯</code>
[^Duh]: Duh. I haven't checked this bootcamp with the Windows Subsystem for Linux yet - any takers ?
