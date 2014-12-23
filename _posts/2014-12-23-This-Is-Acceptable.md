---
layout: post
type: status
title: Executable Infrastructure heads to ISGC
description: Our contribution to International Symposium on Grids and Clouds was accepted !
headline: Executable Infrastructure heads to ISGC
category: blog
tags: [AAROC, collaboration, DeOps]
image:
  feature:
comments: true
---

"Executable Infrastructure" is going to Taipei !

---

A few months ago, we submitted an abstract for our DevOps approach in Africa-Arabia. We just got the word that it has been accepted as an **oral contribution** to [ISGC 2015](http://event.twgrid.org/isgc2015/) in Taipei. Comments from the reviwers :


> The African-Arabian region provides a particularly challenging environment in which to dpeloy sustainable and available e-Infrastructure. The experience presented - in conjunction with the urgency felt in the region to deploy such an infrastructure in production - will be of interest to many more regions in the world and for those with which they will interoperate.

Sweet !

The full Abstract is as follows:

-----

E-Infrastructure has, over the years, proven its worth in enabling scientific collaboration, even at regional and global scales. The adoption of common platforms such as HPC, data management, etc has made sharing of scientific data, applications and research outputs more appealing and is accelerating scientific output, especially in regions where these were previously unavailable - particularly Africa, and areas of the Arab-speaking world. The CHAIN-REDS and ei4Africa projects have supported the development of the Africa-Arabia Regional Operations Centre (AAROC). The ROC acts as a coordination point, first for grid infrastructures, but has been expanded to more general collaboration infrastructure services such as science gateways, federated identity providers, document and data repositories, etc. This expansion of service offering to ever-more demanding research communities places unreasonable strain on a fully-distributed model, where every site admin is expected to understand and operate these new services. This is particularly true in the African and Arabian regions, where knowledge networks are sparse.

This contribution describes a development and deployment philosophy which adopts a "DevOps" paradigm which aims to encode models of services using Ansible, with Github as a collaboration platform. Site and service configuration has been coded into Ansible playbooks, providing a reproducible model of the service, which can be customised as desired on a per-site basis. Most importantly, this model is executable, meaning that any number of sites and services can be effectively deployed remotely, by a core team. Continuous integration is done at every commit of code, by executing the playbooks on a cloud-based development site, which provides transparency to the remote site administrators.

The adoption of this methodology helps to solve the problems of sustainably maintaining service configuration, improving communication between site operations and service developers, ensuring the proper state of services, and verifying the state of deployment.

Some of the main benefits of this approach are speeding up the deployment of new services, reliably applying updates and recovering from disaster. In this contribution, we show that the "traditional" HPC and grid service deployment can be reproduced and improved, by adopting a more modern operations stack. However, we also highlight how this has helped to deploy advanced services- federated identity infrastructure, science gateways and Open Access repositories in particular throughout the region in short time, and is now playing a crucial role in the strengthening of technical and scientific collaboraiton networks in the region.

----

The proposal and work will be open-sourced from https://github.com/AAROC/ISGC2015 once it has been properly reviewed. If you want a hand in the writing and maybe co-authorship, get hold of us :smile:
