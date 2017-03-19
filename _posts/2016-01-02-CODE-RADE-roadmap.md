---
layout: post
title:  'CODE-RADE Roadmap'
description: 'When will we have flying cars ?'
category: blog
tags: [blog, CODE-RADE, Release]
image:
  feature: cb174b18a69d470e8fee59a90d5698ba.jpg
  attribution:
comments: false
mathjax: false
discourse: true
---

# TL;DR Most major components are in place, it's time to start expanding

# What is this old-school release business ?

I know, you're probably thinking "Hey ! This was supposed to be a _continuous_ integration project, what's with the whole ***release*** thing ? Aren't *releases* so old school ?". And you know what,you're right, dear reader. Not to say that we're doing this continuous thing _right_, but we have gone to some lengths to do away with the waterfall and be more agile - when builds pass, they really do get shipped, at every pass. What we're talking about here is more about the planning of the _effort_ of the project, and trying to give end users some idea of _when_ components might be ready.
We have organically defined two kinds of releases :

  - **Foundation Releases**: for developers
  - **Public Releases**: for users

The utility of separating these releases is to allow us to provide a stable foundation to users who want to work on their own applications, whilst also providing the possibility to flesh out the core capabilities of the system without impacting on the user-side.

## Continuous and Staged Integration and Delivery.

A few words about how continuous our continuous integration actually is.

### What is tested ?

While we _do_ do continuous integration and delivery of every component of CODE-RADE, this is only true for one of the CVMFS repositories which we provide - <code>fastrepo</code>. Fastrepo is configured to contain every application which passes automated tests. While we _do_ insist that users who propose applications include these tests in their build scripts, there is currently no actual independent check on the build artifacts to see whether they are beningn and actually executable from the repository. There are _impicit_ checks in the sense that if the application needs components which are not in the repository and not available in the execution environment, then builds will fail, but the main point is that we don't actually check that the scripts provided by the user are actually building anything. There is also the technical aspect of the CVMFS repository, since repositories need to be declared "volatile" if they are expected to be changing rapidly.


## Human checks

So, we have a tradeoff between automation and certification, by separating the build artifacts into separate CVMFS repositories. Everything that passes goes into <code>fastrepo</code>, and things that are checked by humans go into the next repo - <code>devrepo</code>. This process requires a recompilation to point the code to the new filesystem root, and we haven't implemented that yet.

The current repository <code>fastrepo</code> is currently the only one with the full set of applications, and is continuously integrated and delivered. We will be implementing staged delivery from Foundation Release 3.

# Foundation Release 2

We have released only one Foundation ([Foundation Release 1]), which contained a basic set of tools necessary to build other tools. Foundation Release 2 will include :

  * further base libraries which are not guaranteed to be available on the execution nodes[^SameVersion]
  * More versions of math libraries such as various versions of, BOOST, LAPACK and BLAS, as well as sparse matrix libraries in SuiteSparse
  * More versions of the GCC compiler and MPI libraries, including MPICH[^OpenMPI].
  * I/O libraries such as HDF5
  * common tools such as gnuplot, octave
  * Python and associated libaries and such as the SciPy suite.

This Foundation Release will allow users to build a wider set of useful applications, thanks to the wider set of libraries which can be used. These applications will be included in the Public Releases.

**Foundation Release 2 is scheduled for 1 March 2016.**

# Public Release 1

