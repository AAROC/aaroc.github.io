---
layout: post
title: AAROC September 2014 Situation report 
description: AAROC September 2014 Situation Report
headline: AAROC September 2014 #SitRep
category: DevOps
tags: [AAROC, Sitrep, operations, summer, sites, OMB, EGI]
image: 
  feature: 
comments: true 
---

# TL;DR

We participated to the EGI Operations Management Board (OMB) in September, here's a report back with some highlights and important issues facing the ROC. Sites are performing unacceptably, and many tweaks and fixes are needed. A summary table of operational issues facing sites is also given.

# OMB Summary

The OMB is an (almost) monthly meeting where the NGI managers connect with EGI to report back on development activities and operational issues. The Stpember OMB was held today. Here's a short summary of the issued covered and how they affect us : (here's the full [agenda](http://indico.egi.eu/indico/conferenceDisplay.py?confId=2281) for the curious)

## General Update

A few general comments were given by Malgorazata, summarised here. The ROC monitoring SLA is updated, and GGUS performance will also be calculated. Furthermore, there new [SLA framework](https://documents.egi.eu/public/ShowDocument?docid=2166) needs feedback.

In other news, [GSTAT](http://gstat.egi.eu/) support is also back. After a period where the support unit disappeared and it looked like GSTAT was dead, it was reported that there is now medium support for GSTAT issues and the [support unit](https://wiki.egi.eu/wiki/GGUS:GStat_FAQ) is back. There is some wierdness - espcially about which regions sites belong to; Please check your sites for the `AfricaArabia` tag in `EGI_NGI` or `EGI_OTHER_GRID`. Feel free to open a ticket against gstat too.

There was a reminder that the OPS VOMS moving; the deadline was 15/09/2014. I think all our sites have been configured. A [ticket](https://ggus.eu/?mode=ticket_info&ticket_id=108183) has been opened against the ROC, as well as against individual sites: 

The current situation in AAROC is : 

| Site name | Ticket | Status |
|:--------------|:--------:|---------:|
| DZ-01-ARN | [108192](https://ggus.eu/?mode=ticket_info&ticket_id=108192) | <font color='red'>still open</font> | 
| EG-ZC-T3 | [108787](https://ggus.eu/?mode=ticket_info&ticket_id=108787) | <font color='red'>still open</font> |
| MA-01-CNRST | [108191](https://ggus.eu/?mode=ticket_info&ticket_id=108191) | <font color='green'>done</font> | 
| ZA-CHPC | [108193](https://ggus.eu/?mode=ticket_info&ticket_id=108193) | <font color='red'>still open</font> | 
| ZA-MERAKA | [108194](https://ggus.eu/?mode=ticket_info&ticket_id=108194) | <font color='green'>done</font> | 
| ZA-UCT-ICTS | [108195](https://ggus.eu/?mode=ticket_info&ticket_id=108195) | <font color='red'>still open</font> | 
| ZA-UFS | [108196](https://ggus.eu/?mode=ticket_info&ticket_id=108196) | <font color='red'>still open</font> | 
| ZA-UJ | [108197](https://ggus.eu/?mode=ticket_info&ticket_id=108197) | <font color='green'>done</font> | 
| ZA-WITS-CORE | [108198](https://ggus.eu/?mode=ticket_info&ticket_id=108198) | <font color='green'>done</font> |

# Operations portal updates

EGI Operations Support team is preparing webinar "ROD Dashboard Training"[^dashboard_announcement] training. Details : 
  
  * **Date**: **03.10.2014** at **11:00 CEST** 
  * **Participation over Adobe Connect**: [https://meet.plgrid.pl/rodtutorial/](https://meet.plgrid.pl/rodtutorial/)

Note : ***Participation is mandatory for all operators***

There are some changes to the way that the portal raises alarms : with next week's  release of the operations portal, alarms will be raised for Availability (80%) and also Reliability (85%). If you would like to contribute to testing and feedback of the ops protal, send a mail to `operations @ egi.eu`


# SAM refactoring

SAM refactoring is under way since a while now - issues are tracked at [https://github.com/ARGOeu/sam-probes/issues](https://github.com/ARGOeu/sam-probes/issues). The FTS2 probe is deprecated (everyone is moving to FTS3. Some work was done by Emir to update the [procedure for adding new probes to SAM](https://wiki.egi.eu/wiki/PROC07).

remove org.gstat.sanity check and include glue-2 sanity check

# UMD updates 
Cristina Aiftimiei reported on middleware developments. UMD2 was decommissioned in ***April 2014***. All site should be on at least UMD-3[^were-good].

## GFAL-util deprecation

There is a major issue facing the data management aspects of the grid middleware. GFAL[^gfal] is a central component of data management, and is being deprecated; end-of-life mode of gfal and lcgutil - **Fri, 05/09/2014**

> "Gfal and lcg-util are in end-of-life mode, which means no new features, nor new bug fixes will be done, excepting very critical ones if needed. <br>
> Support for both will defintitely end the 1st of November 2014 , so we recommend to all our users to switch to the newer gfal2 and gfal2-utils.”

There are a few issues : 

  1. No replacement for: `lcg-aa`, `lcg-la`, `lcg-ra`, `lcg-uf`
     1. Solution for `lcg-uf` - new `gfal-legacy-replicas`, `gfal-legacy-register` and `gfal-legacy-unregister`
  1. document `gfal-util` commands as replacement of `lcg-util` ones (no progress)
  1. New version of UI & WN – 3.1.0 added dependency on gfal2-util

## New packages for UMD

The CVMFS client, FTS3 and frontier squid are now in the UMD repos.

## Coming up

The following issues were reported in the software provisioning queue : 

  1. **New CREAM flavours**: (update of the info-dynamic-scheduler improving the Glue2 support and provides some bug fixes.)
     1. LFS v. 2.0.4
     1. SLURM v. 1.0.2
     1. Torque v.  2.1.4 
     1. GE v. 2.3.0 
  1. **APEL** v. 1.2.2: Fix for being unable to parse uncompressed accounting introduced in 1.2.1 – version not released in UMD
  1. **BDII-core** v. 1.6.0: Minor release containing a set of new features and minor fixes to the following packages: 
     1. bdii
     1. glue-validator
     1. glue-schema
     1. glite-info-provider-service.
  1. **WMS** v. 3.6.6: Bug fix when setting umask 0077 breaks `glite-wms-job-submit` and `WMProxy` deletes a user delegated proxy on list-match operation. It also solves the issue when a given CE with problems causes a WMS to become very slow dealing with all other jobs.
  1. **UI/WN** v. 3.1.0 :  new dependencies on gfal2-util & ginfo 
  1. **CANL** v. 2.2.4: bug fix in the caNl-java package in order to solve some OCSP handling
  1. CERN Data Management Clients:
     1. **gfal2** v. 2.6.8: Important release with many bug fix, improvements and new functionalities like enabling tests for `xrootd`, `http` and `dCache`.
     1. **gfal2-util** v. 1.0: Some important bug fixes like `gfal-copy --force` not working and `gfal-ls` hanging.


Finally, some dead links on the documentation were found and EGI is working on fixing them.

# AAROC Site issues

So much for the Europeans. How are we doing down here in sunny mama-Africa ? Here is a quick overview of current issues grouped by service type at the various sites.

If you want to take a look at the dashboard and see issues at your sites you need to be registered as a regional operations officer for the ROC in the GOCDB. The figure below shows how to set the view to "monitoring" to see the operational issues at the sites instead of just the ROD-level issues:

<figure>
<img src="{{ site_url }}/images/operations-portal.gif"></img>
</figure>

| Site  | Workload | Compute  | Data  | Accounting | Infosys | A/R | 
|:------|:------------|:-------------|:------|:---------------|:----------|:----|
| [DZ-01-ARN]( https://goc.egi.eu/portal/index.php?Page_Type=Site&id=964) |  <font color='green'>ok</font> | <font color='red'>not ok</font> ([108789]( https://operations-portal.egi.eu/rodDashboard/ticket/108789/site/DZ-01-ARN/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?page=details),  [107876](https://operations-portal.egi.eu/rodDashboard/ticket/107876/site/DZ-01-ARN/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?page=details)) | <font color='red'>not ok</font> ([108789](https://operations-portal.egi.eu/rodDashboard/ticket/108789/site/DZ-01-ARN/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?page=details))  | <font color='red'>not ok</font> ([108791](https://ggus.eu/index.php?mode=ticket_info&ticket_id=108791)) | <font color='green'>ok</font> | <font color='red'>0.0</font> | 
| [EG-ZC-T3](https://goc.egi.eu/portal/index.php?Page_Type=Site&id=981) | none | <font color='red'>not ok</font> ([107874](https://operations-portal.egi.eu/rodDashboard/ticket/107874/site/EG-ZC-T3/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?page=details), [108792](https://operations-portal.egi.eu/rodDashboard/ticket/108792/site/EG-ZC-T3/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?page=details) ) | none | <font color='red'>not ok</font> ([108793](https://ggus.eu/?mode=ticket_info&ticket_id=108793))| <font color='red'>not ok</font> ([107874](https://operations-portal.egi.eu/rodDashboard/ticket/107874/site/EG-ZC-T3/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?page=details))| <font color='red'>0.0</font> | 
| [MA-01-CNRST](https://goc.egi.eu/portal/index.php?Page_Type=Site&id=922) | <font color='green'>ok</font> | <font color='red'>not ok</font> ([108796](https://operations-portal.egi.eu/rodDashboard/ticket/108796/site/MA-01-CNRST/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?page=details)) |  <font color='green'>ok</font> |  <font color='green'>ok</font> |  <font color='green'>ok</font> | <font color='red'>0.0</font> |
| [ZA-CHPC](https://goc.egi.eu/portal/index.php?Page_Type=Site&id=286) | none | <font color='red'>not ok</font> ([108800](https://operations-portal.egi.eu/rodDashboard/ticket/108800/site/ZA-CHPC/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?site=ZA-CHPC&page=details)) | <font color='red'>not ok</font> ([108802](https://operations-portal.egi.eu/rodDashboard/ticket/108802/site/ZA-CHPC/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?site=ZA-CHPC&page=details)) | <font color='red'>not ok</font> ([108803](https://ggus.eu/index.php?mode=ticket_info&ticket_id=108803)) | <font color='red'>not ok</font> ([108797](https://operations-portal.egi.eu/rodDashboard/ticket/108797/site/ZA-CHPC/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?page=details)) | <font color='red'>0.0</font> |
| [ZA-MERAKA](https://goc.egi.eu/portal/index.php?Page_Type=Site&id=175) | <font color='green'>ok</font> | none | none | <font color='green'>ok</font> | <font color='green'>ok</font> |  <font color='green'>96.2</font> | 
| [ZA-UCT-ICTS](https://goc.egi.eu/portal/index.php?Page_Type=Site&id=374) | none | <font color='green'>ok</font> | none | <font color='green'>ok</font> | <font color='green'>ok</font> | <font color='red'>0.0</font> |
| [ZA-UJ](https://goc.egi.eu/portal/index.php?Page_Type=Site&id=285) | none | <font color='green'>ok</font> | <font color='green'>ok</font> | <font color='red'>not ok</font> ([108807](https://operations-portal.egi.eu/rodDashboard/ticket/108807/site/ZA-UJ/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?page=details)) | <font color='green'>ok</font>  | <font color='red'>67.35</font> |
| [ZA-WITS-CORE](https://goc.egi.eu/portal/index.php?Page_Type=Site&id=689) | none | <font color='red'>not ok</font> ([108808](https://operations-portal.egi.eu/rodDashboard/ticket/108808/site/ZA-WITS-CORE/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?page=details) ) | <font color='green'>ok</font> | <font color='green'>ok</font> | <font color='green'>ok</font> | <font color='red'>0.0</font>  |

##  DZ-01-ARN

Generally looking good, but some problems with variables. There is one [ticket](https://operations-portal.egi.eu/rodDashboard/ticket/107876/site/DZ-01-ARN/tab/details/tsid/ggus_helpdesk_ops-workflow_rod?page=details) open in the operations portal.

### Workload

The WMS is functiong *ok*, but some job states fall into `critical` due to them failing on sites.

### Compute
  
  * CREAM-CE: All fine, apart from timeouts when connecting to the CREAM CE to interrogate job statuses. See https://nagios.c4.csir.co.za/nagios/cgi-bin/extinfo.cgi?type=2&host=ce04.grid.arn.dz&service=emi.cream.CREAMCE-DirectJobState-ops
  * WN: Default SE not configured (seems to be set in `site-info.def` or `glite-creamce` configuration file as `DPM_HOST` - maybe missing `$` ?)
    ````
        org.sam.WN-Rep-ops: CRITICAL
        wn04.wn-1.grid.arn.dz: CRITICAL: METRIC FAILED [org.sam.WN-RepCr]
        CRITICAL: File was NOT copied to SE DPM_HOST and registered in LFC prod-lfc-shared-central.cern.ch
    ````

### Data

  * Can't seem to find replicas of the file using LFC - probably because the DZGrid Top-bdii is being used for registration and the Meraka top-bdii is being used for replica search. 
  * LFC is fine :relaxed:


### Accounting
Missing APEL and glite-APEL endpoints.

### Infosys

Several warnings  and info caught by midmon : https://midmon.egi.eu/nagios/cgi-bin/extinfo.cgi?type=2&host=bdii01.grid.arn.dz&service=org.bdii.GLUE2-Validate

### ***TODO List***

  1. Add `top-bdii.c4.csir.co.za` to the list of top-bdiis at the site (in `site-info.def`)
  1. Set the default SE in the `site-info.def` and re-yaim
  1. Add the glite-APEL and APEL endpoints in GOCDB and 
     * ensure that apel-publishers and apel-parser are installed on the CE and properly configured
  1. Check the configuration of the site-bdii

## EG-ZC-T3

The Egyptian site seems not to have any worker nodes configured for ops VO, and is missing several services.

### Workload

No WMS is registered at the site.

### Compute

  * The site has only the CREAM-CE registered, but no MPI or other services.
  * There seems to be no resources available at the site to run ops jobs - probes are just waiting

### Data

There are no data storage or data management capabilities registered at the site.

### Accounting

There is no APEL or glite-APEL registered at the site.

### Infosys

Top-bdii is not responding - all probes are failing. Site bdii is ok.

### ***TODO List***

  1. Ensure that there are worker nodes assigned to the ops queue
  1. Install and configure the MPI services at the site
  1. Add glite-APEL and APEL instances to the site in GOCDB, ensure that they are installed on the CE and
       * configure the APEL parsers and publishers properly
  1. Check that the top-bdii is up and running and that it is properly configured

## MA-01-CNRST

The site seems fine, with a few minor problems. VOMS is missing.

### Workload

Some issues related to jobs failing on sites, service looks fine.

### Compute

  * CREAM-CE - CREAM is properly configured and passing all tests.
  * WN : no broker is found on the WN : `Found no working broker we could connect to.` ([full error](https://nagios.c4.csir.co.za/nagios/cgi-bin/extinfo.cgi?type=2&host=ce1.cnrst.magrid.ma&service=emi.cream.CREAMCE-JobState-ops)). This is likely due to the fact that the top-bdii of Morocco is being used and not the AAROC top-bdii.

### Data

Storage Element and LFC passing all tests :relaxed:

### Accounting

Synch and Pub status ok :relaxed:

### Infosys

No errors reported by site-bdii :relaxed:

### ***TODO List***

  1. Add `top-bdii.c4.csir.co.za` to the list of top-bdiis at  the site.

## ZA-CHPC

Site is still undergoing an upgrade. CE is installed, but not connected to WN, and SE, UI need to be properly configured.

### Workload

No WMS is registered at the site.

### Compute

All probes are failing. 

### Data

All probes are failing (and service does not appear in infosys).

### Accounting

No accounting service registered at the site.

### Infosys

All probes are failing.

### ***TODO List***

  1. Ensure that there are worker nodes assigned to the ops queue
  1. Install and configure the MPI services at the site
  1. Add glite-APEL and APEL instances to the site in GOCDB, ensure that they are installed on the CE and
       * configure the APEL parsers and publishers properly
  1. Check that the site-bdii is up and running and that it is properly configured
  1. Check that SE is properly configured
  1. Check that CE and SE are defined in the site-bdii

## ZA-MERAKA

### Workload

WMS passing all tests

### Compute

CE is not functional and only used for playbook testing.

### Data

FTS  needs to be reconfigured. Service has been taken out of production. LFC needs to be installed.

### Accounting

Regional Instance was restarted, now publishing messages from sites on the ZA-MERAKA queue.

### Infosys 

Top-bdii and site-bdii passing all tests.

### ***TODO List***

  1. Fix FTS
  1. Install and configure LFC.
  
## ZA-UCT-ICTS

The site seems to be working fine, except minor issues with the default SE (set to CHPC, which is not working).

### Workload

No WMS is at the site.

### Compute

  * CE is working fine - but no MPI flavours are published
  * WN can execute jobs, but 	

### Data

No SE is registered at the site.

### Accounting

All ok :relaxed:

### Infosys

All ok :relaxed:

### ***TODO List***

  1. Configure MPI flavours 
  1. Set default SE to ZA-UJ or ZA-WITS-CORE until CHPC SE can be properly configured.
  
## ZA-UJ

Site is, as usual, working fine except for accounting errors.

### Workload

No WMS is registered at the site.

### Compute

  * CE - no problems
  * WN - no problems

:relaxed:

### Data

SE is working fine :relaxed:


### Accounting

Site hasn't published records in over a month. Parser and publisher should be manually checked.

### Infosys

`eu.egi.mpi.EnvSanityCheck` is showing a warning : `Publishes an incorrect value for GlueCEPolicyMaxSlotsPerJob (2147483647)`

### ***TODO List***

  * Re-run parser and publisher
  * check CE GRIS or maui config for the incorrect CE policy
  
## ZA-WITS-CORE

Site is working fine, except for MPI misconfiguration and incorrect default SE. `LCG_GFAL_INFOSYS` is also incorrectly set. 

### Workload

No WMS is registered at the site

### Compute

  * CE does not publiush MPI flavours
  * WN (and perhaps CE) have top-bdii (`LCG_GFAL_INFOSYS`) set to `srvslngrd001.uct.ac.za` which has been decomissioned a long time ago. 

### Data

No problems :relaxed:

### Accounting

No problems :relaxed:

### Infosys

No problems :relaxed:

### ***TODO List***

  1. Change top-bdiis to `top-bdii.c4.csir.co.za`  
  1. Change default SE to local SE

# Footnotes and References
[^dashboard_announcement]: See the announcement on the operations portal broadcast : [https://operations-portal.egi.eu/broadcast/archive/id/1193](https://operations-portal.egi.eu/broadcast/archive/id/1193)
[^were-good]: No sites were found by the monitors in our region with UMD2, so we're good.
[^gfal]: GFAL - Grid File Access Library.
