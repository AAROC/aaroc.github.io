---
layout: post
title: Africa Arabia ROC in production
description: We have now moved the Africa Arabia Regional Operations Centre to production.
headline: AfricaArabia Dev2Prod
category: Releases
tags: [AAROC]
image: 
  feature: 
comments: true 
---

# TL;DR
AAROC is now in production. Integration as a Resource Infrastructure Provider has been completed with EGI.eu. Sites across the region can be registered in the GOCDB, and take advantage of central tools (monitoring, accounting, etc). To speed up deployment, we've put some effort into our Executable Infrastructure repository. 

# An agreement to stabilise an old collaboration.

The Africa-Arabia Regional Operations Centre is a distributed inititive, supported by several projects and institutes, aimed at developing a sustainable collaboration for e-Infrastructure across Africa and the Middle East. The region is defined principally by the coverage of the main regional research network alliances, [ASREN](https://www.asrenorg.net) and the [Ubuntunet Alliance](https://www.ubuntunet.net); institutes served by these regional NREN alliances are by default able to join the ROC, provided they respect the operational requirements of the collaboration. 

## The ROC : What and Why ? 

A regional operations centre can be described in two ways. It is firstly a loose collaboration of institutes, resource providers and other roleplayers in a regional e-Infrastructure. The concept of a ROC grew from the early experience of EGEE[^EGEE], and was mostly required to achieve the scalability of operations that a global infrastructure needs. Organisation of a huge collaboration requires a level of flexibility that centralised models cannot provide. In order to scale, an infrastructure needs to be able to adapt to differences in local policy and resources, while nonetheless providing as standard a possible interface to various services across the entire scope that it serves. The ROC is therefore a way for regions (be they nations, or trans-national areas) to inter-operate with each other by adopting standardised policies, procedures and tools, while maintaining autonomy in their local resources. The

The ROC is thus a point of contact and coordination between various components of e-Infrastrucutre. The network providers, HPC centres, data centre operations team, CSIRT, support team, and even the community application support teams are all represented in the ROC. 

## What a ROC provides

There are several other ROCs recognised by the world's grid infrastructure, such as Canada, AsiaPacific and of course the various nations such as France and Italy. Each of these provides a predefined minimum set of services whereby interoperation is achieved, such as service monitors, helpdesk, accounting portal, etc. There are also "human services" which the operations team needs to provide, such as the Regional Operator on Duty (ROD) function. ROD has an essential role, checking the operations portal periodically for alarms raised by the monitoring services and opening tickets against the sites which are causing these problems. ROD also has the responsibility to follow up on those tickets and take measures to ensure that they are closed in time. These metrics are well-described in the site [Operating Level Agreement](https://documents.egi.eu).

## Previous Implementations

This is the second attempt at integration of the region into the global grid infrastructure. Previous efforts focussed on regionalised, standalone implementations of the various operational tools, under an independent domain. This essentially meant that AfricaArabia operated its own:

 - operations database: a regional GOCDB instance at https://gocdb.africa-grid.org
 - helpdesk: an xGUS instance at https://support.africa-grid.org
 - monitoring services: the nagios instance was at https://nagios.africa-grid.org; smokeping was also installed.

Of course, there was also a [public website](https://roc.africa-grid.org), which presented the ROC services and information to the various technical and user communities. 

This implementation, however, was due to change since the regionalisation efforts of the systems mentioned above was discontinued by EGI.eu. A tighter interoperation model was developed, in the context of the first [CHAIN](https://www.chain-project.eu/old-project) project, using a template MoU agreement with EGI as a so-called **Resource Infrastructure Provider**. Before continuing with the entire region of Africa and Arabia, this MoU was implemented only with South Africa as a use case. The integration was finished in 2012, and operations ran without problem for one full year. 

An agreement was reached to implement the same MoU with EGI.eu, signed again between the CSIR as representative of the regional operations team and EGI.eu, to allow interoperation of the infrastructure across the African and Arabian region. While we still need to finalise formal signature of the MoU, it became operational on Thursday 27 March 2014.

> We would like to announce that AfricaArabia is now fully operational and that we have finished its integration procedure. All necessary
operational teams and tools are established in our Operations Centre and we are ready for production.

> This Operations Centre is visible in all operational tools as AfricaArabia and is responsible for all ex NGI_ZA and EUMed sites, as well as new sites in the region from Damascus to Dakar to Cape Town.
> We have still some work to do in migrating old services to new middleware, as well as registering the regional VO's, but this will happen in the near future.
> EGI supported VO's currently active in the region include: 
>  - ATLAS
>  - ALICE
>  - CMS
>  - enmr.eu

> We welcome requests to support existing VO's on our sites and would be keen to have regional VO's (eumed, sagrid.ac.za, etc) supported on EGI and peer infrastructure sites.

> The code for the various operations projects of this OC is at [https://github.com/AAROC](https://github.com/AAROC)

> Thanks especially to CHAIN-REDS project and EGI.eu partners for the support in getting us here.

# Integration and usage of central tools.





# Footnotes

[^EGEE]: **E**nabling **G**rids for **E**scien**E** was the first trans-continental e-Infrastructure project originally funded by the EU FP6 programme. After three rounds the project ended in 2012 and was evolved into [EGI.eu](https://www.egi.eu).
