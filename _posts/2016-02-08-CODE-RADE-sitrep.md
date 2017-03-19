---
layout: post
title:  'CODE-RADE sitrep Feb 2016'
description: 'CODE-RADE Situation Report for February 2016'
category: blog
tags: [blog, CODE-RADE]
image:
  feature: photo-1453814279372-783dc5b638ae.jpeg
  attribution: "Image courtesy of New Old Stock - http://nos.twnsnd.co/image/69699793933"
comments: false
mathjax: false
discourse: true
---

# TL;DR - Two releases coming up : Where we at ?

[A recent post]({{ site_url }}/blog/2016/01/02/CODE-RADE-roadmap/) discussed the roadmap for the CODE-RADE project, and put forward [two important dates for releases](https://github.com/AAROC/CODE-RADE/milestones) :

  * [Infrastructure Foundation Release 2](https://github.com/AAROC/CODE-RADE/milestones/Infrastructure%20foundation%20release%202) - ***01/03/2016***
  * [Public Release 1](https://github.com/AAROC/CODE-RADE/milestones/CODE-RADE%20Public%20Release%201) - ***29/04/2016***

Here's a quick update of where we're at[^Public]

#  Things in <img src="{{ site_url}}/images/build-failing.svg">


## Abinit

Abinit is configured to build for:

  * OS : **u1404**, **sl6**
  * VERSION : **7.10.5**
  * GCC Version : **4.9.2**, **5.1.0**

All of the dependencies of Abinit are passing :

  * fftw3
  * gsl
  * lapack
  * netcdf

This is a good place to be, but abinit itself is failing on all targets due to the FFTW3 dependency. The error is described in [#4](https://github.com/SouthAfricaDigitalScience/abinit-deploy/issues/4).

**TODO** - check what kind of FFT Abinit wants.

## GADGET-2

GADGET is configured to be compiled with

  * fftw2
  * openmpi
  * gsl
  * hdf5

The job is not yet complete, since the `check-build.sh` and `deploy.sh` scripts are missing. There seems to be some misconfiguration with the makefiles, which need to be checked.

## GROMACS

Gromacs is configured for the targets:

  * VERSION : **5.1.1**
  * GCC Version : **4.9.2**, **5.1.0**
  * OpenMPI version : **1.8.1**, **1.8.8**

Gromacs depends on

  * boost
  * fftw3
  * lapack

as well as the aforementioned GCC and OpenMPI. GROMACS is currently suffering from the wrong FFTW configuration. The build is configured as  :

{% highlight shell %}

cmake ../ \
-G"Unix Makefiles" \
-DCMAKE_C_COMPILER=mpicc \
-DCMAKE_CXX_COMPILER=mpicxx \
-DGMX_X11=OFF \
-DGMX_FFT_LIBRARY=fftw3 \
-DGMX_DOUBLE=OFF \
-DGMX_GPU=OFF \
-DGMX_OPENMP=ON \
-DGMX_MPI=ON \
-DGMX_EXTERNAL_BLAS=on \
-DGMX_BUILD_MDRUN_ONLY=ON \
-DCMAKE_PREFIX_PATH=${BOOST_DIR}/boost;${LAPACK_DIR};${FFTW_DIR};${OPENMPI_DIR} \
-DREGRESSIONTEST_DOWNLOAD=ON \
-DCMAKE_INSTALL_PREFIX=${SOFT_DIR}/${VERSION}-gcc-${GCC_VERSION}-mpi-${OPENMPI_VERSION}

{% endhighlight %}

However, this is failing with the following error message  :


> -- pkg-config could not detect fftw3f, trying generic detection
> Could not find fftw3f library named libfftw3f, please specify its location in CMAKE_PREFIX_PATH or FFTWF_LIBRARY
> by hand (e.g. -DFFTWF_LIBRARY='/path/to/libfftw3f.so')
> CMake Error at cmake/gmxManageFFTLibraries.cmake:81 (MESSAGE):

> Cannot find FFTW 3 (with correct precision - libfftw3f for mixed-precision
> GROMACS or libfftw3 for double-precision GROMACS).  Either choose the right
> precision, choose another FFT(W) library (-DGMX_FFT_LIBRARY), enable the
> advanced option to let GROMACS build FFTW 3 for you
> (-DGMX_BUILD_OWN_FFTW=ON), or use the really slow GROMACS built-in fftpack
> library (-DGMX_FFT_LIBRARY=fftpack).


The error doesn't seem to be in `CMAKE_PREFIX_PATH`, so it is likely in one of the FFTW variables.

**TODO** : Find out how to specify the correct FFTW3 configuration

**Update** :  10/02 - fixed in  [d8e48ec5](https://github.com/SouthAfricaDigitalScience/gromacs-deploy/commit/d8e48ec5b480af486d95e3daaf2270a97bee9636), however GROMACS in the repo only contains `mdp_mpi` and none of the other executables. Need to revisit the configuration.

## Python

Python is one of the generic frameworks which is difficult to treat like the other applications in CODE-RADE, because it has it's own package management tools and internal dependency management. It also doesn't usually deal with modules, rather using it's own `virtualenv` to deal with different versions of Python and different modules within it. However, it can still be built from source, and the supporting applications which it uses - `pip`, `easy_install`, *etc* can be added to it. Care should be taken to use the python environment variables properly in order to ensure that the subsequent python modules such as those in the SciPy suite, are installed and delivered correctly.

The current overview of the status of python is :

<figure>
<img src="{{ site_url }}/images/python-build-26-snapshot.png"  />
<figcaption>Snapshot of the status of Python at build 26 - current at the time of writing</figcaption>
</figure>

Python currently depends on

  * bzlib
  * ncurses
  * readline
  * sqlite
  * tcltk
  * zlib-deploy

which are all currently passing.

Python 2.6 and Python 2.7 are failing as follows.

### Python 2.6

Python 2.6 needs setuptools. This is downloaded as part of the build script, but fails immediately with :

{% highlight python %}
Traceback (most recent call last):
  File "setup.py", line 21, in <module>
    exec(init_file.read(), command_ns)
  File "<string>", line 11, in <module>
  File "/var/lib/jenkins/workspace/python-deploy/ARCH/x86_64/GCC_VERSION/4.9.2/NAME/python/OS/u1404/SITE/generic/VERSION/2.6.9/Python-2.6.9/setuptools-18.3.2/setuptools/__init__.py", line 12, in <module>
    from setuptools.extension import Extension
  File "/var/lib/jenkins/workspace/python-deploy/ARCH/x86_64/GCC_VERSION/4.9.2/NAME/python/OS/u1404/SITE/generic/VERSION/2.6.9/Python-2.6.9/setuptools-18.3.2/setuptools/extension.py", line 8, in <module>
    from .dist import _get_unpatched
  File "/var/lib/jenkins/workspace/python-deploy/ARCH/x86_64/GCC_VERSION/4.9.2/NAME/python/OS/u1404/SITE/generic/VERSION/2.6.9/Python-2.6.9/setuptools-18.3.2/setuptools/dist.py", line 16, in <module>
    from setuptools.depends import Require
  File "/var/lib/jenkins/workspace/python-deploy/ARCH/x86_64/GCC_VERSION/4.9.2/NAME/python/OS/u1404/SITE/generic/VERSION/2.6.9/Python-2.6.9/setuptools-18.3.2/setuptools/depends.py", line 6, in <module>
    from setuptools import compat
  File "/var/lib/jenkins/workspace/python-deploy/ARCH/x86_64/GCC_VERSION/4.9.2/NAME/python/OS/u1404/SITE/generic/VERSION/2.6.9/Python-2.6.9/setuptools-18.3.2/setuptools/compat.py", line 28, in <module>
    import urllib2
  File "/apprepo/generic/u1404/x86_64/python/2.6.9-gcc-4.9.2/lib/python2.6/urllib2.py", line 93, in <module>
    import hashlib
  File "/apprepo/generic/u1404/x86_64/python/2.6.9-gcc-4.9.2/lib/python2.6/hashlib.py", line 138, in <module>
    sha224 = __get_builtin_constructor('sha224')
  File "/apprepo/generic/u1404/x86_64/python/2.6.9-gcc-4.9.2/lib/python2.6/hashlib.py", line 66, in __get_builtin_constructor
    import _sha256
ImportError: No module named _sha256
{% endhighlight %}

It seems that Python has not built the sha256 library.

## Python 2.7

Python 2.7 seems to have passed `build` and `check-build`, but when cleaning the build directory at the start of `deploy` we get the following error :

{% highlight shell %}
+ ./deploy-2.7.11.sh
rm: cannot remove `build/lib.linux-x86_64-2.7': Directory not empty
{% endhighlight %}

This is thrown by the lines

{% highlight shell %}
cd ${WORKSPACE}/Python-${VERSION}/build-${BUILD_NUMBER}
rm -rf *
{% endhighlight %}

This could easily be circumvented by a quick hack, but the origin of the problem is not understoo _(yet)_


## Quantum Espresso

Quantum Espresso is having issues compiling against the LAPACK libraries provided.


## WRF

The Weather Research and Forecasting model is very widely used in meteorology and climatology. It depends on

  * hdf5 (compiled with MPI)
  * jasper
  * mpich
  * netcdf (compiled with MPI)

all of which are passing.

The project files are not yet ready, so this build is failing to find the scripts. Although the build has been tested locally using the artifacts in `fastrepo`, this has only been done by hand and the scripts have not yet been committed to the repo.

## The rest

There are [several applications](http://www.africa-grid.org/blog/2016/01/02/CODE-RADE-roadmap/) which have been proposed for the Public Release. Apart from those described above, we have the list below. A short summary of the status of each is given.

<div class="table-responsive">
<table class="table">
<thead>
  <tr>
    <td>Name</td>
    <td>Dependencies</td>
    <td>Comment</td>
  </tr>
</thead>
<tbody>
  <tr>
    <td>GAMESS</td>
    <td>HDF5</td>
    <td class="text-info">Dependencies all fulfilled,  but not tested locally</td>
  </tr>
  <tr>
    <td>Repast Symphony</td>
    <td>Java</td>
    <td class="text-info">Dependencies all fulfilled,  but not tested locally</td>
  </tr>
  <tr>
    <td>ABySS</td>
    <td class="text-info">BOOST, Sqlite, SparseHash</td>
    <td class="text-warning">SparseHash is not yet in Foundation Release, but is WIP.</td>
  </tr>
  <tr>
    <td>OpenFOAM</td>
    <td>BOOST, OpenMPI, gnuplot, readline, ncurses</td>
    <td class="text-warning">gnuplot is not yet in Foundation Release.. The OpenFOAM job and repo are present, but only the build script is prepared.</td>
  </tr>
  <tr>
    <td>AutoDock</td>
    <td>None, apparently</td>
    <td class="text-success">Low hanging fruit ? Need to add the scripts to the repo and create the Jenkins job.</td>
  </tr>
  <tr>
    <td>Velvet</td>
    <td>OpenMP</td>
    <td class="text-success">Low hanging fruit ? Need to add the scripts to the repo and create the Jenkins job.</td>
  </tr>
  <tr>
    <td>OASES</td>
    <td>OpenMP, zlib, Velvet</td>
    <td class="text-success">Low hanging fruit ? Need to add the scripts to the repo and create the Jenkins job.</td>
  </tr>
  <tr>
    <td>WEKA</td>
    <td>Java JDK</td>
    <td class="text-warning">JDK has been added with build 113 of fastrepo and WEKA has been tested manually. Compilation is not clear yet.</td>
  </tr>
  <tr>
    <td>PLink</td>
    <td>zlib (uses it's own compiled version), LAPACK</td>
    <td class="text-info">Manual tests have passed.</td>
  </tr>
  <tr>
    <td>Pythia8</td>
    <td>Several CLHEP and CERN libraries necessary</td>
    <td class="text-warning">This one will take a while still.</td>
  </tr>
  <tr>
    <td>FreeFem++</td>
    <td class="text-info">GSL, OpenMPI/MPICH, PETSc, LAPACK, BLAS, SuiteSparse, FFTW3, HDF5. </td>
    <td class="text-warning">Most of these can be downloaded by the compilation scripts proivded by the package, but that would be a bit couter to the CODE-RADE philosophy.</td>
  </tr>
  <tr>
    <td>CosmoMC</td>
    <td>pmclib, CAMB, GSL, FFTW3, LAPACK, WMAP, fitsio</td>
    <td class="text-warning">WMAP, pmclib, CAMB and WMAP are missing. The rest have been integrated. CAMB needs HealPix and Fisher. Work has started on Healpix</td>
  </tr>
  <tr>
    <td>Gadget 2</td>
    <td>FFTW2, GSL, HDF5</td>
    <td class="text-info">Work has started, the repo has been created as well as the job. Check and deploy scripts are still to be committed. FFWT2 needs to be compiled with MPICH, it is currently only compiled with OpenMPI</td>
  </tr>
  <tr>
    <td>HTK</td>
    <td>none</td>
    <td class="text-success">Low hanging fruit ? Need to add the scripts to the repo and create the Jenkins job.</td>
  </tr>
  <tr>
    <td>MITML</td>
    <td class="text-success">none</td>
    <td>Low hanging fruit ? Need to add the scripts to the repo and create the Jenkins job.</td>
  </tr>
  <tr>
    <td>GAMA-Platform</td>
    <td>Java JDK</td>
    <td class="text-warning">JDK has been added with build 113 of fastrepo and Gama has been tested manually. Compilation is not clear yet.</td>
  </tr>
  <tr>
    <td>IMA-2</td>
    <td>none</td>
    <td class="text-success">Low hanging fruit ? Need to add the scripts to the repo and create the Jenkins job.</td>
  </tr>
  </tbody>
</table>
</div>

# Next steps.

The applications which have been described as low-hanging fruit are going to be added over the next few days. Significant work needs to be done for a few of the other ones, and lower-lying dependencies need to be added and compiled for different targets. We look forward to having some contribution from those interested, and using some of these as example applications in the upcoming [Sci-GaIA winter school](http://www.sci-gaia.eu/winter-school).

For now, let's keep <img src="{{ site_url }}/images/build-passing.svg">
<div class="row">
<div class="col-md-4">
</div>
<div classs="col-md=-4">
<video id="gif-mp4" poster="https://media.giphy.com/media/9G52mAJTInGVy/200_s.gif" style="margin:0;padding:0" autoplay="" loop="" height="289" width="700">
            <source src="https://media.giphy.com/media/9G52mAJTInGVy/giphy.mp4" type="video/mp4">
            Your browser does not support the mp4 video codec.
</video>
</div>
<div class="col-md-4">
</div>
</div>

# Footnotes and References

[^Public]: We'll report only on the user applications in the Public Release