Public Releases include the _end-user_ applications. For Public Release 1, these include :

  * [AbInit](http://www.abinit.org)
  * [GAMESS](http://www.msg.ameslab.gov/gamess/)
  * [Repast Symphony](http://repast.sourceforge.net/)
  * [ABySS](http://www.bcgsc.ca/platform/bioinfo/software/abyss)
  * [OpenFOAM](http://www.openfoam.org/)
  * [AutoDock](http://www.openfoam.org/)
  * [Velvet](https://www.ebi.ac.uk/~zerbino/velvet/)
  * [OASES](https://www.ebi.ac.uk/~zerbino/oases/)
  * [GROMACS](http://www.gromacs.org)
  * [WEKA](http://www.cs.waikato.ac.nz/ml/weka/)
  * [WRF](http://www.wrf-model.org)
  * [PLink](http://pngu.mgh.harvard.edu/~purcell/plink/)
  * [HEASoft](http://heasarc.nasa.gov/lheasoft/)
  * [Pythia8](http://home.thep.lu.se/~torbjorn/Pythia.html)
  * [freefem++](http://www.freefem.org/ff++/)
  * [CosmoMC](http://cosmologist.info/cosmomc/)
  * [Gadget-2](http://wwwmpa.mpa-garching.mpg.de/gadget/)
  * [HTK](http://htk.eng.cam.ac.uk/)
  * [MITLM](https://github.com/mit-nlp/mitlm)
  * [quantum-espresso](http://www.quantum-espresso.org/)
  * [GAMA-platform](https://github.com/gama-platform/gama/wiki)
  * [IMA2-deploy](https://bio.cst.temple.edu/~hey/software/software.htm)

The full list of applications and their state can be seen at [africa-grid.org/applications](http://www.africa-grid.org/applications)

**Public Release 1 is expected on 30 April 2015**.

# Collaborating.

The CODE-RADE project has been designed with the lowest possible barrier to entry and contrbutions and collaborators are very welcome. There are several ways in which you could contribute or collaborate :

## Requesting new applications

If you would like to have an application included in CODE-RADE, simply [make a request](https://github.com/AAROC/CODE-RADE/issues/new?title=%22Application%20Request%22&labels=request). The collaborators will evaluate the request and decide on which release (and thus priority) it should be assigned to, based on the dependencies and complexity of the application.

## Bring your own application

If you are entirely responsible for your application, we can create the job in Jenkins and allow you to independently develop the scripts which build and deploy it. Self-service !
<div class="row">
<div class="col-md-4"></div>
<div class="col-md-4"><iframe src="//giphy.com/embed/O1xeZ4AgSaNBS?html5=true" width="480" height="337" frameBorder="0" class="giphy-embed" align="center"  allowFullScreen ></iframe><p><a href="http://giphy.com/gifs/funny-cute-O1xeZ4AgSaNBS"></a></p></div>
<div class="col-md-4"></div>
</div>

## Improve and learn

If you would like to help us improve the system, or individual sub-projects in CODE-RADE, there are many ways to do this. You can adopt an application which is currently failing and help us diagnose build failures. Code review is also a helpful way of improving the quality of the project.


## Request CODE-RADE at your university or lab

If you're interested in using CODE-RADE, why not ask the administrator of your local computing facility to enable it. Adding CODE-RADE to a site is a once-off procedure, since the project is designed to reduce overhead for system administrators. See the [Africa-Grid website](http://www.africa-grid.org/cvmfs/) for instructions.
<div class="row">
<div class="md-col-4"></div>
<div class="md-col-4"><iframe src="//giphy.com/embed/bcR6PlrdQO2je?html5=true" width="480" height="567" frameBorder="0" class="giphy-embed" align="center" allowFullScreen></iframe><p><a href="http://giphy.com/gifs/nosebleed-nosebleeds-korean-bcR6PlrdQO2je"></a></p></div>
<div class="md-col-4"></div>
</div>



# CODE-RADE works Open

Everything in CODE-RADE is Open with a capital O. From the design to the process to the validation, we welcome input and contrbutions from any researcher with an interest in delivering and using high-quality, easy-to-use research applications. Here are some contact points :

<div class="row">
<div class="col-md-1"><i class="fa fa-github fa-3x"></i></div>
<div class="col-md-11"> All the code we use to build applications is in the <a href="https://github.com/AAROC/CODE-RADE/">CODE-RADE</a> repository as submodules. Individual repositories are in the <a href="https://github.com/SouthAfricaDigitalScience">SouthAfricaDigitalScience</a> organisation. However, if you want to work on your own application, you can host your scripts in your own repository on github.</div>
</div>
<div class="row">
<div class="col-md-1">
<img src="{{ site_url}}/images/waffle.png" width="50" class="img-rounded img-responsive" />
</div>
<div class="col-md-11">The CODE-RADE project planning is done on the <a href="https://waffle.io/AAROC/CODE-RADE">Waffle Board</a> which is publicly visibile.</div>
</div>
<div class="row">
<div class="col-md-1">
<img src="{{ site_url }}/images/jenkinslogo.svg" width="50" class="img-rounded img-responsive pull-left" /></div>
<div class="col-md-11"> You can see the details of each build at the <a href="http://ci.sagrid.ac.za">CODE-RADE build server</a> which is publicly visible.
</div>
</div>
<div class="row">
<div class="col-md-1">
<i class="fa fa-comments-o fa-3x"></i></div>
<div class="col-md-11">Discuss the development of the project itself or individual components at the <a href="http://discourse.sci-gaia.eu">African e-Infrastructures Discussion Forum</a>
</div>
</div>


Finally, we will be using CODE-RADE as part of the [Sci-GaIA winter school](http://www.sci-gaia.eu/winter-school/) for application porting to science gateways. In preparation for this, we are working on a short self-paced course in order for those interested in developing for CODE-RADE to understand how the system works and gain the necessary skills to contribute efficiently. The course will be delivered via the [Sci-GaIA online learning platform](http://courses.sci-gaia.eu).

Looking forward to great things

<hr>

# Footnotes and References

[^OpenMPI]: We initially only served OpenMPI, however some applications such as WRF require MPICH explicitly.
[^SameVersion]: These include widely-used, but sometimes absent libraries, such as bzlib, curl, freetype, libpng, sqlite, tcltk, _etc_. In most cases, we build the same version as is by default found in the OS repositories is built, along with the most recent version.
