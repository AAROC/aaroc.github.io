---
layout: post
title:  'Reproducible ASR design'
description: 'Ideas on the design and architecture of the Reproducible ASR gatway'
category: blog
tags: [blog, Sci-GaIA, hackfest, projects, design]
comments: false
mathjax: false
discourse: true
---

# TL;DR : A deeper look at the design of the Reproducible  ASR gateway.

# Background

<!-- see the previous post on ASR -->
We discussed the motivation and scientific workflows of the Reproducble ASR system in a previous post. Now, we take a bit of a look into what kinds of services are desirable and necessary, as well as how we can design a coherent system.

# Architecture

This science gateway for Automatic Speech Recognition research will be used in a distributed environment and uses many pre-existing services in various service federations, either in the EGI context, the Africa-Arabia Regional Operations Centre, or indeed stand-alone sites. We need the architecture therefore to be modular enough to withstand porting the user interfaces to more than one place, and keep the integration overhead cost as low as possible by re-using as many existing services as possible.

Let's get into the architecture of components that would be desirable to make this work.

## Components

The components necessary to build the service consist of :

  * Web components
  * Identity components
  * Data components
  * Compute components

These components can take one or more forms, depending on the design and intent of the service, as well as which kind of environment it is going to be used in. Some of the components in each of the set will be internal to the gateway, and others will indeed be external. The internal compoents need to be developed by the Reproducible ASR project, whilst we will design the gateway to interact with the external components via REST APIs as far as possible.

### Web components

The most basic web component is the website - at least the publicly-accessible web pages. These act as the first contact with the public and potential users. As such they should be designed both with user experience in mind, but also as a dissemination channel of the service, and the results that it generates. The web components will be responsible for some of the interaction with the other components of the system, in particular the Future Gateway API server. For this reason, we need to develop a web application which can fulfill this task.

### Identity components

Maintaining a handle on the usage of the gateway is important for several reasons, including keeping track of who in particular is submitting the jobs for processing. This is to be able to provide authorship information of research products which are eventually generated. Since these research objects will be kept in open access repositories, we need to assign proper attribution to both the original authors, as well as those who have subsequently re-produced the research or cited previous analyses.

So, although we do not necessarily need to _secure_ the service on the website, we do need to provide provencance and therefore authentication is needed. Possible means for doing this are by using external identity providers, such as ORCID or identity federations.

### Data components

This is a data-intensive use case, and there are indeed several different _kinds_ of data. Let's bring some clarification :

  * **Language Corpora:** The first kind of data which we are dealing with are the various corpora for langauges. This data consists of audio expressions of the language in question, as well as text-based dictionaries. The corpora are usually  public Open Data with its own naming and discovery schema. While langauge corpora are constantly udated, and published for peer review, they are considered as _static_ data.
  * **Analysis Results:** The results of processing (models, etc) are published once they have been
  * **Staged Data:** Staged data refers to data which is readily available for processing at sites. This is also referred to as "online" data, which means that it is available on a fast local network to be use as input or output.
  * **Metadata:**

### Compute components


## Architecture Diagram

<figure>
<img src="{{ site_url }}/images/RASR%20Architecture%20Components.svg">
</figure>

## Integration

The basic architecture of the service


# Goal Posts

## Web interface

# Footnotes and references

[^discuss]: Be sure to discuss this on the related topic in [the forum](http://discourse.sci-gaia.eu)
