---
layout: post
title: CODE-RADE in the Real World
description: 'What use is a user if the infrastructure is useless ?'
headline: "Let's get rid of those bottlenecks and get our science on !"
category: blog
tags: [blog, HPC, CODE-RADE, automation, jenkins, github, rock n roll]
image:
  feature: bottleneck.jpg
  attribution:
comments: true
mathjax:
discourse: false
---


# TL;DR: We are building some awesome technical automation to deliver applications - but how does the actual intended audience actually use it ?

Whoa ! That's a mouthful, even for a quasi-abstract, but stick with me, this one is all about "Ok, now what ?".  The time has come to get real with CODE-RADE project, after many many months of laying down foundations. The basic premise of the project is to demolish the barrier to entry for new applications, by

  1. Judicious use of web technologies
  1. Heavy use of automation

Basically, we want a user or research group to propose an application that they want, _literally by sending a pull request_, have some fancy robots take over from there, then a few days later have the user submitting jobs to the grid with their new shiny.

Delivering applications should be a simple as pushing a few commits to a repo; executing that application in a workflow should be as simple as writing a script that says not much more than


        # Add the AAROC deployed apps module
        module add deploy
        # Add myApp and dependencies
        module add myApp
        # SCIENCE !
        . . . my_workflow . . .


# Step 4 - Profit !

<figure>
<img src="http://acmedia.alaskacommons.com/wp-content/uploads/2012/10/UnderpantsGnomesPlan.jpg">
<figcaption>This is <em>most</em> likely attributable to a <a href="http://www.southparkstudios.com/clips/151040/the-underpants-business">South Park episode</a>, but since this is the internet, who knows anymore !</figcaption>
</figure>
Unless you've been living on Mars until just this moment, or are reading this blog post from the [New Horizons](https://www.nasa.gov/mission_pages/newhorizons/main/) probe, you probably know the [Profit !!! meme](http://knowyourmeme.com/memes/profit).

 If not[^HiMars], here's how it works :  

> You have a goal, and you have a vague idea of how to reach it. The first two steps are easy, then some magic happens, finally, PROFIT !!!

I propose that this is usually the case for researchers - they *know* their application better than the infrastructure operators do, and they usually know how to build it and execute it. The infrastructure operators, however, know how to deliver applications to their users - they might have some local customisations at their sites for how they deal with users, parallelism, file systems etc. In this analogy, the user[^UserResearcher] would know the first two steps of their goal-oriented path :

  1. Compile the application against it's respective dependencies
  1. Check that the application executes correctly

while the operator knows the other side of that model, and can ensure that the application is in the right path with the right permissions, etc.

# A bit of background.

Before we get into the steps that a user would need  to take *right now* to deploy their application to the grid, let's take a brief look into the past.

## No-one said it would be easy...

Getting applications onto the infrastructure was one of the main blocking aspects of SAGrid, and most national distributed computing platforms. Without being able to run their code or workflows in a reasonable time, users and entire communities get discouraged and - in some cases - turn to home-brew solutions. However, the model we had in place assumed that there was an impermeable barrier between the user and the infrastructure, with the *"Software Manager"* playing the role of "priest", interceding for the user to the infrastructure's operations team. Essentially, this created a huge bottleneck, because special jobs had to be created, to be submitted site-by-site, in order to install the applications. What is more, functional checks were rarely made on the deployed applications, and updates to the packages were not guaranteed - they needed to be manually updated.

## No-one said it should be this hard

Wow, looking back that was quite *dumb*, for lack of a better word. Yes, we had nothing else to work with, and yes, *everyone else was doing it*, but that doesn't mean we can't make it less stupid ! We wanted to re-design the process so that it was more _user driven_ and _parallel_ than previously, with as few as possible bottlenecks. Essentially, we wanted to make the impermeable wall permeable, but brokering some trust between user and operator. All the user had to do was show the operator how  the application had to be built; all the operator had to do was ensure that trusted applications were always available. Since most of the support effort previously was spent on ensuring that applications were compiled and linked correctly, and tracking down runtime errors, we wanted to eliminate or drastically reduce the occurence of these. The operators would be saying "ok, prove to me that you can execute in this environment witout doing bad things".

# The Two-Way Mirror

What if all the testing, checking and execution could be automated in some way ? A tireless robot could realistically test all desired configurations of an application, and could do so in an unbiased way - such that both the operator and the user could refer to the same build and say "yep, looks good". This is a kind of "two-way mirror", where the user can make verifiable statements about the application, and the operator can make verifiable statements about whether that application will execute on the remote side of the infrastructure[^BasicallyWN]. In the middle there is some opaqueness to both sides, but there is enough transparency to engender trust.

<figure>
<img src="{{site_url}}/images/code-rade-jenkins-magic.png">
<figcaption>The jenkins magic</figcaption>
</figure>


This is the basis of the trust brokerage and we've implemented it with [Jenkins](http://jenkins-ci.org). The details of the Continuous Integration setup for AAROC have been described at various previous posts in this blog and other slide decks, and here we want to focus on the user side of the process. What does a user have to do, step-by-step, in order to get their application to a point where it's executable ?

