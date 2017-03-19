---
layout: post
title:  'CODE-RADE Foundation Release 1'
description: 'Stuff you can use to build other stuff and a few demo applications'
headline: "It's finally public"
category: blog
tags: [blog, CODE-RADE, Release]
image:
  feature: tumblr_mw87ofGfHW1sfie3io1_1280.jpg
  attribution: "Image courtesy of New Old Stock - http://nos.twnsnd.co/image/69699793933"
comments: false
mathjax: false
discourse: true
---
<!-- TOC depth:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Announcing CODE-RADE Foundation Release 1](#announcing-code-rade-foundation-release-1)
- [Goal and Design](#goal-and-design)
	- [CODE-RADE is Open Source](#code-rade-is-open-source)
	- [Targets](#targets)
	- [Artifacts](#artifacts)
	- [Dependencies](#dependencies)
	- [Build Configurations](#build-configurations)
- [Repositories](#repositories)
- [Using CODE-RADE](#using-code-rade)
- [Roadmap and planning](#roadmap-and-planning)
<!-- /TOC -->

# Announcing CODE-RADE Foundation Release 1

We are pleased to announce the first **Foundation Release** of the CODE-RADE project :

<center>
<h2 class="post-title"><b>Co</b>ntinuous <b>De</b>livery of <b>R</b>esearch <b>A</b>pplciations in a <b>D</b>istributed <b>E</b>nvironment.</h2>
<img src="{{ site_url }}/images/code-rade-logo.png">
<h3><a class="fa fa-wrench"></a> Build <a class="fa fa-check-square-o"></a> Test <a class="fa fa-cog"></a> Execute <a class="fa fa-globe"></a> Everywhere</h3>
</center>

This release has been the result of the efforts of several people, and in particular the input of Sakhile Masoka, Fanie Riekert and Dane Kennedy is warmly acknowledged.

# Goal and Design

Simply put,the goal of the CODE-RADE project is to provide a user-driven, high-quality, continuous delivery platform for research applications to any site which wants them. The platform has been designed  based on widely-used components and tools :

  * Source code repositories : Github
  * Continuous Integration : Jenkins
  * Continuous Delivery : CVMFS
  * Service Orchestration  : Ansible

CODE-RADE fills a gap between the user or research software engineer who wants to have their applications available on a distributed computing infrastructure, and the site administrator who is tasked with keeping resources available and properly configured. This user- and test-driven approach allows for continuous integration and delivery of new research applications into a common repository which can be permanently configured at all participating sites.

<figure>
<img src="{{ site_url }}/images/code-rade-jenkins-magic.png">
<figcaption>CODE-RADE workflow and actors. <a href="http://dx.doi.org/10.15169/sci-gaia:1463574603.05">doi: 10.15169/sci-gaia:1463574603.05</a></figcaption>
</figure>

## CODE-RADE is Open Source

The platform itself is expressable in terms of Jenkins configurations and build, test and deploy scripts. The entire platform can be reproduced, although this is not currently automated. Source configuration for the platform, as well as other supporting configurations can be found at :
<div class="row">
<a class="fa fa-github"></a> <a href="https://github.com/AAROC/CODE-RADE">The CODE-RADE repo in AAROC on Github</a>
</div>

## Targets

CODE-RADE aims to deliver prebuilt applications to any site that wishes to execute them. In order to do this, the applications need to be compiled for a range of target sites, which may vary in operating system, CPU architecture, or in other ways such as network interconnect, availability of GPU's, etc. Each of these aspects are axes in the build system and define a build matrix as follows:

<table class="table table-bordered">
  <tr><td>SITE</td><td>A code used to describe the particular nature of the site. Currently only <code>generic</code> is used for all sites.</td></tr>
  <tr><td>ARCH</td><td>The CPU architecture used at the site. Currently only <code>x86_64</code> is used for all sites.</td></tr>
  <tr><td>OS</td><td>The operating system used at the sites. Currently only <code>sl6</code> and <code>u1404</code> are used for RedHat6 and derivatives and Ubuntu 14.04 LTS are used respectively</td></tr>
</table>

## Artifacts

Foundation Release 1 publishes three CVMFS repositories and several base libraries necessary for compiling other applications.

***For this reason, the release is called a "Foundation" - this provides you stuff to build other stuff.***

Several projects have been built:

  * [GCC Compiler toolchain](http://www.africa-grid.org/applications/#compilers)
  * [Math libraries](http://www.africa-grid.org/applications/#libraries)
  * [HPC libraries](http://www.africa-grid.org/applications/#libraries)
  * [Python framework](http://www.africa-grid.org/applications/#python)

Libraries are compiled with their dependencies expressed using module files and where possible several versions of the library are built in order to check for consistency and provide a wide as possible coverage. A tradeoff has had to be made between coverage and build times due to the limited resources of the build slaves.

Details of the projects and builds can be seen on the [Foundation Release 1](http://ci.sagrid.ac.za/view/Foundation%20Release%201/) page.

## Dependencies

Dependencies are managed using the bash modules tool, and by relevant build triggers in Jenkins. Software dependencies have been expressed using these build triggers and inspiration has been taken from the [Easybuild](https://easybuild.readthedocs.org/en/latest/) project. Other information on the dependencies of applications have been obtained from the project description pages.

The artifacts are built from the lowest-lying dependencies, up through the dependency chain, to end-user applications. Each build is responsible for creating it's own modulefile.

## Build Configurations

All build configurations are kept in change control. CODE-RADE has been designed to execute builds and tests of user-provided configuration on every commit to the source code management system. As the default SCM, we have chosen git and rely on the Github API to trigger most builds in Jenkins. While we do not have an explicit internal API, there is a working model of how builds should be configured, relying on three separate scripts executed in conditional sequence :

  1. `build.sh` - This starts the configuration and compilation of the application, with relevant dependencies added
  1. `check-build.sh` - if the compilation has been performed without error, this script performs application-specific checks, usually provided by the project itself (typically runnning `make check` or similar)
  1. `deploy.sh` - Once the application has been checked and staged to the continuous integration environment, this script reconfigures the build to the actual CVMFS target. This usually just involves a cleanup of the configuraiton and a re-installation to a different prefix.

There are several limitations to this approach, not least the capacity for user error, since there are almost no checks on the content of the scripts. The possibility of using a domain-specific language or a build-flow approach has been considered, but

# Repositories

CVMFS is used to distribute the artifacts to the sites. There is a Stratum 0 CVMFS server at the University of the Free State at `apprepo.sagrid.ac.za`. Three repositories have been created for differing use cases :
<table class="table">
  <tr class="warning">
    <td><b>fastrepo: </b></td>
    <td>Repository containing all successful builds</td>
  </tr>
  <tr class="info">
    <td><b>devrepo: </b></td>
    <td>Repository containing successful builds which have been tested by humans</td>
  </tr>
  <tr class="success">
    <td><b>apprepo: </b></td>
    <td>Repository containing all production software used at all sites.</td>
  </tr>
</table>

For more information on the repositories and how to use them, see [the AfricaGrid webpage](http://www.africa-grid.org/cvmfs)

# Using CODE-RADE

With this release, the tools necessary for integrating new applications from any user are available. They can be used by mounting the repositories directly on your laptop or cluster, using the [Ansible playbook](https://github.com/AAROC/DevOps/blob/master/Ansible/cvmfs.yml) or [scripts](https://github.com/AAROC/CODE-RADE/tree/master/cvmfs) provided.  The repositories are usually mounted under `/cvmfs`, _e.g._ `/cvmfs/fastrepo.sagrid.ac.za`

## Adding and using modules

Modules can be used by adding them to your module library :

    module use /cvmfs/fastrepo.sagrid.ac.za/compilers
    module avail
    ---- /cvmfs/fastrepo.sagrid.ac.za/modules/compilers ----
    gcc/4.9.2 gcc/5.1.0
    ---- /usr/share/modules/versions ----
    3.2.10
    ---- /usr/share/modules/modulefiles ----
    dot         module-git  module-info modules     null        use.own

The environment variables `SITE`, `OS`, `ARCH` and `CVMFS_DIR` are needed to use the modules properly on your site. You can set them by hand or use the [set script](https://github.com/AAROC/CODE-RADE/blob/master/modules.sh) in the CODE-RADE repo.

## Contributing

Should you be interested in contributing to the CODE-RADE project, you can :

  1. Add applications - Use the [demo repo](https://github.com/SouthAfricaDigitalScience/my-first-deploy) to see how to build and test applications. We can create the job in Jenkins and from there on out, your commits will trigger builds.
  1. Review applications - Have we configured the builds properly ? Are the applications properly configured ? You can see all of the applications that we support at <a class="fa fa-github"></a> <a href="https://github.com/SouthAfricaDigitalScience">github.com/SouthAfricaDigitalScience</a>.
  1. Applications can also be discussed at the [African e-Infrastructures Forum](https://discourse.sci-gaia.eu) under the [Applications category](https://discourse.sci-gaia.eu/c/applications).


# Roadmap and planning

<img class="img-responsive img-rounded pull-left" src="{{ site_url }}/images/waffle.png" width="60">
This is the first release of the CODE-RADE platform; new applications and builds are continuously added to the repositories. Further releases will contain more tooling (different compilers, application libraries and application dependencies). The [Release Milestone](https://github.com/AAROC/CODE-RADE/milestones/Infrastructure%20foundation%20release%201) issues have all been closed.

  * <a class="fa fa-list-ul"></a> Issues and requests can be made via the [project board](https://waffle.io/AAROC/CODE-RADE).
  * <a class="fa fa-road"></a> Milestones are described describe at [the CODE-RADE repo](https://github.com/AAROC/CODE-RADE/milestones) on github.

<img class="img-responsive img-rounded pull-right" src="{{ site_url }}/images/slack-logo-2x.png" width="60">
We use Slack to keep in touch while developing, and automation talks to us in [\#code-rade](https://africa-arabia-roc.slack.com/messages/code-rade). If you would like to help us deliver software better to researchers, get in touch and come hang out with us (and our trusty bots.).

----
