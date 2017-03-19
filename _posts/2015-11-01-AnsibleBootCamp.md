---
layout: post
title:  'An Ansible Boot camp'
description: 'Time to get your training on'
headline: 'Time to get your training on'
category: blog
tags: [blog, training, sci-gaia, ansible]
image:
  feature: '220110409213151001_4957481_ver1.0_640_480.JPG'
  attribution: ""
comments: false
mathjax: false
discourse: true
---

#  TL;DR

We teamed up with GARR to develop an intensive 5-day course for infrastructure operators, focussing on service federation and the DevOps movement. Using [Ansible](http://www.ansible.com), we went over the theory and practice of "Infrastructure as Code" with practical examples and lots of hands-on. This is still a work in progress, but will soon be published to [the Sci-GaIA e-Learning platform](http://courses.sci-gaia.eu). Watch [the repo](http://github.com/AAROC/AnsibleBootCamp) for more.

# <i class="fa fa-bolt"></i> Ansible Boot camp <i class="fa fa-bolt"></i>


Last week, we ran the first [Sci-GaIA](http://www.sci-gaia.eu) training course. The course was titled "[DevOps for Federation](http://agenda.ct.infn.it/event/1180/)" and was conducted at the INFN (Catania), by the Meraka Institute's [Bruce Becker](http://brucellino.github.io) and  [Andrea Biancini](http://www.unimib.it/go/9216095476319321399/Home/Italiano/Elenco-Docenti/BIANCINI-ANDREA-dipartimento-di-fisica-giuseppe-occhialini) from [GARR](http://www.garr.it) (the Italian NREN) and the Bicocca University in Milan. The core technologies taught in this course were Ansible and Shibboleth

<figure class="half">
<img src="{{ site_url }}/images/ansible_circleA_black_small.svg" style="width: 25%">
<img src="{{ site_url }}/images/shibboleth.png" style="width: 25%">
<figcaption>This course is affiliated neither with the Shibboleth project nor Ansible. We just like their stuff...</figcaption>
</figure>

## Off to a coding start

As its name suggests, the course is intendend for those with almost zero prior knowledge. There are indeed certain prerequisites which are not covered in the course, such as knowledge of Linux shells. An understanding of `git`, `python` and `YAML` for the first part, as well as a basic understanding of the Apache web server configuration for the second part are suggested - and these can be accomplished by well-known online code schools
The course is designed to be run stand-alone, with students taking it self-paced online. However, the material is modular and Open-Source, so it can be re-worked into university coursework or other technical training of a more formal nature. Much inspiration for the methodology was taken from the [Software Carpentry](https://software-carpentry.org/).

## Two timely topics


The course was separated into two sections -

  1. Theory and practice of DevOps with Ansible
  1. Turn your web service into a federated web service

These addresses two of the aims of the Sci-GaIA project : ***development of African Identity Federations, and the support of e-Infrastructures in the region***.

Taking identity federations as an example, as these are developed, the need for both identity providers as well as new services are going to be needed in the region. Since many countries are starting from scratch in their development of these federations, the administrators of new services are both learning how to develop them *and* operating them at the same time. There is therefore a great need for collaboration, knowledge dissemination and sharing, all of which are aspects of the DevOps movement. The tools of the trade may change from time to time, but the need to share best practice widely in a federation is a fundamental one.

An identity federation is only as useful as the services it offers to users, and often integrating existing services into a new federation takes very long and can be tricky. This course therefore also targets those administrators or service developers who indeed want to open up access to their web applications to a wider community without the overhead of user management. During the course, we discussed not only the technical aspects of how to do this, but also the human and policy aspects of developing services.

# <i class="fa fa-creative-commmons"></i> Open, Reproducible, Community

There are several online learning materials (and of course, TFM[^TFM] !) which address these issues of technology - so why make yet another online course ? The issue comes down to the development of community. While online code schools target mostly individuals, we wanted to target *communities* - in particular the NREN and e-Infrastructures communities. Particular emphasis is placed on making code open, maintainable, in adopting testing and verification strategies, and other good open source development practice. If, as the saying goes, *"everything is code"*[^EverythingIsCode], we wanted that code to be written well.

# <i class="fa fa-code"></i> Everything is code

We wanted the course to be *executable* in a sense. The sessions were taped on video, and will be available via the [Sci-GaIA Open EdX instance](http://courses.sci-gaia.eu), but that only addresses the student learning aspect. We also wanted it to be possible to give the course independently at a different institute, by different instructors. To this end, we have started working on the actual *course playbooks*[^playbooks]. The goal is that everything goes into [the repo](https://github.com/AAROC/AnsibleBootCamp); when someone wants to offer the course, everything that they will need will be available in the repository, except of course the online learning material such as videos and quizzes.

Included in the repository will be both instructor material,

  * **[Dockerfiles](https://docs.docker.com/reference/builder/)** necessary to build the training environment. Docker images will also be maintained on [Docker hub](http://hub.docker.com) for the instructor
  * **Lesson guides** - text files describing what to cover, with notes on what to focus on and inputs to the lesson plan.
  * **Evaluation playbooks** - playbooks which run against the student's work in order to check whether the lessons have been correctly done.

as well as the student material:

  * **Getting started guides** - summaries of the slides and common commands
  * **Tutorial playbooks** - initial playbooks which teach the students aspects of the DevOps approach and which demonstrate the functionality[^againstImages]
  * **Exercises** - both manual and coding exercises are foreseen. Most of them will be evaluated by playbook, so that they can be checked automatically.

By putting in extra effort initially, we hope to make the course independently *executable* - meaning that a student can in principle use everything in the repo to both create the course and take it. The hope is that both individuals as well as small, new groups could use this as a learning and teaching resources, using it and contributing back to the course as time goes by, thereby helping to build a stronger community of technical expertise in our region.

# <i class="fa fa-code-fork"></i> Powered by you

NREN's, grid and cloud services and data infrastructures are all powered by people at the end of the day. The Sci-GaIA project, through its member institutes, wants to leave a lasting impact on these _people_.

**It will be of no use to anyone to build a fine infrastructure if it's not built to last.**

# Coming soon

So, watch this space and hopefully we'll be able to announce the full course at the [UbuntuNet Connect Conference](http://www.ubuntunet.net/uc2015) in Maputo later this month. In the meantime, watch the <i class="fa fa-github"></i> [repo](https://github/AAROC/AnsibleBootCamp) - or if you're really keen <i class="fa fa-code-fork"></i> fork the repo and send us a pull request ! You'll  be helping to build a better infrastructure in Africa.

-----


# Footnotes and References

[^TFM]: The Fine Manual is always the best reference !
[^EverythingIsCode]: "Everything is code" is an operations philosophy wherein configuration management, testing and continuous integration tools are heavily adopted in order to represent all services in an infrastructure in some form of programming language. This makes the wall between service developers and service operators far less opaque.
[^playbooks]: ["Playbooks"](http://docs.ansible.com/ansible/playbooks.html) a concept in Ansible whereby it performs service orchestration. The concept is widely adopted as a strategy or tactics description in various sporting codes. (haha, get it - codes.)
[^againstImages]: These are to be run against Docker images, or similarly prepared virtual machines, depending on the classroom environment, to demonstrate how the system works.
