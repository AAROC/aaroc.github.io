---
layout: post
title:  'CODE-RADE build burn down 36'
description: 'Summary of the build burn down of the CODE-RADE project, week 36'
headline: "CODE-RADE: burn baby burn"
category: blog
tags: [blog, CODE-RADE, sitrep]
image:
  feature: burn.jpg
  attribution:
comments: false
mathjax: false
discourse: true
---

# Burn down

> TL;DR: The CODE-RADE platform is now mostly configured, and minor problems overcome. Continuous integration is being tested with weekly burn downs, to see whether the full chain is working. **Spoiler alert: it's not**. Also, you can help !

Here's the thing :

----

<figure>
<img src="http://i.giphy.com/cEYFeDOOQ0cHqIgIEOA.gif">
<figcaption>BAD THINGS HAPPEN !</figcaption>
</figure>

----

<img src="{{ site_url }}/images/code-rade-logo.png" style="float:left; height:100px; border:5px; margin:10px;">
Stuff breaks. The whole point of this project is to develop a system which will _reliably, reproducibly, rapidly_ rebuild the repository of applications used at various sites. We therefore conduct these burn downs to see if this is actually the case (spoiler: it's not yet), and highlight the issues which remain in the ashes.

The CODE-RADE platform is how we think we can reliably deliver applications to both sites and individual users and _do it right_. Right means :

  * **Continuous** - New requests are automatically integrated using standard build and integration procedures. Most tasks are automated and little intervention is needed from site administrators.
  * **User-driven** - Want an app that's not in our repository ? Just send us a pull request.
  * **Site-Independent** - We build the apps for execution
  * **Reproducible** - When we integrate something, we want it to _stay_ integrated. The last budgie standing after the nuclear holocaust should be able to rebuild _everything_ just by gently nudging their cute little beak against the still-radioactive screen showing the CI build server web interface.


# Integration flow

<figure>
<img src="{{ site_url }}/images/home-image1.png" width="800px" href="http://www.go.cd/">
<figcaption>An example of Continuous Integration workflow, by the ThoughtWorks GO CI product team.</figcaption>
</figure>

Integration is not a linear path. Of course, it can't be _cyclical_, but to satisfy various end-user and site configuration desires, there has to be a level of paralellism involved. We do this with the Jenkins [MatrixJob Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Matrix+Project+Plugin). This allows us to define _axes_ for our job configurations, for example the target operating system or application version number.

There are also various _phases_ to the integration flow, from initial request to final delivered product.  It would be really nice to have a visual representation of the state of your application - to be able to answer, _e.g._ the question :

> "Where is my application in the delivery chain ?"

 Another issue which we'd like to address how to raise, escalate and resolve issues that may arise during the integration workflow. Now, we've taken the route that each application which we want built and integrated should have its own repository - we've now got around 30 repos in [South Africa Digital Science](https://github.com/SouthAfricaDigitalScience). How do we keep track of what state the various applications are, cross-reference them with their build results and understand where the bottlenecks are ?

-----

<img src="{{ site_url }}/images/waffle.png" style="float:left; height:100px;">
It just so turns out that this problem is not a new one, basically, we need a "scrum" or "kanban" board[^ScrumBoard].
To this end, we've created a [board](https://waffle.io/AAROC/CODE-RADE) to contain all of the tickets opened in the various repos against the specific applications. The single board allows us to place to see the overall status of the CODE-RADE project. Unfortunately, ticket dependencies are managed "by hand" - there's no way (yet) to specify which cards are  blocked by which other ones, but we can take care of that just by manually ordering the cards on the board. Anyone who owns the repos (ie, in the right team of the owner organisations on Github) can interact with the board. Updating tickets information just involves a few clicks, and shifting issues along the pipeline is a drag-and-drop procedure.


<figure>
<img href="https://waffle.io/AAROC/CODE-RADE" src="{{ site_url }}/images/code-rade-waffle-screenshot-2015-09-14.png" width="800px" >
<figcaption>Full overview of the build flow, from a multi-repo waffle board. </figcaption>
</figure>



## Dependency Graph

One of the greatest (and thus hardest) things about CODE-RADE is the expression of dependencies between applications. Most open source software is not a monolithic structure, but rather delicate - some might say graceful - assembly of various independent components. These components may be in turn variously configured to produce different functional states, each of which can be considered nodes in a DAG[^DAG]. In fact, one of the main corrolaries of CODE-RADE, if we do things right, is to express a more-or-less fully-populated graph of the dependencies of _all_ applications used in scientific research[^notpossible] (or at least the most popular ones).

<figure>
<img src="{{ site_url }}/images/graph.png" width="800px">
<figcaption>The compiler build chain dependency graph as of writing - yes, it needs work. The full dependency graph is too large to show on one page. See <a href="http://dx.doi.org/10.5281/zenodo.30977">http://dx.doi.org/10.5281/zenodo.30977</a></figcaption>
</figure>

This is for what we're calling ***"Foundation Release 1"*** - _IE_, "*stuff you can use to build other stuff*".

# Build Failure Analysis

<i class="fa fa-pull-left fa-2x fa-lightbulb-o"></i>We're using the [Jenknis Build Failure Analysis plugin](https://wiki.jenkins-ci.org/display/JENKINS/Build+Failure+Analyzer) to identify various build failures. This is a fantastic plugin which scans the build logs and tries to figure out (via regexp) what went wrong. The build failure analysis helps us to estimate how much time fixing a build failure would take and spotting error patterns that are affecting more than one job.

Of course, failure types have to be spotted and identified by actual humans - so, if you've got some time on your hands and feel like reading build logs, why not help us isolate these common errors and implement fixes ?

# Bottlenecks

So, with the dependency graph expressing the route from one component to the next, and the waffle board detailing where the actual issues are, we can plan work to address this and ensure that the pipeline burns right down. Here's a summary of the current state of affairs:

  * Total jobs in Foundation Release: 20
  * Failing jobs: 5

So, we're roughly 75 % of the way there (at least, using one definitely inappropriate metric ![^BetterMetric]).

## Disk space - workaround

One problem was the issue of disk space. The jobs were being built entirely on the slaves - which meant that the build artifacts including the intermediate ones were all kept on thes fairly small machines (~ 100 GB). The CI server however has a nice big (~1TB) disk which we are now exporting portions of over  NFS to the build slaves. Thus, the jobs are all reading from and writing to a single disk.

While this solves the size available problem, it does bring up some severe performance issues, especially in the case of wide matrix jobs such as `gcc`, which has 6 concurrent builds for the different axes. This can probably be alleviated by ensuring that the matrix builds are sequential instead of parallel as they are at the moment.

## Numpy errors

The [NumPy](http://www.numpy.org/) build scripts in their own  [repo <i class="fa fa-github"></i>](https://github.com/SouthAfricaDigitalScience/numpy-deploy) - currently, we're getting the following error when building NumPy

```python
'import site' failed; use -v for traceback
Traceback (most recent call last):
  File "setup.py", line 16, in <module>
    from __future__ import division, print_function
ImportError: No module named __future__
Build step 'Execute shell' marked build as failure
```

We have no idea what this means, so if you're a python speaker, please take a look at the `build.sh` script and maybe send us a PR that fixes it.

## OpenMPI

OpenMPI is failing only on the SL6 slaves. From the looks of things, the builds are passing, but functional tests are not. These are giving modulefile errors such as

```bash
+ ./check-build.sh
About to make the modules
./check-build.sh: line 3: cd: /var/lib/jenkins/workspace/OpenMPI/ARCH/x86_64/GCC_VERSION/5.2.0/OS/sl6/SITE/generic/VERSION/1.8.1/openmpi-1.8.1: No such file or directory
```

and further down the `check-build.sh` script :

```
ModuleCmd_Load.c(208):ERROR:105: Unable to locate a modulefile for openmpi/1.8.1-gcc-5.2.0
which: no mpirun in (/usr/local/bin:/bin:/usr/bin)
Build step Conditional step (single) marked build as failure
```

The NumPy build failures are inhibiting the rest of the python chain including SciPy and others.

# SitRep and TODO

So... this weekend's burn down went ok, but not awesomely. We need to focus on testing the compilers out of the build environment now. (this would be the validation channel in the waffle board) and call in some help on the NumPy and SciPy issues. Also, some time needs to be spent on actually populating the board with the tickets for checking the application states...

-----

The next community call is Wednesday 16/09 at midday. Be there or be[^square] :squirrel:

-----

# References and Footnotes

[^square]: That's a squirrel, in case you're wondering. Emoji haven't caught up to 1950's slang yet. We live in hope.
[^ScrumBoard]: Also known as a KANBAN board. See [Altassian's description](https://confluence.atlassian.com/display/AGILE/Scrum+Board)
[^DAG]: DAG : [Directed Acyclic Graph](https://en.wikipedia.org/wiki/Directed_acyclic_graph).
[^notpossible]: Ok,. this is clearly not possible even in principle, since there are new applications, version and configurations born every day - but hey, at least we're reaching high :smile:
[^BetterMetric]: Waffle allows you to assign "sizes" to your cards, which are basically estimates of how much effort is required to move them... I guess it's similar to "mass" in that sense. So, if you take a look at the board, it'll show you where the actual centre of mass of the project is. Which is :cool:
