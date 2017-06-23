---
layout: post
title: "It's a hard-link life"
description: 'Investigating some wierdness in the CI/CD pipeline'
headline: "If builds are passing, where's my gcc at ? "
category: blog
tags: [licenses, infrastructure, commons]
image:
  feature: alex-hockett-41555.png
  attribution:
comments: false
mathjax: false
discourse: true
---

Something strange happened a while back - although [GCC builds](https://ci.sagrid.ac.za/job/gcc-deploy/44/) were [![Build Status](https://ci.sagrid.ac.za/buildStatus/icon?job=gcc-deploy&build=44)](https://ci.sagrid.ac.za/job/gcc-deploy/44/) and the repository transaction was working, the actual compilers weren't showing up on the repository.
There just wasn't any `gcc` binary in the usual places.

Now, this is very wierd, because functional tests are run on the compilers before they are shipped - so my suspicion was aroused. The initial investigation pointed to something going wrong in the delivery part rather than the integration part.


Even after re-shipping the build artefacts, this was the case - I triggered the `shipit` job, to synchronise the `gcc` artefacts in the repo, then waited for the transaction complete. --

On my laptop :

{% highlight shell %}

cat /cvmfs/code-rade.africa-grid.org/version
FR3 Build 158 triggered by gcc
...
module  avail gcc

------------------------------------------------------------- /cvmfs/code-rade.africa-grid.org//modules/compilers --------------------------------------------------------------
gcc/4.9.2 gcc/4.9.4 gcc/5.4.0 gcc/6.3.0

becker@serbaggio:~/SAGrid-2.0/hdf5-deploy/netcdf-4.3.2/build$ module  add gcc/6.3.0
becker@serbaggio:~/SAGrid-2.0/hdf5-deploy/netcdf-4.3.2/build$ which gcc
/usr/bin/gcc

becker@serbaggio:~/SAGrid-2.0/hdf5-deploy/netcdf-4.3.2/build$ ls $GCC_DIR/bin
aot-compile  gappletviewer  gcj-dbtool  gcov       gij   gjarsigner  gkeytool       go     gorbd  grmid         gserialver  jcf-dump    rebuild-gcj-db cpp         gc-analyze     gcjh        gcov-tool  gjar  gjavah      gnative2ascii  gofmt  grmic  grmiregistry  gtnameserv  jv-convert

{% endhighlight %}

No gcc !? 🤔

-----

Turns out this was due to a previous hack which we had to include in the [repository transaction step](https://ci.sagrid.ac.za/job/repo%20transaction/) of the pipeline, which removed **hard links**. Previous versions of the CVMFS server could  not handle hard links (at least this was the case when FR3 was built).

Guess what : the GCC binaries are hardlinked into `$GCC_DIR/bin` from various places - so these were getting removed in the course of the repository transaction !

This has now been fixed :
