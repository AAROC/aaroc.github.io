---
layout: post
title:  'CODE-RADE submodules'
description: 'Consolidating work'
category: blog
tags: [blog, CODE-RADE, Release]
image:
  feature: tumblr_mxah7dcExT1sfie3io1_1280.jpg
  attribution: ""
comments: false
mathjax: false
discourse: true
---

# TL;DR - All the apps we build and test are linked from a single repo.

This is just a short update on progress with the CODE-RADE project with a  description of where to find the code and how to contribute.

# <i class="fa fa-check-square-o"></i> How testing works.

A huge aspect of CODE-RADE is modularity - we build and test nodes in a dependency tree, from base dependencies all the way up. Instead of providing a single binary result (yes, the repo is working, no there are problems), we provide a result for each node in the tree. Specifically, that means that every application is compiled against its dependencies and tested before the next node in the tree is done.

A second aspect of CODE-RADE is continuous integration - tests would run at _every commit_ of code to a repository. Modularity implied that only the node that has changed should be tested, and that this test should trigger all of the upstream tests in order to see if there were regression problems. The alternative would be to have monolithic testing where the full tree was traversed on a predetermined schedule, taking into account any changes that had been made.

While these two approaches are not necessarily contradictory, the first had the agility which we felt was one of the strong points of CODE-RADE for community adoption, and the benefit of giving fairly fast responses[^fast] to any changes made by a contributor.

Originally, we had the idea that everything would go into a [single repository](https://github.com/SAGridOps/SoftwareInstallation), making it easy to publish and collaborate. However, when it came to configuring the triggers of the Jenkins, it was easiest to have a single repository to listen to:

<figure >
<img src="{{ site_url }}/images/github-repo-in-jenkins-project-screenshot.png" />
<figcaption>Jenkins jobs can be assocated with a github repository, using the <a href="https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Plugin">Github plugin</a></figcaption>
</figure>

<figure>
<img src="{{ site_url }}/images/JenkinsBuildTriggersScreenshot.png" />
<figcaption>Jenkins provides for many build triggers which determine under which condition or event the job will be executed. Using the Github API, changes made the repository associated with the job can act as these triggers.
</figcaption>
</figure>

This meant that we made the choice to separate each node in the dependency tree into its own git repository - most of them under the [SouthAfricaDigitalScience Github organisation](https://github.com/SouthAfricaDigitalScience/). This made testing the components easier, as well as the creation of the dependency tree - and while all of the repos were in one organisation, it may even be manageable - but as soon as we start including different repos, the complexity may become an inhibiting factor.

<figure>
<img src="{{ site_url }}/images/jenkins-source-control-option-screenshot.png">
<figcaption>Jenkins jobs can be configured with source code management (SCM). One of these methods is git, and each project can have one git repository, depending on the plugins in use.</figcaption>
</figure>

So we have a dilemma : In order to keep testing atomic, we need to have individual repositories for nodes in the dependency graph, but in order to present a coherent code base to promote collaboratation, we need a single repository ?

# <i class="fa fa-git-square"></i> Git submodules to the rescue.

Fortunately, this is an issue often encountered by software built on dependencies, with external plugins or similar. One of the most common solutions to the problem is to add the external bits as [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules). Indeed from the git submodules documentation[^submodules] :

> It often happens that while working on one project, you need to use another project from within it. Perhaps it’s a library that a third party developed or that you’re developing separately and using in multiple parent projects. A common issue arises in these scenarios: you want to be able to treat the two projects as separate yet still be able to use one from within the other.


This indeed seems like our case. We want to have a single point of entry for collaborators and applications - [the CODE-RADE main repository](https://github.com/AAROC/CODE-RADE), while still keeping the modularity which allows atomic testing and integration.

# Onward, then !

So, I've started adding submodules to a [subdirectory](https://github.com/AAROC/CODE-RADE/tree/master/applications) of the CODE-RADE repo, and will soon have all of them included. The CODE-RADE repo itself will not get tested, but it will be possible to fork it including the submodules and send pull requests. These will get tested only by the specific job which is configured to listen to changes in the submodule repository, _i.e._ if changes are made in the `gcc-deploy` submodule, and this pull request is sent to the CODE-RADE repo, only the [gcc-deploy](http://ci.sagrid.ac.za/job/gcc-deploy/) job will get triggered.

Modules, yo.

For more information, see the [build server](http://ci.sagrid.ac.za)
<center>
<img src="{{ site_url }}/images/code-rade-logo.png" href="http://ci.sagrid.ac.za" />
</center>

# References and Footnotes

[^fast]: Of course "fast" here depends on the time needed for the actual compilation. The longest compilation time we have is for the [GCC project](http://ci.sagrid.ac.za/job/gcc-deploy) which can take up to 10 hours.
[^submodules]: Taken from the [Git submodules documentation page](https://git-scm.com/book/en/v2/Git-Tools-Submodules). Accessed 16-01-2016.
