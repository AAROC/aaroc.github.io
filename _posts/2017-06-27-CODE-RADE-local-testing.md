---
layout: post
title: "You can test (CODE-RADE) if you want to..."
description: "The one where we do the safety dance"
headline: "The one where we do the safety dance"
category: blog
tags: [CODE-RADE, testing, containers]
image:
  feature: safety.png
  attribution: >
    <a style="background-color:black;color:white;text-decoration:none;padding:4px 6px;font-family:-apple-system, BlinkMacSystemFont, &quot;San Francisco&quot;, &quot;Helvetica Neue&quot;, Helvetica, Ubuntu, Roboto, Noto, &quot;Segoe UI&quot;, Arial, sans-serif;font-size:12px;font-weight:bold;line-height:1.2;display:inline-block;border-radius:3px;" href="http://unsplash.com/@dsiglin?utm_medium=referral&amp;utm_campaign=photographer-credit&amp;utm_content=creditBadge" target="_blank" rel="noopener noreferrer" title="Download free do whatever you want high-resolution photos from David Siglin"><span style="display:inline-block;padding:2px 3px;"><svg xmlns="http://www.w3.org/2000/svg" style="height:12px;width:auto;position:relative;vertical-align:middle;top:-1px;fill:white;" viewBox="0 0 32 32"><title></title><path d="M20.8 18.1c0 2.7-2.2 4.8-4.8 4.8s-4.8-2.1-4.8-4.8c0-2.7 2.2-4.8 4.8-4.8 2.7.1 4.8 2.2 4.8 4.8zm11.2-7.4v14.9c0 2.3-1.9 4.3-4.3 4.3h-23.4c-2.4 0-4.3-1.9-4.3-4.3v-15c0-2.3 1.9-4.3 4.3-4.3h3.7l.8-2.3c.4-1.1 1.7-2 2.9-2h8.6c1.2 0 2.5.9 2.9 2l.8 2.4h3.7c2.4 0 4.3 1.9 4.3 4.3zm-8.6 7.5c0-4.1-3.3-7.5-7.5-7.5-4.1 0-7.5 3.4-7.5 7.5s3.3 7.5 7.5 7.5c4.2-.1 7.5-3.4 7.5-7.5z"></path></svg></span><span style="display:inline-block;padding:2px 3px;">David Siglin</span></a>
comments: false
mathjax: true
discourse: true
---

# TL;DR - You can test if you want to, you can leave your bugs behind

