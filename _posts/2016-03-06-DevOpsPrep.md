---
layout: post
title:  'Prep for DevOps Bootcamp'
description: 'Getting ready for the DevOps for Federation course'
category: blog
tags: [blog, Sci-GaIA, DevOps, eko-Konnect]
image:
  feature: 220110409213151001_4957481_ver1.0_640_480.JPG
  attribution: ""
comments: false
mathjax: false
discourse: true
---

# It's DevOps time again !

We're very proud to announce that we are teaming up with [Eko-Konnect](http://www.eko-konnect.org.ng/) and [WACREN](http://wacren.net/) to bring the [DevOps for Federation](http://www.eko-konnect.org.ng/content/devops-federated-services-8-10-march-2016) workshop to Lagos, from 8-10 March 2016. This will be an iteration on the first course run in collaboration with [GARR](www.garr.it) last year and will consist of three days of training in DevOps tools and culture, and their application to the deployment of federated identity and service providers.

# Preparation

For those who will be attending the course[^ForkMyCourse], there is a bit of suggested preparation, in order to come to the event with guns blazing. The event will consist of almost equal parts lectures and hands-on work, and you will be writing your own code which will be used to orchestrate services on a test infrastructure which will be provided. You need not bring anything in particular, but you will need a personal computer to work on.

In order to prepare for the course and ensure that things go smoothly for you, there are a few simple actions which we ask you to take, or to confirm.

  1.  You will be writing and typing a lot, and most of it will be code. If you are not comfortable with ssh, your favorite shell (we'll be using bash), your favourite editor (I recommend [Atom](http://atom.io)), basic git and git workflows, I suggest that you take the time to brush up on these skills. A good place to start is the [Software Carpentry Lessons](http://software-carpentry.org/lessons/) , and for the more curious out there, see
     1. [The Altassian git collaboration tutorial](https://www.atlassian.com/git/tutorials/syncing)
     1. [The Github Flow help article](https://guides.github.com/introduction/flow/)
  1. <i class="fa fa-github"></i> Ensure that you have a working [Github](http://github.com) account. If not [signup](https://github.com/join). This will be used to create and fork the repositories of the code needed in the course and also give you a place to keep your work for after the course.
     1. <i class="fa fa-key"></i> Github is really useful to share public keys. If you don't already have an ssh keypair, generate one and add it to your github profile : [github.com/settings/ssh](https://github.com/settings/ssh). See [Github SSH Help](https://help.github.com/categories/ssh/) for more info.
     1. <i class="fa fa-code-fork"></i> If you really want to get going, why don't you fork the DevOps Repo of the [Africa-Arabia Regional Operations Centre](https://github.com/AAROC/DevOps) ? This contains much of the actual code which we use to orchestrate services and we will be referring to it during the course.
  3. <i class="fa fa-user"></i> Ensure that you have an account on at least one federated identity provider. You can see a list at [eduid.wacren.net/](https://eduid.wacren.net/registry/p/page/idp-list) This will be needed to use the discussion forum where we discuss the course and provide support, as well as other federated services
  4. <i class="fa fa-ship"></i> We will be focussing on two main technology stacks during the course : [Ansible](http://www.ansible.com) and [Docker](http://www.docker.com). Ensure that you have these websites bookmarked, especially their documentation sections below. If you're felling bold, go ahead and install them on your laptop ! We will be covering how to do this during the course, but if  you do it before hand, you'll have more time to concentrate on the course and help your fellow participants.
      * <i class="fa fa-book"></i> Ansible : [docs.ansible.com/](http://docs.ansible.com/)
      * <i class="fa fa-book"></i> Docker : [docs.docker.com/engine/quickstart/](https://docs.docker.com/engine/quickstart/)
  7. DevOps requires testing and continuous integration. We will be covering this during the course, but there are several hosted services which can be used to run continuous integration on the code that we'll be writing. Sign up at [Travis](https://travis-ci.org/) with your github account.

Don't worry if you don't manage to do all of this before the course, we will be covering it during the sessions. However, it is advisable to try it before the course so that you can either come prepared, or have specific questions to answer when we get started.

# *Flame on !*


# References and Footnotes

[^ForkMyCourse]: Or, for those who wish to fork the course and run it independently.
