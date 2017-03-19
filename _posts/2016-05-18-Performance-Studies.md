---
layout: post
title:  'Performance studies'
description: 'Initial description of performance studies on the grid'
category: blog
tags: [blog, VO, gLite, grid]
image:
  feature:
  attribution: ""
comments: false
mathjax: false
discourse: true
---

# TL;DR

We started to run some real-world performance studies on the grid. This post details the design of the experiment, as well as  infrastructure and services used.
<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [TL;DR](#tldr)
- [Background](#background)
- [Design of the experiment](#design-of-the-experiment)
- [Platform and services](#platform-and-services)
	- [Computing](#computing)
	- [Data storage](#data-storage)
	- [Coming Soon.](#coming-soon)
- [References and Footnotes](#references-and-footnotes)

<!-- /TOC -->

# Background

A few weeks ago, we were contacted by a student at the [University of the North West](http://www.nwu.ac.za) who was undertaking a study of the relative performance of computing tasks on various architectures, using a series of common applications and data sets. The distributed computing architecture under consideration was indeed our very own AfricaGrid, specifically a sub-set of sites which support the [SAGrid Virtual Organisation](https://voms.sagrid.ac.za:8443/voms/sagrid/configuration/configuration.action).

# Design of the experiment

The experiment we had in mind was to determine the time required to process a set of standard data sets[^PublishedSoon], using two machine-learning applications :

  1. The [Hidden Markhov Toolkit](http://htk.eng.cam.ac.uk/)[^HTK]
  2. the [SVM library](http://www.csie.ntu.edu.tw/~cjlin/libsvm)[^LibSVM]

These applications were integrated into the [CODE-RADE](http://ci.sagrid.ac.za) platform in builds [148](http://ci.sagrid.ac.za/job/repo%20transaction/148/) and [146](http://ci.sagrid.ac.za/job/repo%20transaction/146/) respectively. Sites which supported the SAGrid VO were contacted by the VO manager, in order to see that they correctly mounted the CVMFS repository `fastrepo`[^SeeCVMFSPage]. Once this was done, the applications were available to all submitted jobs.

The processing of the data consisted in several tasks including training models with training data sets and then using them to perform characterisation on other data sets using those models. The questions that we aimed to answer, amongst others were :

  1. Can this processing be done efficiently in a distributed environment ?
  2. If the processing can be parallelised, what is the level of parallelism which gives the best efficiency ?
  3. What overhead is there due to the geographically-distrbuted nature of the platform ?

Typically, these questions were answered quantitatively, by measuring the average amount of time required to perform various tasks in the workflow. Initially these were identified as :

  1. Time taken to stage data from online storage endpoints to the compute facility
  2. Time taken to perform estimation of the SVM "C value"[^CValue]

Since this was conducted in a real-world scenario, where other applications, users and services are vying for the same resources (compute time, network capacity, _etc_ ) as our work, we expect there to be fluctuations in these times. In particular the following aspects are expeccted to impact on the average and shape of the distribution of these timing values :

  1. Whether the site has local online storage - if not, data would have to be staged large distances over SANREN to the compute endpoint.
  2. The performance tuning of the online storage and compute cluster frontend
  3. The make and model of CPU on the compute cluser worker nodes.

#  Platform and services

The platform used consisted of three sites on the South African National Compute Grid, a subset of the Africa-Arabia Regional Operations Centre. These sites where  :

  * **ZA-UJ** : [University of Johannesburg](http://physics.uj.ac.za/cluster)
  * **ZA-WITS-CORE** : [University of the Witwatersrand](http://grid.core.wits.ac.za/).
  * **ZA-CHPC** : [Centre for High-Performance Computing](http://www.chpc.ac.za)

These were selected due to their current state of support for the SAGrid VO. They also are fully certified in the ROC, providing middleware and operational compliance[^EGIOLA]. The OLA stipilates that these sites should have a certain level of operation of a pre-defined set of services. In particular:

> High-Throughput Computing Platform
>   - Grid compute - allows scientists to run computational tasks on high quality IT resources, accessible via a standard interface and supporting authentication/authorisation based on a membership within a virtual organisation.
>   - Grid storage - allows files to be stored in and retrieved from high quality IT resources, accessible via a standard interface and supporting authentication/authorisation based on a membership within a virtual organisation.

These services are published by the sites, via the site BDII in the GLUE Schema[^GLUE12]. Using the default top-level information index for the ROC[^top-bdii], the expected resources computing resources are :

<table class="table">
<tbody>
<tr>
  <th> Site</th><th> Logical CPUs </th><th> CPU Vendor</th><th>Clock Speed</th><th>SMP Size</th>
</tr>
<tr>
<td>ZA-WITS-CORE</td><td> 280 </td><td> Intel </td><td> 1900 </td><td> 13 </td>
</tr>
<tr>
<td> ZA-UJ </td><td> 2018 </td><td> AMD </td><td> 2600 </td><td> 8 </td></tr>
<tr>
<td> ZA-CHPC </td><td> 4032 </td><td> Intel </td><td> 2800 </td><td> 48 </td></tr>
</tbody>
</table>


## Computing

The computing services in use at the sites is the CREAM-CE[^CREAMPaper][^CREAMPaper2], which is part of the [Unified Middleware Distribution](http://repository.egi.eu/)[^UMD]. These provide endpoints for job requests to be submitted to. The job requests were written in the [JDL](https://edms.cern.ch/file/590869/1/WMS-JDL.pdf) language, based on the Condor ClassAds. Job descriptions were written, as well as scripts which would set up the environment and execute the applications in the desired way and were published in the "CODE-RADE LibSVM release"[^CODE-RADElibsvm]. Workflows were submitted directly to CREAM interfaces using the command line `glite-ce-job-submit` tool. Authentication and authorisation was done by personal x.509 certificate and VOMS-signed proxies of that certificate.

## Data storage

Data storage used during the study refers to protected online storage provided to the VO by the sites. Due to the high usage of storage by the big WLCG VOs (ATLAS and ALICE), capacity for smaller user communities is limited in South Africa. The services providing the online storage capability are UMD Disk Pool Managers (DPM)[^DPM] exposing various transfer interfaces, such as SRM and GridFTP. The capacity (total and available) of these endpoints as published by their sites is  shown in table below:

<table class="table" align="center">
<tbody>
<tr><th> Site </th><th>Total Online Storage (GB)</th><th> Available Online Storage (GB) </th></tr>
<tr><td>ZA-UJ</td><td> 2931 </td><td> 1962 </td></tr>
<tr><td>ZA-WITS-CORE</td><td> 10491 </td><td> 524 </td></tr>
</tbody>
</table>

In order to ensure that the files were readily available locally at sites where online storage was available, the files were replicated to the respective storage endpoints. However this would have created a complication for the user, since data locality is lost. We therefore used the Logical File Catalogue (LFC) to replicate the files with a single namespace, and passed to the JDL as data input. For _e.g._ the `NCHLT_2K` data set, we thus have a single logical directory :
{%highlight bash %}
lfn:/grid/sagrid/nwu-hlt/NCHLT/
{%endhighlight %}

containing all of the data sets, which have been replicated across storage elements.

{%highlight bash %}
DataRequirements = {
                     [
                       InputData = {"lfn:/grid/sagrid/nwu-hlt/NCHLT/NCHLT_2K.tar.gz"};
                       DataCatalogType = "DLI";
                       DataCatalog = "http://lfc.magrid.ma:8085";
                      ]
                    };
{%endhighlight %}

As can be seen here[^JDLSnippet], we are using the catalogue provided by the Moroccan National Grid Initiative (MAGrid), which is a member of the Africa-Arabia Regional Operations Centre. By registering the data sets in a single namespace, we can easily select the "closest" one to the computing element and improve the efficency of data transfer at job submission time.

## Coming Soon.

This has been the first post on our performance study. Coming in the next one, we will describe the tasks that were done and the parameter scans, as well as how we used the gLibrary-2.0 metadata service to keep records of the timing performance.

# References and Footnotes

[^PublishedSoon]: The data will soon be published in an open acces data repository.
[^HTK]: See ["The HTK Book"](http://htk.eng.cam.ac.uk/docs/docs.shtml) Young et al., 2009. Available online at [https://www.researchgate.net/publication/236023819_The_HTK_book_for_HTK_version_34](https://www.researchgate.net/publication/236023819_The_HTK_book_for_HTK_version_34)
[^LibSVM]: Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for support vector machines. ACM Transactions on Intelligent Systems and Technology, 2:27:1--27:27, 2011. Software available at http://www.csie.ntu.edu.tw/~cjlin/libsvm
[^SeeCVMFSPage]: The `fastrepo` was used. See [www.africa-grid.org/cvmfs](http://www.africa-grid.org/cvmfs) for a description of the various repositories.
[^CValue]: See http://www.svms.org/parameters/ for a discussion of SVM parameters.
[^EGIOLA]: These are specified in the [Resource Centre Operational Level Agreement](https://documents.egi.eu/public/ShowDocument?docid=31), Malgorzata Krakowian and Christos Kannelopoulos, 2014, EGI.
[^CREAMPaper]: P. Andreetto et al., CREAM: A simple, Grid-accessible, Job Management System for local Computational Resources, Proc. XV International Conference on Computing in High Energy and Nuclear Physics (CHEP'06), Feb 13-17, 2006, Mumbay, India, Macmillan, p. 831-835, ISBN 10:0230-63017-0, ISBN 13:978-0230-63017-8.
[^CREAMPaper2]: C. Aiftimiei, P. Andreetto, S. Bertocco, S. Dalla Fina, A. Dorigo, E. Frizziero, A. Gianelle, M. Marzolla, M. Mazzucato, M. Sgaravatto, S. Traldi, L. Zangrando, Design and Implementation of the gLite CREAM Job Management Service, Future Generation Computer Systems, Volume 26, Issue 4, April 2010, pp. 654-667, [doi: 10.1016/j.future.2009.12.006](http://dx.doi.org/10.1016/j.future.2009.12.006). A preliminary version is available as INFN Technical Note INFN/TC_09/3, may 5, 2009
[^UMD]: M. David, G. Borges, J. Gomes, J. Pina, I. Campos Plasencia, E. Fernández-del-Castillo, I. Díaz, C. Fernandez, E. Freire, Á. Simón, K. Koumantaros, M. Dreschner, T. Ferrari, and P. Solagna, “Validation of Grid Middleware for the European Grid Infrastructure,” Journal of Grid Computing, vol. 12, no. 3, pp. 543–558, 2014. [doi:10.1007/s10723-014-9301-z](http://dx.doi.org/10.1007/s10723-014-9301-z)
[^CODE-RADElibsvm]: Bruce Becker et al.. (2016). CODE-RADE: Libsvm Release. Zenodo. [doi: 10.5281/zenodo.51591](http://dx.doi.org/10.5281/zenodo.51591)
[^GLUE12]: Sergio Andreozzi, Stephen Burke, Laurence Field, Steve Fisher, Balasz Konya, Marco Mambelli, Jennifer M Schopf, Matt Viljoen, Antony Wilson, R Zappi (2005) "GLUE Schema Specification-Version 1.2". Available online at https://forge. gridforum. org/sf/go/doc14185
[^top-bdii]: There are several top-bdii services for the ROC, the default being `top-bdii.africa-grid.org`.
[^GOC]: The site name as defined in the [Global Operations Database](http://goc.egi.eu)
[^DPM]: Akos Frohner _et al_. "Data management in EGEE", J.Phys.Conf.Ser. 219 (2010) 062012 ([doi: 10.1088/1742-6596/219/6/062012](http://dx.doi.org/10.1088/1742-6596/219/6/062012))
[^JDLSnippet]: This snippet was taken from one of the JDLS in the [CODE-RADE grid examples for libsvm](https://github.com/AAROC/CODE-RADE/tree/master/grid/libsvm).