So, you're working on an application that wants to get included in the CODE-RADE repository, but for some reason, it's failing in CI.
Let's take the [R language](https://www.r-project.org/) for example.
[This project](https://ci.sagrid.ac.za/job/rlang-deploy/) has a slew of dependencies, some of them optional, such as [java](https://ci.sagrid.ac.za/job/java-openjdk-deploy/), [lapack](https://ci.sagrid.ac.za/job/lapack-deploy/),  [openblas](https://ci.sagrid.ac.za/job/openblas-deploy/), [pcre2](https://ci.sagrid.ac.za/job/pcre2-deploy/), [readline](https://ci.sagrid.ac.za/job/readline-deploy/) and  [xz](https://ci.sagrid.ac.za/job/xz-deploy/)

It is going to be needed soon for the [CODATA/RDA DataScience School](http://indico.ictp.it/event/7974/), but the project is currently [![Build Status](https://ci.sagrid.ac.za/buildStatus/icon?job=rlang-deploy&build=20)](https://ci.sagrid.ac.za/job/rlang-deploy/20/)
So, you say "shucks, I can fix that !" and set about preparing your pull request to [the repository](https://github.com/SouthAfricaDigitalScience/rlang-deploy/)

Before you do that though, you want to test your changes... but how to do that ?
This post will shed some light on how to reproduce the testing environment on your laptop or local setup so that you can send pull requests or commits with greater confidence and speed up the CI/CD pipeline.

# CODE-RADE targets

CODE-RADE builds are done in a matrix of **environments**, which define **targets**. These are constructed using 3 axes :

  * `SITE` : a variables describing the site for which the application has been compiled, in some qualitative way. Usually set to `generic`
  * `ARCH` : the CPU architecture of the target. Typically `x86_64`
  * `OS` : the OS of the target. We test for :
    * Ubuntu-14.04
    * Ubuntu-16.10
    * CEntOS-6
    * CEntOS-7

Every application is built for a combination of the size of these dimensions - typically $$1\times 1\times 4 = 4$$.
If different toolchains are used, these add to the dimensions - _e.g._ different compiler versions, MPI implementations, or pythons - the size of  the matrix can grow quite large[^numpy].
In fact, one of the main benefits of using Jenkins in CODE-RADE is to be able to automate the tests across a wide variety of targets, allowing the developer to focus on **writing code** instead of manually running checks.

Sometimes, however, you still need to run a few things manually locally, in order to check whether a proposed fix will actually do the trick.
Perhaps you don't have to run the checks for **all targets**, but just one or two which are representative, or just those nodes which are failing.
In order to do this, however, you need to have access to the **same environment** as is provided on the CI service.

# CODE-RADE containers

Luckily, it is now quite easy to deliver execution environments, by building **Docker containers**.
The CODE-RADE containers are built by [AnsibleContainer](https://docs.ansible.com/ansible-container/) for the specific targets[^ACPlaybooks] and pushed to [quay.io](https://quay.io)[^WhyQuay] :

| OS | Container |
| :----: | :-----: |
| CentOS 6 | [![Docker Repository on Quay](https://quay.io/repository/aaroc/code-rade-build-containers-build-slave-centos6/status "Docker Repository on Quay")](https://quay.io/repository/aaroc/code-rade-build-containers-build-slave-centos6) |
| CentOS 7 | [![Docker Repository on Quay](https://quay.io/repository/aaroc/code-rade-build-containers-build-slave-centos7/status "Docker Repository on Quay")](https://quay.io/repository/aaroc/code-rade-build-containers-build-slave-centos7) |
| Ubuntu 14.04 | [![Docker Repository on Quay](https://quay.io/repository/aaroc/code-rade-build-containers-build-slave-ubuntu1404/status "Docker Repository on Quay")](https://quay.io/repository/aaroc/code-rade-build-containers-build-slave-ubuntu1404) |
| Ubuntu 16.10 | [![Docker Repository on Quay](https://quay.io/repository/aaroc/code-rade-build-containers-build-slave-ubuntu1610/status "Docker Repository on Quay")](https://quay.io/repository/aaroc/code-rade-build-containers-build-slave-ubuntu1610) |

So, you can run these containers on your  local setup and reproduce the CI environment !

# Accessing Dependencies

Of course, the containers **do not contain the build products** they only reproduce the environment - so you need to find some way to include the dependencies in the container when you run the tests.

Luckily for you, you can **just mount** the CVMFS repository from within the container to have access to it.
If it is already mounted on your local setup (of _course_ it is ! why on earth _wouldn't_ it be !?), you can expose the mountpoint as a volume to the container :

{% highlight shell %}
docker run -ti -v /cvmfs:/cvmfs quay.io/aaroc/code-rade-build-containers-build-slave-ubuntu1404 /bin/bash
{% endhighlight %}

Of course, once  you have access to the dependencies, you need to add the modules in order to have them set up in the shell :

{% highlight shell %}
root@2a7757ac74d3:~# . /etc/profile.d/modules.sh
root@2a7757ac74d3:~# export SITE=generic OS=u1404 ARCH=x86_64
root@2a7757ac74d3:~# module use  /cvmfs/code-rade.africa-grid.org/modules/libraries/
root@2a7757ac74d3:~# module use  /cvmfs/code-rade.africa-grid.org/modules/compilers
root@2a7757ac74d3:~# module avail gcc

-------------------------------------------------------------- /cvmfs/code-rade.africa-grid.org/modules/compilers --------------------------------------------------------------
gcc/4.9.2 gcc/4.9.4 gcc/5.4.0 gcc/6.3.0
{% endhighlight %}

Boom, now you have a choice of compilers.

# Back to R

As of at least [build 21](https://ci.sagrid.ac.za/job/rlang-deploy/21/) R is failing. Let's suppose we want to have a stab at fixing it.
First, we get the repository locally :
{% highlight shell %}
git clone https://github.com/SouthAfricaDigitalScience/rlang-deploy.git
{% endhighlight %}
The scripts in the repository explain where to get the source code and how to configure the build.
In the case of R, we have the following dependencies :

{% highlight shell %}
module add  gcc/5.4.0
module add openblas/0.2.15-gcc-5.4.0
module add lapack/3.6.0-gcc-5.4.0
module add jdk/8u66
module add ncurses
module add readline
module add bzip2
module  add xz
{% endhighlight %}

and the build is configured as :

{% highlight shell %}
CFLAGS="${CFLAGS} -I${BZLIB_DIR}/include -I${XZ_DIR}/include" \
LDFLAGS="-L${BZLIB_DIR}/lib -L${XZ_DIR}/lib -llzma" \
../configure \
--build=x86_64-pc-linux-gnu \
--host=x86_64-pc-linux-gnu \
--target=x86_64-pc-linux-gnu \
--prefix=${SOFT_DIR} \
--enable-static \
--enable-shared \
--with-readline=no \
--with-x=no \
--with-blas \
--with-lapack \
--without-recommended-packages
{% endhighlight %}

Taking a look at <a href="https://github.com/SouthAfricaDigitalScience/rlang-deploy/issues/4">the issue <i class="fa fa-github-o"></i></a> or <a href="https://ci.sagrid.ac.za/job/rlang-deploy/ARCH=x86_64,NAME=R,OS=u1404,SITE=generic,VERSION=3.3.0/21/console">the console output</a>, we can see that the problem is linking against PCRE[^pcre] :

{%  highlight shell %}
checking whether PCRE support suffices... configure: error: pcre >= 8.10 library and headers are required
{% endhighlight %}

Seems pretty easy to fix - just include `-L${PCRE_DIR}/lib` in the `LDFLAGS` and `-I${PCRE_DIR}/include` in the `CFLAGS`.

You can try that first in the container.

# Speeding up manual builds

Finally, we would like to be able to run these things with a single command.
Currently, a few manual commands need to be done interactively in order to set up the modules, etc.
This could be improved by having a `build-local.sh` script in the repo which when run just passed the local CVMFS mount as a volume to the container, as well as the local working directory where the `-deploy` repository was cloned.
In this way, one could just run `build-local.sh` without having to do things manually.
Similarly, one could pass environment variables and scripts to the docker run command in order to set up the environment properly...
We'll comment in this at a later stage maybe.

For the meantime, creating an environment in which to interactively test the build could be done with :

{% highlight shell %}
docker run -ti -v /cvmfs:/cvmfs -v pcre-deploy:/workspace quay.io/aaroc/code-rade-build-containers-build-slave-ubuntu1404 /bin/bash build-local.sh
{% endhighlight %}

Debugging just got a whole lot more responsive and more keyboard-slammier :keyboard:

# Footnotes

[^numpy]: The [NumPy](https://ci.sagrid.ac.za/job/numpy-deploy/) job _e.g._ has $$1(\text{ARCH}) \\ \times 1(\text{SITE}) \\ \times 4(\text{OS}) \\ \times 4(\text{PYTHON_VERSION}) \\ \times 3(\text{GCC_VERSION}) \\ \times 4(\text{NUMPY_VERSION}) \\  = 192$$ cells in the matrix. 
[^ACPlaybooks]: Bruce Becker, “AAROC/CODE-RADE-build-containers: CODE-RADE Foundation Release 3 - Build Containers”. Zenodo, 06-May-2017. [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.572275.svg)](https://doi.org/10.5281/zenodo.572275)
[^WhyQuay]: We chose Quay for the added security scanning and data analytics services, over DockerHub.
[^pcre]: Perl Compatible Regular Expressions
