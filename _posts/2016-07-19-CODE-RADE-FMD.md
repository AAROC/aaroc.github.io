---
layout: post
title: "CODE-RADE : Fermionic Molecular Dynamics"
description: "Care and Feeding of the FMD application"
headline: "So you want to Fermi some molecules, eh ?"
category: blog
tags: [blog, CODE-RADE, projects, FMD]
comments: false
mathjax: false
image:
  feature: fluid.jpg
discourse: true
codrops: false
---

# TL;DR : Getting started with Fermionic Molecular Dynamics

We've recently ported an application from the physical sciences domain used to make nuclear calculations using Fermionic Molecular Dynamics models[^FMD]. The application was requested[^InitialTopic] by [Katharine Henninger](http://discourse.sci-gaia.eu/users/katharinehenninger_f/) from iThemba L.A.B.S.

# Fermionic Molecuar Dynamics in CODE-RADE

[FMD-deploy](http://ci.sagrid.a.za/job/Fermionic-Molecular-Dynamics-deploy) was added to CODE-RADE on [July 4th](http://ci.sagrid.ac.za/job/Fermionic-Molecular-Dynamics-deploy/1/).  After some discussion[^DiscourseTopic]
The application has a pretty simple dependency tree, as seen by the [Jenkins config](http://ci.sagrid.ac.za/job/Fermionic-Molecular-Dynamics-deploy/api/json?pretty=true) :

<!-- {% highlight json %}

"upstreamProjects" : [
    {
      "name" : "OpenMPI",
      "url" : "http://ci.sagrid.ac.za/job/OpenMPI/",
      "color" : "blue"
    },
    {
      "name" : "lapack-deploy",
      "url" : "http://ci.sagrid.ac.za/job/lapack-deploy/",
      "color" : "blue"
    },
    {
      "name" : "ncurses-deploy",
      "url" : "http://ci.sagrid.ac.za/job/ncurses-deploy/",
      "color" : "blue"
    }
  ]

  {% endhighlight %} -->

The dependencies were all passing, so it was just a matter of a few modifications to the source code, [the application was included in the CODE-RADE `fastrepo`](http://discourse.sci-gaia.eu/t/fmd-integration/2158/4?u=brucellino).

# Getting started

:tada: Great ! :tada: so the application is  in the repo and available at the sites - now what ? I've started  work on a few examples to explain how to run the application on the grid. Thes are in the [CODE-RADE FMD examples directory](https://github.com/AAROC/CODE-RADE/tree/master/grid/fmd). I tested these and they give the expected results from a run at ZA-WITS-CORE:

{% highlight bash %}

you are using fastrepo.sagrid.ac.za version
Build 199a
Checking whether you have modules installed
you are using CODE-RADE version Build 199a
Great, seems that modules are here, at /usr/share/Modules
Append CVMFS_DIR to the MODULEPATH environment

------------ /cvmfs/fastrepo.sagrid.ac.za/modules/physical-sciences ------------
FMD/0.1
... reading Interaction from file AV18-UsrgD2000f-v11ls-2.0.int
... reading Parameters from file He4.fmd

initial:	E =  -25.246 MeV

step:   0	E =  -25.246 MeV
step:   1	E =  -12.864 MeV
step:   2	E =  -25.246 MeV
... Ozzz: -0.00000
... writing Parameters to file He4.fmd
... 0.00 minutes computing time used

{% endhighlight %}


Coming soon we'll add some more complicated submission examples and some further discussion on how to use gLibrary to manage the output.

What we'd like to do now is take FMD to the next level and make some MPI runs with more demanding scenarios.

# References and Footnotes

[^InitialTopic]: See [the initial topic](http://discourse.sci-gaia.eu/t/connecting-to-the-sa-grid-facilities-as-a-researcher/2147)
[^DiscourseTopic]: See [the discussion on the initial functional test cases](http://discourse.sci-gaia.eu/t/fermionic-molecular-dynamics/2149)
[^FMD]: See **"Molecular Dynamics for Fermions"**, H. Feldmeier and J. Schnack  _Rev.Mod.Phys.72:655-688,2000_ [doi: 	10.1103/RevModPhys.72.655](http://dx.doi.org/10.1103/RevModPhys.72.655)
