---
layout: post
title:  'CODE-RADE commentary'
description: 'Some critical feedback from the community on CODE-RADE'
headline: "What do you think?"
category: blog
tags: [blog, CODE-RADE, sitrep]
image:
  feature: SplitShire-068.jpg
  attribution: "Image courtesy of SplitShire http://www.splitshire.com/light-umbrella/"
comments: false
mathjax: false
discourse: true
---

No project can live without the oxygen of and fire of debate. The time has come to put CODE-RADE out there in the wild, and see how it stands up to the real world. The philosophy, technique and end product need to pass the most crucial and critical of all tests : usability. We asked a few people to contribute their ideas and criticisms, which we publish here (edited only for quality and grammar).

This week's comment is from [Dane Kennedy](http://github.com/kennedydane), a research scientist at the [CHPC](http://www.chpc.ac.za) - South Africa's largest research computing centre and one of the target sites for the project. We asked the questions _in italics_ and let him go wild with his responses. If you have further commentary, please [follow the discussion](http://discourse.sci-gaia.eu/t/code-rade-commentary/1799)

-----


> First let me start by saying that I'm very new to the setup and I've not read all the links and documentation that has been thrown at me. So -- my comments and observations may well be uninformed.

  1. ***What do you like about the project ?*** - Well I quite like the idea of having an automated system for application compilation and installation. I like that there are enthusiastic scientists involved who want to make things work better.
  1. ***You expressed some doubts about the usability of the system in a place like CHPC - could you expand ?*** - Well, my doubts were actually more general -- one of scalability. I am worried that the current system (as I understand it) revolves around supplying different versions of applications for different versions operating systems and potentially different versions of hardware. So I am worried that as the package list grows, this will become unmanageable. My other issue is that I am concerned about the CVMFS -- it seems like a relatively specialised read-only remote filesystem that does various magical things like caching and Idon'tknowwhat. I worry about things that could potentially require one to be connected to the internet. So somewhere like the CHPC is connected all the time, of course (well hopefully!), but I'm considering other scenarios like Mike the Biologist who is away at a conference and no longer has internet access. Now that he can't mount CVMFS -- does his software stop working on his laptop? I'm guessing that's where the caching come in... But it still leaves me feeling somewhat uncomfortable (I must read more about this).
  1. ***Any criticism of the workflow ?*** At the time when I first got introduced to this there seemed to be some kind of NFS problem, which meant that build times were very slow. As someone who is absolutely rubbish at multi-tasking or task-switching, the longer I have to sit and wait between builds is probably going to result in me losing interest and working on something else where I can have more flow. This can obviously be overcome and the number of build nodes can be increased presumably.
  1. ***Where do you see this project going ? how could it benefit users - and what needs to change for that to happen?*** I'm not sure. I am concerned that there's an element of re-inventing the wheel here. It feels like package management is an old idea, and what this is aiming to do is provide users with the option of selecting particular versions of their tool of choice. This too is not a new problem -- I have had a lot of success using (ana)conda -- and I think it might be worthwhile investigating that as an option. It also looks at setting up users environments, making sure versions are correct and that dependencies are met (and if they're not -- it will install them). Most people are familiar with it as a python package manager, but it's not python-specific -- in fact one can now get ahold of R stuff there. So, I'm actually going to put a little more effort into investigating (ana)conda package management as it seems as if it might be a little more flexible in terms of providing a solution to a wide variety of end-users.
  1. ***How would you see users interacting , via bot, with this ?*** I haven't thought about bots interacting with this much.
