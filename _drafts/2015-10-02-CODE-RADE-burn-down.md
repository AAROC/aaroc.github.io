---
layout: post
title:  'CODE-RADE: Community Feedback'
description: 'Feedback from devs and community in week 39'
headline: "CODE-RADE: Ignition"
category: blog
tags: [blog, CODE-RADE, sitrep]
image:
  feature: 1979369093_55ba84a606_o.jpg
  attribution: Stavros Markopoulos https://www.flickr.com/photos/markop/1979369093/in/faves-91618948@N00/
comments: false
mathjax: false
discourse: true
---

# Burn down

> TL;DR: We're approaching a release for CODE-RADE and are starting to get some other people involved. We have some contributions from @dane and @mrsakhs

# Ideas and feedback

## From @kennedydane

First let me start by saying that I'm very new to the setup and I've not read all the links and documentation that has been thrown at me. So -- my comments and observations may well be uninformed.

  1. *What do you like about the project ?* - Well I quite like the idea of having an automated system for application compilation and installation. I like that there are enthusiastic scientists involved who want to make things work better.
  1. *You expressed some doubts about the usability of the system in a place like CHPC - could you expand ?* - Well, my doubts were actually more general -- one of scalability. I am worried that the current system (as I understand it) revolves around supplying different versions of applications for different versions operating systems and potentially different versions of hardware. So I am worried that as the package list grows, this will become unmanageable. My other issue is that I am concerned about the CVMFS -- it seems like a relatively specialised read-only remote filesystem that does various magical things like caching and Idon'tknowwhat. I worry about things that could potentially require one to be connected to the internet. So somewhere like the CHPC is connected all the time, of course (well hopefully!), but I'm considering other scenarios like Mike the Biologist who is away at a conference and no longer has internet access. Now that he can't mount CVMFS -- does his software stop working on his laptop? I'm guessing that's where the caching come in... But it still leaves me feeling somewhat uncomfortable (I must read more about this).
  1. *Any criticism of the workflow ?* At the time when I first got introduced to this there seemed to be some kind of NFS problem, which meant that build times were very slow. As someone who is absolutely rubbish at multi-tasking or task-switching, the longer I have to sit and wait between builds is probably going to result in me losing interest and working on something else where I can have more flow. This can obviously be overcome and the number of build nodes can be increased presumably.
  1. *Where do you see this project going ? how could it benefit users - and what needs to change for that to happen?* I'm not sure. I am concerned that there's an element of re-inventing the wheel here. It feels like package management is an old idea, and what this is aiming to do is provide users with the option of selecting particular versions of their tool of choice. This too is not a new problem -- I have had a lot of success using (ana)conda -- and I think it might be worthwhile investigating that as an option. It also looks at setting up users environments, making sure versions are correct and that dependencies are met (and if they're not -- it will install them). Most people are familiar with it as a python package manager, but it's not python-specific -- in fact one can now get ahold of R stuff there. So, I'm actually going to put a little more effort into investigating (ana)conda package management as it seems as if it might be a little more flexible in terms of providing a solution to a wide variety of end-users.
  1. *How would you see users interacting , via bot, with this ?* I haven't thought about bots interacting with this much.

## from @smasoka

... Sakhile, write your feedback here.

  1. What research aspects are you most interested in ?
  1. You had to build some infrastructure bits, rather than end-user applications... how do you see sites using this, compared to their standalone installations ?
  1. ... comments, etc...



## Dependency Graph


... update the dependency graph ...

# Build Failure Analysis

... what new things are going wrong ? ...

# Bottlenecks

... where can and should we speed things up ? ...

# Docker, yo.

... ideas about how to use Docker ***in testing***

How should we used docker ?

We originally had the idea to use  Docker to _deliver_ apps to users, however this brings up a bunch of security concerns, as well as practical issues, similar to the case of federated cloud sites. It's just too complicated at the moment to consider user applications in HPC to run reliably, cross-site in containers. So, we're sticking to CVMFS for prod.

However, dev is a different story.

jenkins docker

 * enable docker api locally


## missing Automation

... @brucellino talks about the CVMFS devrepo automation that's missing.



# SitRep and TODO

...

  1. draw a line around the foundation release - we need everything in that release to work.
  1. new applications
  1. docker

-----

The next community call is Wednesday 16/09 at midday. Be there or be[^square] :squirrel:

-----

In the meantime :

<div id='discourse-comments'></div> <script type="text/javascript">
  DiscourseEmbed = { discourseUrl: 'http://discourse.sci-gaia.eu/',
                     discourseEmbedUrl: 'http://www.africa-grid.org/blog/2015/09/14/CODE-RADE-burn-down/' };

  (function() {
    var d = document.createElement('script'); d.type = 'text/javascript'; d.async = true;
    d.src = DiscourseEmbed.discourseUrl + 'javascripts/embed.js';
    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(d);
  })();
</script>

# References and Footnotes