# Your move, user...

Let's start by putting the ball in the user's hand - we expect the user to prepare at least two scripts, and to place them in a change-controlled repository. As a default approach, this repo would be on [Github](https://github.com)[^NotJustGit], containing:

  1. A `README` telling us what the application is and what dependencies it needs
  1. A `build.sh` script which **only** compiles the code and produces binary and library files (this is somtimes trivial, in the case of precompiled code)
  1. A `check-build.sh` script which provides a functional test of the code, as well as creates a modulefile for

## Fork the demo repo

Fork the [My-First-Deploy](https://github.com/SouthAfricaDigitalScience/my-first-deploy) repo to get an idea of what's going on; there's a nice README in there which explains how things work and where to get help.

## Mount the CVMFS repo.

All of the applications that have already been tested are already in the CVMFS repo, which you can easily mount on your laptop or local cluster.

-------
<h3 class="post-info" style="center"><a href="{{site_url }}/cvmfs"><i class="fa fa-arrow-right"></i> Instructions for mounting our CVMFS repositories </a></h3>

--------


We've even got a nice [playbook](https://github.com/AAROC/DevOps/blob/master/Ansible/cvmfs.yml) that you can use to make your machine a CVMFS client :smile:. This will give you direct access (via fuse) to the existing repo, and allow you to build code against the libraries therein.

## Make sure it builds

Your next task is to make the application build on something that you know - something "Linux" that is. Your main aim is to prove to the operators that the application will run, and they are operating a CentOS-based infrastructure. Some sites deploy Debian worker nodes too, which is why we have the Debian build slave - so basically if you can write a script that will compile your application against the libraries in CVMFS (and **only** those), then it will pass the first phase of testing. At this point, you can send a pull request and we can create the job to test the code on Jenkins. The script should be called `build.sh` for conventional reasons.

***From here on out, every commit will trigger a Jenkins build***

## Make sure it runs

Once you've made it compile, the next step is to prove that it will not give runtime errors. This means that a modulefile needs to be created for the application and a short script, by convention called `check-build.sh` is executed to load the modulefile for the applicaiton and execute functional tests. These tests have to be provided by you, the requestor, since you're the expert after all !

# Green Lights ! Ansible ! Transaction !

Once the `check-build` phase has successfully completed, a manual promotion is needed. We want this to be one of the few human steps to be made in the workflow, and we have to maintain some form of human interaction, mostly for quality and accountability reasons. Once a check has been made on the artifact, and perhaps a few messages have been exchanged between developer and expert, the application can be pulled into the `dev` repository.

This involves putting the CVMFS repo into a "transaction" - a write-enabled mode in which updates of the repo can be made - and publishing a new version of the repo. All of this happens "behind the curtains", so to speak, from the user's point of view. All that they should see is a message somewhere that says something like

> A new version of the repository has been published in the `dev` repository -
> Changelog: "New application xyz added after successful build, requested by so-and-so"

## Real-world testing

Now, the application is out there "in the wild" - albeit in a testing repository. Certain sites, and the user themself can test the application in a wider sense than the narrow infrastructure-focussed tests that Jenkins runs. After a brief period of testing, and consensus from the production sites, we can move the application into the production repository.

This intermediate step can of course be considered optional, and skipping it could speed up deployment in most cases, but it is useful to have it in the workflow, to ensure that sites have informed consensus on what they are executing. Since the repo is mounted permanently, no action is taken on the site operator's behalf in order to deliver the application - **this is a feature**.

# Go wild ! :tada:

So, at this point, the application is _executable_ out there in the world. All we need to do is keep track of who is mounting the repo - which is usually published in the site-BDII. If updates to the application are made, they are user-triggered, and the operations team is consistently kept in the loop thanks to the continuous integration system. New versions of the application can be developed, and continuously tested, until arriving again at that most beautiful of all sights :  ![all green]({{site_url}}/images/passing.svg)

Continuous delivery - that's where we want to be.

# Bonus points

Bonus points to anyone who can mention the songs referred to in this post in the comments below.

# References and Footnotes

[^HiMars]: If you really have been living on Mars, well done, you are what humanity has been searching for, for millenia. Please make yourself known to one of our friendly visiting robots !
[^UserResearcher]: I'm using "user" and "researcher" interchangeably throughout this article - what I mean here is "the entity who knows and uses the application". These may be different people, but the system is set up to handle this - the important point is that they are *different* from the operators.
[^BasicallyWN]: What we mean here by "remote side of the infrastructure" is basically "a worker node". This is being simulated as a specific execution environment (shell) on the build slaves, which is very similar to a worker-node, having all of the middleware and dependencies that a real worker node would have (and no more), but the "remote side of the infrastructure" can also be considered something that is outside of the authentication realm - a user interface or personal laptop for example. Since we have the possibility to simluate many different environments with Jenkins, simultaneously, we can acount for almost any site configuration. Currently, there are only SL6 and Ubuntu 1404 build slaves.
[^NotJustGit]: We really like Github because of the nice API it provides developers with, but in principle this could be any svn or git repo. Basically, we just need to know when changes are pushed to the repo, so that Jenkins can trigger the job.
