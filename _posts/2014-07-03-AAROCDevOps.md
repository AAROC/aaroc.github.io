---
layout: post
title: Let's make AAROC DevOps
description: Lets make AAROC #DevOps 
headline: AAROC #DevOps
category: DevOps
tags: [AAROC, DevOps, sustainability, collaboration, GitHub, EverythingIsCode]
image: 
  feature: 
comments: true 
---
I would like to update you on our progress to develop a ***DevOps*** competency in the Africa-Arabia Regional Operations Centre.

As I mentioned yesterday in the meeting, our site administrators are all over extended and can't be expected to maintain the large and growing array of services that our users need independently. A lot of effort is spent on trying to make services properly configured, and a lot more goes into debugging incorrect configurations. 

The philosophy that I would like us to adopt is that 

> ***"everything is code, so we should apply good coding practice to everything".***

While the analogy of "everything = code" is not entirely applicable - and here I want to support Scott's point that peer-to-peer communication and support is always going to be important - we can and should benefit from a "DevOps" paradigm. I mentioned that we could "centralise" operations to make it more sustainable. What I meant by this was having a central place for the configuration. If one considers that a functional site is the convolution of the description and execution of configuration - and to have a functional site, we need to have both, it makes sense to have these in a version-controlled, collaborative environment. 

We've been using [Github](https://www.github.com) for a good while now, where I've started the [@AAROC](https://github.com/AAROC) organisation - I warmly invite every site admin in the region to [send me](mailto:bbecker@csir.co.za) their github user name so that I can add you to the organisation. In the DevOps  repository, we have configuration for various sites, which can be executed by Ansible, as well as Puppet (thanks to Chris (@kalvaer) for the recent contribution).

The goal is that sites which would like to deploy services need only describe their site's particulars, and decide which services need to be configured. Using Ansible or Puppet (fans of other configuration managers, feel free to contribute !) they can execute the configuration. What is more, with the configuration described in the various files in the repository, we can track how it has been changed compared to other instances, and more easily find bugs and errors. 

We're hopefully always going to be a community where it's acceptable and encouraged to support each other on a personal basis, but what we need to ensure sustainability is coherence. In order to maintain this ROC, we need to support each other to the best of our capacity and experience. Let's contribute to the shared repository and help each other in a more self-consistent way. 

Finally, the last thing I want to do is create more work for those in the team... if what I'm discussing here sounds like just another thing to do, please don't hesitate to delegate this task to myself, Bouchra, or another trusted expert in the ROC. We can escalate requests to EGI and other peers and clean up your contributions. If you feel (as Chris at UJ did) that your code is not fit for public consumption, remember that 
  
  1. we are team and trust is important
  1. @AAROC has private repos which you can contribute to if you're hesitant of letting your code in to the wild. 
  1. If it's not in a repo, it doesn't exist for all practical purposes, so you're on your own. 

Looking forward to your continued commitment and contributions,
Thanks !
