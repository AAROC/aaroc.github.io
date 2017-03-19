---
layout: post
title: AAROC July Situation report
description: AAROC July Situation Report
headline: AAROC July #SitRep
category: DevOps
tags: [AAROC, Sitrep, operations, summer, Resource Allocation, VAPOR]
image:
  feature:
comments: true
---

# TL;DR

We participated to the EGI Operations Management Board (OMB), here's a report back with some highlights and important issues facing the ROC, both from EGI.eu, as well as internally. There are a few ***campaigns*** which we will be undertaking during August - APEL, CVMFS and ARGUS.

# OMB Summary

The OMB is an (almost) monthly meeting where the NGI managers connect with EGI to report back on development activities and operational issues. The July OMB was held today. Here's a short summary of the issued covered and how they affect us : (here's the full [agenda](http://indico.egi.eu/indico/conferenceDisplay.py?confId=2191) for the curious)

## Resource Allocation update - Marcin Radecki (CYFRONET)

The [e-Grant](http://e-grant.egi.eu) Resource Allocation framework is a new service provided by EGI to provide an SLA creation mechanism between resource providers and consumers. It has seen a few months of usage and is starting to be used by research communities. The tool allows you to either request or advertise pools of resources for a particular use. The operators of the service then make a match and create an SLA based on the provider/consumer informaiton.

In our ROC, [ZA-UJ](http://physics.uj.ac.za/cluster/) and [ZA-CHPC](http://www.chpc.ac.za) have advertised pools, and were mentioned by Marcin, but were not matched to requests. I would have liked to be able to see a list of requested pools, to be able to contact sites to better match their pool adverts to these requests in a kind of second-round of SLA negotiation, but this is not yet implemented.

Some other issues were raised by Marcin :

 * Misunderstanding/lack of knowledge about RA process: "Offering a pool in e-grant does not mean EGI.eu operations team will manage these resources. EGI.eu does brokering, resource manager can accept offer or not (depending on type of pool: free-hand, right-to-revoke, negotiated"
 * Incompatibility of local/national policies with EGI RA process - "Researchers must be affiliated to some national organization in order to get resources and they should apply using national system (no sense to create a pool in e-grant);
 * Also, when resources are owned by some local group and cannot be shared with anyone else this creates an issue with the allocation process.

So, there is clearly some work to be done on the communication and information sharing aspects of the e-Grant system, but all in all, it's a very good way to ensure that requests from user communities are well-expressed (forcing researchers to think at least a little about what they will be using the grid for). Also, this can help resource providers to justify their allocation of resources to particular queues and storage. I would like to see much larger uptake of the service by our sites.


## EGI OLA and SLA Framework update - Malgorzata Krakowian (EGI.EU)

There are a few operational agreements which ensure that the grid as a whole maintains a certain level of availability and reliability. These are [curated by EGI.eu](https://wiki.egi.eu/wiki/Performance). The relationship between the agreements is shown below for a refresher :
<figure>
  <img src="{{site_url}}/images/600px-OLA_SLA_framework.png">
  <figcaption>The EGI.eu SLA and OLA framework.</figcaption>
</figure>
Resource centres (sites) have an OLA with the Resource Infrastructure Provider (ROC), which in turn has an OLA with EGI.eu and this keeps everyone happy. Now, the EGI Operating Level Agreement (OLA) has been updated by the OMB, mostly removing reference to _grid_ in the text, to allow for more generic services, but also changing certain thresholds for service availability :

  * **Resource Centre OLA** - the threshold for availability and reliability has been changed from 70/75 to 80/85 %
  * **Resource Infrastructure Provider OLA** - threshold for A/R has been updated as per RC OLA, and a new list of mandatory core services is updated from top-BDII to:
   * Top-BDII
   * ARGUS (we don't have this yet)
   * NGI-SAM
This involves a minor increase in performance requirements for the sites, while we need to put up a new service at Meraka (Argus) - see below.

***Please, all sites, read the [RC OLA](https://documents.egi.eu/public/ShowDocument?docid=463) and ensure that you understand and agree with everything.*** You have until 15/08 to comment.

## VAPOR Overview - Franck MICHEL (CNRS)

VAPOR (**V**o **A**dministration and operations **POR**tal) is a very useful development for VO's  which don't have a huge support community, to provide them with a means to better administer and interact with grid resources. Despite the unfortunate acronym, the service is very useful and provides VO-level services to improve operations : VO-level nagios, voms admin interface, data transfer dashboard, interface to GGUS, operations portal, GOCDB, etc. I highly recommend taking a look  at Franck's slides on indico to find out more.

It's a web-service, so all that's necessary to use it is to enable the VO in the [operations portal](https://operations-portal.egi.eu/vapor/), which is done by sending a mail to the admin. I have done this for VO sagrid.ac.za - we should do so for eumed as well.

So, this OMB leaves us with a few tasks to undertake, both at the sites as well as at Meraka. Some of these are simple once-off tasks, for which tickets are already open, while some will require ongoing attention. These will be referred to from now on as *campaigns*.

# AfricaArabia ROC Campaigns

Starting this August, we will be starting longer-term operations task management which we are calling *campaigns*. These will be conducted as needed, when there is a request from EGI, an ROC site or a user community, which requires ***coordinated*** action at most or all sites. The idea behind running a campaign is that will have a campaign leader, who is responsible for getting sites to stick to a schedule or taking action; campaigns are also time-limited, meaning that they have to have a start and an end.

While this is just another way of doing what we've always been doing, it will give some more visibility to important ROC-wide tasks and perhaps allow better delegation of tasks. Also, it will allow us to report better to supporting projects such as [CHAIN-REDS](http://www.chain-reds.eu) and [ei4Africa](http://www.ei4africa.eu), as well as relying parties like EGI.eu. Ideally, campaigns should have
  * A motivation
  * a description of the work to be done.
  * their own web page
  * a calendar of actions and
  * a hashtag.

Campaigns will be mostly documented on the [Github wiki pages](https://github.com/AAROC/DevOps/wiki) of the [AAROC](https://www.github.com/AAROC) [DevOps repo](https://github.com/AAROC/DevOps)

To kick things off, we are starting the following operations campaigns for Accounting, CMVFS and ARGUS authorisation framework.

## APEL Accounting

### Motivation
Accounting is a big deal - for many obvious reasons. While many sites have local accounting, a global, comprehensive accounting system is necessary for interoperability (and is a requirement of the EGI.eu interoperability).

The accounting system we are using is the APEL accounting system, which consists of a client installed on the sites, which interacts with the Compute Elements, reporting usage to a regional server. The regional server publishes data and summaries to the central [EGI accounting service](https://accounting.egi.eu), which can be used to generate reports of usage.

### Description of work to be done
 * ***ROC*** : Deployment and integration of the regional accounting server.
 * ***Sites*** : The APEL client needs to be installed on the CE (or a local machine which can interact with the CE.

The regional server has been installed and configured. After a very long and confusing period, we are successfully publishing data from at least 2 SAGrid sites (ZA-UJ, ZA-WITS-CORE) and one MAGRID site (MA-01-CNRST). There is a major difference between the APEL client for EMI/UMD2 and EMI/UMD3.

The procedure to follow is described by EGI at [https://wiki.egi.eu/wiki/MAN09_Accounting_data_publishing](https://wiki.egi.eu/wiki/MAN09_Accounting_data_publishing)

### Campaign pages

The campaign will be discussed at https://github.com/AAROC/DevOps/wiki/AccountingCampaign-2014-08 and will use hashtag #AAROCAPEL2014

## ARGUS

### Motivation
To support the EGI emergency central user suspension, on November 2013 the OMB agreed to deploy an Argus instance at NGI level. The NGI Argus instance will fetch from the central instance the list of suspended user DNs. Sites are supposed to query the NGI instance, in order to avoid to overload the central instance.

### Description of work to be done

The ticket https://ggus.eu/index.php?mode=ticket_info&ticket_id=104874 describes the work to be done :

 1. A central ARGUS instance has to be installed at Meraka.
 1. Sites should either deploy their own Argus configured to listen to the one at Meraka, or perform manual synchronisation (see http://wiki.nikhef.nl/grid/Argus_Global_Banning_Setup_Overview#Site_runs_no_Argus)

### Campaign pages

The campaign will be discussed at  [on the GitHub wiki](https://github.com/AAROC/DevOps/wiki/ArgusCampagin2014) with hashtag #AAROCARGUS2014

## CVMFS

### Motivation

The CERN Virtual Machine File System ([CVMFS](http://cernvm.cern.ch/portal/filesystem)) is being used by several VO's to distributed static files and applications. It is a very easy way to ensure that applications are available on sites, removing the need for manual intervention by a software manager at sites, centralising the management of the repositories and reducing load on site administrators who only need to make once-off adjustments ot their sites.

### Description of work to be done

Sites need to ensure that CVMFS clients are installed on:
  * All Worker Nodes
***OR***
  * the shared NFS area of the Compute Element, if this is mounted by the WN.

Additionally, sites are encouraged to deploy a squid proxy to cache repo content and reduce network traffic.
At the very minimum, sites should enable the default repositories distributed by the pacakge, and should also consider enabling the SAGrid Application repository.

### Campaign pages

The campaign will be discussed at https://github.com/AAROC/DevOps/wiki/CVMFS-Campaign-2014 with hashtag #AAROCCVMFS2014

That's a wrap for July 2014 !
