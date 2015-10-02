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

> TL;DR: The CODE-RADE platform is now mostly configured, and minor problems overcome. Continuous integration is being tested with weekly burn downs, to see whether the full chain is working. **Spoiler alert: it's not**. Also, you can help !




## Dependency Graph


... update the dependency graph ...

# Build Failure Analysis

... what new things are going wrong ? ...

# Bottlenecks

... where can and should we speed things up ? ...



## Numpy errors

The [NumPy](http://www.numpy.org/) build scripts in their own  [repo <i class="fa fa-github"></i>](https://github.com/SouthAfricaDigitalScience/numpy-deploy) - currently, we're getting the following error when building NumPy

{% highlight python %}
    'import site' failed; use -v for traceback
    Traceback (most recent call last):
      File "setup.py", line 16, in <module>
      from __future__ import division, print_function
    ImportError: No module named __future__
    Build step 'Execute shell' marked build as failure
{% endhighlight %}

We have no idea what this means, so if you're a python speaker, please take a look at the `build.sh` script and maybe send us a PR that fixes it.

... did we fix this ? ...

## OpenMPI

.... hopefuly since #297 we're good... what changed ?

OpenMPI is failing only on the SL6 slaves. From the looks of things, the builds are passing, but functional tests are not. These are giving modulefile errors such as

{% highlight bash %}
+ ./check-build.sh
About to make the modules
./check-build.sh: line 3: cd: /var/lib/jenkins/workspace/OpenMPI/ARCH/x86_64/GCC_VERSION/5.2.0/OS/sl6/SITE/generic/VERSION/1.8.1/openmpi-1.8.1: No such file or directory
{% endhighlight %}

and further down the `check-build.sh` script :

{% highlight bash %}
ModuleCmd_Load.c(208):ERROR:105: Unable to locate a modulefile for openmpi/1.8.1-gcc-5.2.0
which: no mpirun in (/usr/local/bin:/bin:/usr/bin)
Build step Conditional step (single) marked build as failure
{% endhighlight %}

The NumPy build failures are inhibiting the rest of the python chain including SciPy and others.

# Docker, yo.

... ideas about how to use Docker ***in testing***

# Ideas and feedback

## from @kennedydane
Hey hey. I'll write some stuff that I'm not sure belongs in the blog. But you can edit to your heart's content.

First let me start by saying that I'm very new to the setup and I've not read all the links and documentation that has been thrown at me. So -- my comments and observations may well be uninformed.

  1. *What do you like about the project ?* Well I quite like the idea of having an automated system for application compilation and installation. I like that there are enthusiastic scientists involved who want to make things work better.
  1. *You expressed some doubts about the usability of the system in a place like CHPC - could you expand ?* Well, my doubts were actually more general -- one of scalability. I am worried that the current system (as I understand it) revolves around supplying different versions of applications for different versions operating systems and potentially different versions of hardware. So I am worried that as the package list grows, this will become unmanageable. My other issue is that I am concerned about the CVMFS -- it seems like a relatively specialised read-only remote filesystem that does various magical things like caching and Idon'tknowwhat. I worry about things that could potentially require one to be connected to the internet. So somewhere like the CHPC is connected all the time, of course (well hopefully!), but I'm considering other scenarios like Mike the Biologist who is away at a conference and no longer has internet access. Now that he can't mount CVMFS -- does his software stop working on his laptop? I'm guessing that's where the caching come in... But it still leaves me feeling somewhat uncomfortable (I must read more about this).
  1. *Any criticism of the workflow ?* At the time when I first got introduced to this there seemed to be some kind of NFS problem, which meant that build times were very slow. As someone who is absolutely rubbish at multi-tasking or task-switching, the longer I have to sit and wait between builds is probably going to result in me losing interest and working on something else where I can have more flow. This can obviously be overcome and the number of build nodes can be increased presumably.
  1. *Where do you see this project going ? how could it benefit users - and what needs to change for that to happen?* I'm not sure. I am concerned that there's an element of re-inventing the wheel here. It feels like package management is an old idea, and what this is aiming to do is provide users with the option of selecting particular versions of their tool of choice. This too is not a new problem -- I have had a lot of success using (ana)conda -- and I think it might be worthwhile investigating that as an option. It also looks at setting up users environments, making sure versions are correct and that dependencies are met (and if they're not -- it will install them). Most people are familiar with it as a python package manager, but it's not python-specific -- in fact one can now get ahold of R stuff there. So, I'm actually going to put a little more effort into investigating (ana)conda package management as it seems as if it might be a little more flexible in terms of providing a solution to a wide variety of end-users.
  1. *How would you see users interacting , via bot, with this ?*
I haven't thought about bots interacting with this much.

## from @smasoka

... Sakhile, write your feedback here.

  1. What research aspects are you most interested in ?
  1. You had to build some infrastructure bits, rather than end-user applications... how do you see sites using this, compared to their standalone installations ?
  1. ... comments, etc...

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
