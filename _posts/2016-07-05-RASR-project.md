---
layout: post
title: "A plan for the Summer Hackfest"
description: "Some initial thoughts on a speech recognition science gateways"
headline: "A quick sketch of an environment for reproducible ASR processing"
category: blog
tags: [blog, Sci-GaIA, hackfest, projects, rasr]
comments: false
mathjax: false
image:
  feature: Jr0F2ay.jpg
discourse: true
codrops: false
---

# TL;DR : A quick sketch of an environment for reproducible ASR processing

We are about to get started on work to develop a virtual research environment for human language researchers, in the context of the [Sci-GaIA hackfest](http://www.sci-gaia.eu/summer-hackfest). The main focus is on reproducibility and re-analysis of published results. We have thus chosen the most awesome name for the project :

> RASR - Reproducing Automatic Speech Recognition

# Background

This work comes out of a collaboration with [David Risinamhodzi](https://github.com/DavidR2016) at the [University of the North West](https://www.nwu.ac.za). That project was in essence a performance study, to investigate the real-world performance of running human language workflows on the distributed infrastructure in South Africa. Whilst quite limited in scope, the results showed great promise and we took the opportunity of the Hackfest to work on a web interface so that other speech researchers could use it and provide feedback. There has been close discussion with the [National Centre for Human Language Technologies (NCHLT)](http://rma.nwu.ac.za/index.php) regarding usage, workflows and proper procedure. The main applications that are being used in the project are the [HTK toolkit](http://htk.eng.cam.ac.uk/)[^htk] and a [library for Support-Vector Machine](https://www.csie.ntu.edu.tw/~cjlin/libsvm/)[^libsvm] - both of which are in [CODE-RADE](http://www.africa-grid.org/CODE-RADE)

# Design considerations.

The design of a web application is not something we do every day here in the ROC, but due to recent developments such as the [Indigo DataCloud project](https://www.indigo-datacloud.eu/), and in particular the development of the REST APIs  of the [FutureGateway](https://github.com/FutureGateway/), we thought it was the perfect time to experiment with developing an interface to cross-platform distributed computing services. Indeed there is a major shift in general to writing "small" interfaces which use the REST APIs of external services in order to accomplish complicated workflows.

## Web development framework

Starting from scratch gives us the perfect opportunity to critically evaluate prior choices and explore new avenues. Whereas in the past the GridEngine component (which provides the interaction between the web-services and the computing platforsm) was integrated into the Liferay portal framework, this is no longer the case. The benefit was that we had freedom of choice in the selection of the web application framework, at the expense of existing scaffolding. With this freedom, the first choice we needed to make was which web development framework to use. This is in a sense an arbitrary choice, since the only functionality we really needed was a good REST API library. However, other factors such as maturity and scale of the community, richness of the development environment, supporting documentation, and ease of integration with external authentication providers came into play. The choice was initially whittled down to a toss-up between the

  * :gem: ruby-based **[Ruby on Rails](http://rubyonrails.org/)** :gem:
  * :snake: python-based **[Django](https://www.djangoproject.com/)**

toolkits[^JavaScriptduJour]. Both[^OkMTV] are based on the  [Model-View-Controller](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) architecture and have good front-end and back-end libraries.

An alternative would have been to use something very lightweight such as [Flask](http://flask.pocoo.org/), [sinatra](http://www.sinatrarb.com/intro.html), or similar[^MicroComparison]. However, the main criterion was the abililty to easily generate the web pages for the public-facing parts of the application. Since we had good experience with [Jekyll](http://jekyllrb.com/), which is Ruby-based, we decided to use Ruby as the language of choice. The choice to use Rails instead of Sinatra was based on the need to have a mature authentication framework. This is available in the form of [OmniAuth](https://github.com/intridea/omniauth/wiki) which would give us a great deal of flexibility over how to authenticate users.

**So, our front-end stack would consist of :**

  * Ruby on Rails with :
    * Devise with OmniAuth for authentication
    * [HTTParty](https://github.com/jnunemaker/httparty) for REST calls

This is  only the front-end though. The application would use REST APIs from several other services in order to work. Let's take a deeper look into the overall architecture.

## Architecture

The architecture refers both to which _components_ we are using, as well as _how they are integrated_.

## Components

The components necessary to build the service consist of generic :

* Web components
* Identity components
* Data components
* Compute components

These components can take one or more forms, depending on the design and intent of the service, as well as which kind of environment it is going to be used in.

<figure>
<img src="{{ site_url }}/images/RASR Architecture Components.svg">
<figcaption>
Overview of RASR architecture components
</figcaption>
</figure>

We will go into deeper detail of each of these components in later posts.

## Integration

With the basic architecture of the service components sketched out, the integration can focus on the flow of information and data through the various services. This is in essence the core of the RASR project, since most of the components are already-existing external services, and we are developing a mashup of existing services. The integration of the services depends in some sense on the desired workflows of the researchers which will be using the service.

## Typical ASR workflows

The first issue to flesh out in designing the web
From discussion with [David](https://github.com/DavidR2016), typica workflows would look something like this :

  1. Researcher identifies themselves. We are inclined to enable [ORCID auth](https://orcid.org/blog/2014/04/29/beta-participants-wanted-public-authenticated-ids?lang=ru), which would uniquely identify the researcher, but other methods are possible
  2. Researcher selects a language that they would like to study. They select a **corpus**. Language corpora are previously-published on open-access repositories.
  2. Researcher can
      3. browse previously-run experiments made on that copora, and re-run with a modified recipe **or**
      4. configure a new experiment and provide a recipe
  5. Each submission creates a new research object in a catalogue which consists of a combination of :
    * Corpus
    * Recipe
    * Provenance (author and originating dataset)
  6. Analyses can be _published_ via the application to an open access repository if they pass certain quality criteria. Note that it is important to publish both _positive_ and _negative_ results, _i.e._ experiments which give a good as well as bad result when running speech recognition.

The experiment itself consists of applying a _recipe_ of various tasks to input data :

  * Feature extraction
  * Applying a training model on specified ranges of and sets of training data
  * Evaluating the model

## Reproducibility and Re-Use

The end goal is to be able to ascertain whether a particular model and recipe is capable of giving reproducible results across corpora, etc.


# Goal Posts

Here is a first stab at what we aim to achieve in the hackfest... call these our movable goalposts ! It's not clear how much we'll be able to get done in 2 weeks, but it's important to have a realistic roadmap that maps to functionality that is actually desirable by the end-user community. The main roadmap is a set of issues in a Github repo :

[https://github.com/SouthAfricaDigitalScience/Project-RASR/milestones](https://github.com/SouthAfricaDigitalScience/Project-RASR/milestones). The main goal of the hackfest is thus 3  :

  1. Basic website up
  2. ASR template ported into CODE-RADE
  3. Architecture Finished

These milestones have been achieved so far and we are continuing to work on [the further issues](https://github.com/SouthAfricaDigitalScience/Project-RASR/issues).  The main design issues and broad questions have been tagged with the [Epic](https://github.com/SouthAfricaDigitalScience/Project-RASR/issues?q=is%3Aopen+is%3Aissue+label%3AEpic) tag on Github and we are mowing through these as implementation-specific issues arise. There is more to come in a further post where we go into deeper detail of the specific components and integration issues. But for now, we have an architecture design, a badass project name ... and an idea for a logo :

<figure>
<img src="{{ site_url }}/images/rasr_logo.png">
</figure>

# Acknowledgements

We had very fruitful discussions with all of the facilitators of the hackfest, but owe particular thanks to Marco Fargetta, Riccardo Bruno, Antonio Calanducci and Giuseppe Larocca for their valuable input.

This work was supported by the [Sci-GaIA project](http://www.sci-gaia.eu) under Grant 654237 of the European Commission's Horizon2020 programme.

# Footnotes and references

[^htk]: Young, Steve, et al. ***"The HTK book."*** **Cambridge university engineering department** 3 (2002): 175. Available online at [http://htk.eng.cam.ac.uk/docs/docs.shtml](http://htk.eng.cam.ac.uk/docs/docs.shtml)
[^libsvm]: Chih-Chung Chang and Chih-Jen Lin, ***LIBSVM : a library for support vector machines***. **ACM Transactions on Intelligent Systems and Technology, 2:27:1--27:27, 2011**. Software available at [http://www.csie.ntu.edu.tw/~cjlin/libsvm](http://www.csie.ntu.edu.tw/~cjlin/libsvm)
[^OkMTV]: Ok, apparently [Django prefers to call it MTV](https://docs.djangoproject.com/en/1.9/faq/general/#django-appears-to-be-a-mvc-framework-but-you-call-the-controller-the-view-and-the-view-the-template-how-come-you-don-t-use-the-standard-names), but you get the drift.
[^JavaScriptduJour]: Some JavaScript _du jour_ library such as EmberJS or AngularJS could have been used as well, but :

  1. Ugh.
  2. Bleah, can't read that stuff

[^MicroComparison]: See [this article](https://realpython.com/blog/python/python-ruby-and-golang-a-web-Service-application-comparison/) for a recent comparison of Ruby, Python and Go-based microframeworks.

[^discuss]: Be sure to discuss this on the related topic in [the forum](http://discourse.sci-gaia.eu)
