---
layout: post
title: 'Containers for CODE-RADE (Part 1)'
description: 'Part 1'
headline: 'Story of a Dubious Idea'
category: blog
tags: [CODE-RADE, containers, docker, bad ideas]
image:
  feature: bad-idea.jpg
  attribution: "Image courtesy http://www.gratisography.com/"
comments: false
mathjax: false
discourse: true
---

# CODE-RADE Foundation Release 3

Long story short, Foundation Release 3 was mean to "widen" CODE-RADE, by eliminating central points in the design. Foundation Release 2 was based on a Jenkins server with build slaves was limited in several aspects, mainly due to the kind of infrastructure we were using, but also due to the architecture. FR2[^FoundationReleases]

  1. **Build coverage**: Only CentOS-6 and Ubuntu-14.04 operating systems were covered. These were provided as static, standalone virtual machines on a local cluster at UFS. In order to provide wider coverage in terms of target operating systems, we needed to add further VMs - however these would need to be tied to the local cluster, thereby competing with the other activities at the site.
  1. **Geographic coverage**: Adding new resources to the platform required them to be physically located at UFS, where the build slaves mounted the shared storage, and were accessible by the jenkins slave launcher.   
  1. **Technology coverage**: The architeture of CODE-RADE FR2 is tightly bound to the technology used to build it, as well as the artefacts. We specifically needed a more abstract way of expressing build pathways, so that other sites could contirbute continuous integration services, as well as provide other forms of testing services.

## Moving from static to cloudy architecture

The biggest bottleneck of CODE-RADE in FR2 was the central repository of CI artefacts, to which all nodes wrote their builds. This was a NFS-mounted share exported from the jenkins server, which experienced severe performance hits when builds wiht large configuration matrices were invoked. In order to speed up the builds, it was hoped that we could parallelise much of the work, by encapsulating the build into self-contained  environments, which could then be instantiated anywhere.

Another bottleneck was the availability of build slaves. Using statically provisioned build slaves, and a central repository of artefacts, there were severe bottlenecks and large integration times, especially for applications which had large and complex dependency trees. The capability to create build slaves as they were requried, rather than rely on a queue for a single resource, represented a possibility to more efficiently use the available resources. However, a move from static virtual machines of a specific kind of operating system, to a build environment based on containers needed to take into account a few crucial differences between these two environments.

# Differences between virtual machines and containers.

There are three main differences between virtual machines exposing entire operating systems, and linux containers. These differences imply certain choices and nuances in approach.

  1. **Single process**: Linux container should run single processes[^DockerSingleProcess]
  1. **Persistence**: Containers should be ephemeral[^DockerEphemeral].
  1. **Data sharing**: Containers are encapsulated, but we need to re-use artefacts from lower in the dependency tree.

Having speedy builds  means using as many CPU resources as possible, in order to complete the build tasks as fast as possible; typically this means using "make"-level parallelism[^ParMake], although several other means are available, for other build systems, such as Ninja[^ParNinja] and Apache Ant[^ParAnt]. Speeding up the build, almost by definition, means that there will be more than one process.

## Re-use of build artefacts

The ephemeral nature of containers is a benefit to the project, since builds can reliably be performed in clean environments. However, the _result_ of builds - in particular the build artefacts - need to be accessible to subsequent containers. This is one of the key aspects of the platform - atomic components, which can be re-used. This re-use of artefacts is not only necessary during the _integration_ phase, but also during deployment and of course re-usage at sites.

Apparently, ensuring data persistence is nontrivial in the docker world. The first aspect we would need to address seriously, was this. Since this is a topic for a whole other post, we will deal with it in Part 2.

# Footnotes and References

[^FoundationReleases]: We refer to foundation releases with the prefix "FR" and numerical tags (1, 2, 3, etc). Thus Foundation Release 1 is "FR1", Foundation Release 2 is "FR2", _etc_
[^ParMake]: Several technologies are used to build applications, although the most common is <code>make</code>. Speeding up a build usig make is often possible, depending on the resources available, by passing the <code>-j &lt;integer&gt; </code>flag where <code>integer</code>  specifies the level of parallelism requested. See  [GNU Make documentation on parallel builds ](https://www.gnu.org/software/make/manual/make.html#Parallel).

[^ParAnt]: See [Ant documentation](http://ant.apache.org/manual/Tasks/parallel.html)
[^ParNinja]: See [Ninja's comparison to make](https://ninja-build.org/manual.html#_comparison_to_make)
[^DockerSingleProcess]: See [the Docker best-practices guide](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#/run-only-one-process-per-container)
[^DockerEphemeral]: See the [Docker best-practices guide](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#containers-should-be-ephemeral)
