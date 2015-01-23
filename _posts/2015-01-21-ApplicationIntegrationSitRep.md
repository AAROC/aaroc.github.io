---
layout: post
author: Bruce Becker
type: status
title: Application Integration Sitrep
description: Weekly update and discussion on SAGrid-2.0
headline: Re-engineering the base dependencies on our Continuous Integration platform.
category: blog
tags: [AAROC, collaboration, DevOps]
image:
  feature: collabocats
comments: true
---

TL;DR - Applications are the lifeblood of our activity and the whole reason we 'built this city'. Ensuring that the *right* applications are on the grid *in the right way*, and at the right time is essential to providing a good service to our users. In order to make this accessible to as many users as possible, we've built an integration service which is nearing completion. We want to keep you all informed about it ! :smile:

# Background

The goal of the platform is to enable a trusted platform to act as an interface between developers, software maintainers and users, and the infrastructure itself. This is achieved by integrating Jenkins with source-code repositories on the incoming side, and an application delivery service on the outgoing side. The default for the former is a [Github](http://github.com/) repository, but just about any SCM could be used, while in the latter case, we are using [CVMFS](https://cernvm.cern.ch/filesystem).

The general idea is that applications should be continuously tested in an environment similar to that of the grid execution environment (on the worker-nodes).


## Modular repositories

We used to keep all of the code in a [single repository](https://github.com/SAGridOps/SoftwareInstallation), with directories organised per domain. However, triggering builds for individual projects was difficult, since a push to one of the directories triggered a build of the entire project. The work around was to have the local clone of the repo updated on commits, and to build the dependencies periodically. However, this led to several issues and was an inelegant solution.

We have now created new jobs on Jenkins which are linked on 1-to-1 mapping between jobs and repositories. These repositories are also in a different Github organisation - [@SouthAfricaDigitalScience](https://github.com/SouthAfricaDigitalScience). A quick glance over the repos there will give you some idea of how we've re-organised the repos. The re-implementation of the base dependency packages has almost been completed - a minor name change (including `-deploy`) indicates the new jobs on Jenkins, but the dependencies have been retained as the same.

## Promoted and stepwise builds.

We've also separated the builds into two phases, which execute two separate scripts. These are indeed to test different functionality of the projects

  1. `build.sh` - does the project actually compile ? This tests not only whether the code can compile, but also (implicitly) whether the dependencies are properly loaded. The build script usually executes something like `configure && make`, but not `make install`
  2. `check-build.sh` - can we execute the project from it's installation directory ? In a new shell, the check script will attempt to create the modulefile for the new project, and install it, then try to execute the project from its installation directory.

We still need to add some nontrivial tests, based on knowledge of the project itself; *e.g.* create some well-known output file using some well-known input file, as defined by the user of the project. This will be executed by something like `functional-test.sh`. These scripts are run in order by the job itself, which ***"promotes"*** builds based on simple checks. For example `check-build.sh` is only run if a file that is expected to be present after `make` - *e.g.* `somelib.so`. If the build does not create this expected file, the subsequent steps do not get triggered and the project does not get promoted.

We defined three levels of promotion for now, the final one being that a  human being has inspected the results of the build and manually promoted it. This means that the project can be put into the CVMFS repository.

# Try it out !

The system is ready for public beta... if you have an application that you'd like to port to the grid, simply get in touch and tell us the URL of the repo that you're using - we'll create the job and you can concentrate on developing the code, while Jenkins tests it for you.

Happy Hacking !
