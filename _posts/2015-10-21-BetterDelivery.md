---
layout: post
title:  'A better testing and delivery strategy'
description: 'The time has come to put on our Big Boy CI boots'
headline: 'The time has come to put on our Big Boy CI boots'
category: blog
tags: [blog, CODE-RADE, sitrep]
image:
  feature: tumblr_mw87ofGfHW1sfie3io1_1280.jpg
  attribution: "Image courtesy of New Old Stock - http://nos.twnsnd.co/image/69699793933"
comments: false
mathjax: false
discourse: true
---

TL;DR - We've been doing things wrong all this time. Time to do them right.

-------

# Getting serious about workflow

When we set out on this project all that time ago[^Depressing], the workflow was simple - write the scripts necessary to build any application, and create a module file for it, then install everything in a single repository and ship it with [CVMFS](http://cernvm.cern.ch/portal/filesystem). The change control would be done by [Github](https://github.com/), builds would be done by [Jenkins](http://www.jenkins-ci.org). We want these apps to _just run_ on grid, standalone HPC and cloud sites, which would be running one of a limited set of targets. The theory went that we'd build for these targets[^targets] and then shove them into CVMFS along with their module files.

# Things go wrong

As we started tinkering with the system and seeing where it could go, certain implementation decisions were lost to time. We originally discussed using a kind of [Domain-Specific-Language](https://en.wikipedia.org/wiki/Domain-specific_language) - very similar to what we subsequently discovered is done by [EasyBuild](https://hpcugent.github.io/easybuild/) with their [EasyConfig](https://github.com/hpcugent/easybuild-easyconfigs). Alas, we're not as awesome as we could be given infinite resources, so we went with the general rule of separating out specific stages of the build into simple scripts, that Jenkins would execute sequentially.

This is very far from being a "standard", nobody in their right mind would call it an "API", but we wanted to provide the means for new contributors to collaborate easily, and a common workflow like this was needed. However, the first thing we did after making this discussion  was ... break it.

<figure>
<video id="gif-mp4" poster="https://media.giphy.com/media/O9IvntBQsqSB2/200_s.gif" style="margin:0 auto ;padding:0 display: block;" loop="" height="277" width="500">
<source src="http://media.giphy.com/media/O9IvntBQsqSB2/giphy.mp4" type="video/mp4">
            Your browser does not support the mp4 video codec.
</video>
<figcaption>Is this why we can't have nice things?</figcaption>
</figure>

The simple workflow :

  1. Build the application (using `build.sh`)
  1. Test the application (using `check-build.sh`)
  1. Install the application in the right place in the repository
  1. Write the application modulefile and put that in the repository
  1. Initiate a transaction and publish a new version of the repository

went out of the window, because clumsy things were done in our initial enthusiasm of getting things going.
This meant that we have populated a nice big CMVFS repository (well, two actually) with broken apps.
The libraries and applications are all properly built, but module files were only written for the build and test environment, but not for the repository environment in which they would actually be used out there in the real world.

We're at the point now, where we need to focus more on quality and trustworthiness, which means *usability*. This post describes a few tweaks we're making to `CODE-RADE` in order to make the the upcoming release usable.


# We can actually have nice things.

First of all, we need to keep the jobs tidy and consistent.
*"Tidy"* means separating out tasks into individual scripts, and not dumping various stages of integration into the same script.
*"Consistent"* means checking that all of the jobs are doing something similar and weeding out differences between their implementations as far as possible.

## Cleaner build scripts, cleaner integration statuses

Currently there in general two build scripts.
These are executed by Jenkins at each "build stage".
The theory is that if something fails to build, it should not be installed, no modulefile should be created and it should not make it to the repo. Duh.
Jenkins does this by having separate build stages, and subsequent stages are triggered by the status of the preceding ones.
In this way you have a kind of "Build Flow". Not the *actual* [Build Flow](https://wiki.jenkins-ci.org/display/JENKINS/Build+Flow+Plugin) that Jenkins already has with it's own DSL but nonetheless a logical, serial workflow.
We currently have the compilation phase in a single script (`build.sh`), but the following steps are all bundled into one - `check-build.sh`.
So, the first thing we have to do is increase the number of build steps and increase the number of scripts, so that we can have finer-grained control over what stage application integration is in.
Also, certain stages in the build flow should trigger other events outside of the application build flow - for example, if a job compiles and is tested properly, it should be installed in the build environment, with appropriate module file (`ci/<app>/<version>` - with application root at `/apprepo`).
It should then _also_ be installed in the deploy environment with corresponding modulefile (`deploy/<app>/<version>` with application root at `/cvmfs`).
At this point, the transaction can be triggered - at least on `devrepo` and we'd have a _proper_ continuous integration.

All we need to do this is to change the prefix of the `make install` bit.

## Better separation of staging and integration

The integration area `/apprepo` is used by the jobs to find and compile against their dependencies, however, on the build slaves we don't have a staging area for creating the artifacts that have to get shipped to the CVMFS repository[^Fanie]. One thing we could do is start building tarball *"artifacts"* and keep them with the job number associated to the file in some way[^filename]. This would allow us to keep a clean CVMFS repository, with direct links between the applications in it and the build number that created them.

There is a tradeoff to be made here, though -

  * It is very efficient to `rsync` individual files between the build slaves and the CVMFS repository, since only the differences will be shipped. If tarballs were to be shipped, we would probably lose this efficiency.
  * CVMFS uses AUFS, and calculates differences in files in order to generate the new filesystem. These differences may be lost otherwise.

So, perhaps the right thing to do is to do `rsync` for `devrepo` and `tarball` for `apprepo`.

# We're late already !

These have been some thoughts on improving the usability and scalability of project CODE-RADE. It will take a while to implment, and in the meantime, we need to publish the first release - Foundation Release 1.
This was scheduled for **3 weeks ago** :scream: so it's time to get *something* out there.

Peace out.

------

# Footnotes and References

[^Depressing]: It's a bit depressing to think that it started 2 years ago and only now we're getting to something that might be called ready for public consumption.
[^targets]: The targets were a combination of operating system, site architecture and a tag on the kind of site - `optimised`, `generic`, `gpgpu`, _etc_.
[^Fanie]: This *was* done once upon a time early on, but was discontinued for other reasons.
[^jobnumber]:
