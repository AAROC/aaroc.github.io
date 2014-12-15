---
layout: post
title: Continuous Delivery
description: Distributed development, Centralised Delivery
headline:  Enabling continuous deployment of research applications
category: Developers
tags: [AAROC, continuous integration, collaboration, article]
image:
  feature:
comments: true
---

# Abstract

One of the aims of e-Infrastructures is to provide easy access to powerful computational and data platforms, to as many eligible users as possible. The South African National Grid (SAGrid) is no exception. While access to the users is being simplified greatly by the adoption of science gateways and identity federations, the community of application developers and technical support in scientific collaborations does not yet have an easy way to integrate these applications in the first place.

SAGrid has identified this as a gap in the services it provides and has developed a solution to the issue of easily integrating new applications into the infrastructure in a fast, flexible, distributed and reproducible way. Using existing tools and services, we have defined a simple set of tests which applications need to pass in order to be considered valid for the infrastructure. These have been encoded as automated tests using a continuous integration platform. Interoperability between source code repositories, automated build systems, artifact creation and content delivery systems is crucial for the sustainability and uptake of the system; we will describe the work done and the reasoning behind the technology choices made.

We will show how the porting of applications can be made more reproducible, and how distribution of these applications has been simplified, compared to "traditional" means of deploying software on the grid and cloud. In particular, we will highlight the ease of collaboration. We thus describe a slightly different type of "science gateway", relevant to application developers, which promotes collaboration, increases reproducibility of the work done, and ensures that there is a sustainable development of applications for Science Gateways connected to the African e-Infrastructure.

# Introduction and Background.

## SAGrid and the African-Arabia Regional Operations Centre

The South African National Grid was created in 2008, through the agreement of several national laboratories, universities and research groups which formed a federated distributed computing infrastructure based on the grid computing paradigm. The premises for its creation included of course the success of the WLCG and EGEE projects, however the main interest did not come from the high-energy physics experiments, but from institutional departments providing information and communication services. Close collaboration with the South African National Research Network ([SANREN](http://www.sanren.ac.za)) and other cyberinfrastructure initiatives, resulted has resulted in a fully-functional national grid initiative.

<figure>
  <img src="{{site_url}}/images/sagridmap.png">
  <figcaption>Schematic diagram of the South African National Grid, showing functional sites and site personnel, overlaid on the backbone of thhe national research network.</figcaption>
</figure>

<!--- Describe the interaction between SAGrid and other scientific communities such as bio and astro -->

Similar activities have been undertaken throughout the Arab world, comprising the countries of North Africa and the Arabian peninsula. Investments co-funded by the European Commission have culminated in mature national grid infrastructures in Morocco and Algeria, whilst the Arabian states regional research network [ASREN](http://www.asren.org) has been supporting the integration of individual resources in other countries across the region. These initiatives in the north and south of Africa shared many technical and operational characteristics with each other, as well as similar initiatives in Europe and other regions. In an effort to harmonise and sustain them, two FP7-funded projects were conceived. The first - [Coordination and Harmonisation of Advanced e-INfrastructures](http://www.chain-project.eu) focused in particular on the interoperability of regional infrastructures, through the creation of ***Regional Operations Centres***. One such was created for the entire region of Africa and Arabia, coordinated by ASREN and the CSIR Meraka Institute. The [Africa-Arabia ROC](http://roc.africa-grid.org) exists through an MoU signed with [EGI.eu](http://egi.eu) to ensure that the resources and services provided in the region are interoperable with their European counterparts and vice-versa.

<!--- include map of AAROC -->

There exists thus a pan-African collaboration which provides a solid, interoperable computational platform on which to conduct scientific research. It is particularly adapted to collaborative research, and resources are in principle shareable and for collective use across institutional and national boundaries. Let us now consider closer the motivations and drivers of usage of these infrastructures.

<!--- perhaps these sections are not necessary.

# Reducing Barriers to Access

Access to the grid (or cloud) has traditionally been made via the use of personal x.509 certificates issued by accredited Certificate Authorities. Assuming that the user even has access to an accredited Certificate Authority - or even knows that such things exist ! - this immediately erects a barrier to entry. The user has to contact in person a Registration Authority of the relevant CA, and then have the prerequisite understanding of how to use the certificate. The shortcomings of using personal x.509 certificates for access to public infrastructure effectively mean that only a privileged few can immediately access these services - the "technical elite" which know how to use them, or the users who have dedicated and local support services. While it is necessary to maintain the strict security of the actual infrastructure using x.509 PKI, the barrier erected by prescribing *user* access to these services with personal certificates needed to be at least reduced, if not removed altogether.

## Identity and Authorisation

Centralised authorisation and authentication strategies are inherently at odds with a distributed federation of services; an identity *federation* would provide a more relevant service. In the past, neither such a federation, nor the technologies to bridge such authentication schemes with the necessary x.509 security infrastructure, were mature enough to put into production. However, recently several SAML-x.509 bridges[^SAMLbridges] have been demonstrated, particularly via the use of robot certificates[^robotcerts].

Github authentication strategy

github committer authorisation strategy

--->

Whilst this *in principle* provides an excellent platform for science, the reality for users is somewhat more complex and less optimistic.

# e-Infrastructures for scientific research

These multi-national collaborations are a means to an end and not a goal in their own right: they have been created to support collaborative, innovative research, particularly collaborative research projects heavily reliant on computational methods. These infrastructures do not exist in a vacuum either, but from a user's perspective represent rather merely one of many resources available.

## Complexity Heterogeneity of Computational Infrastructures

Users and communities have, on the contrary, a baffling array of platforms, resources, services and infrastructures on which to conduct their research. Service grid infrastructures, single HPC resources, peer-to-peer networks, public and private cloud services at various levels, desktop grids and even their own individual personal computers all present attractive options for various tasks. This heterogeneity and complexity has in some contexts been coined "jungle computing"[^jungle] and has severe consequences on the delivery and maintenance of applications which run on the various endpoints.

<figure>
  <img src="{{site_url}}/images/junglecomputing.svg">
  <figcaption>Schematic diagram of "jungle computing" depicting several of the many available resources for researchers to execute scientific applications.</figcaption>
</figure>

In an environment where timeous delivery to *optimised* applications is crucial to scientific discovery, the effort to integrate or deploy these applications on the various platforms can be a serious inhibitor. A further, more severe consideration is that errors or misconfigurations may even result in *different results* given by the same applications on different platforms. Furthermore, access to and efficient usage of these applications by the researchers in questions, on the various platforms, can become prohibitively complex in the absence of some coordinating system. Consider the overhead of  maintaining the description of the various optimisations (compiler flags, linked libraries, etc), not to mention access credentials, etc. The situation quickly becomes unattractive to the user, despite having in principle a very powerful set of resources at their disposal.

## The Role of the Research Software Engineer

The natural tendency of users to experiment with new tools is thus at odds with the natural tendency of infrastructure providers to consolidate and simplify their service offering. While users desire to have the best of all worlds, with as many applications at their disposal as they need, immediate and professional support from providers, and high-performance at all times, infrastructure providers desire to limit the commitments and technology porfolio, so as to provide the best service possible to key customers, with the limited resources available. This scenario however assumes a binomial economy of services, where one side exclusively provides and the other exclusive consumes the services available. In reality there is (at least) a third component to this service marketplace, which we will term the Research Software Engineer. This role is emerging in some areas as a fundamental bridge between the polar opposites of the provider and consumer. The research software engineer may both use and develop the services offered by providers, and are often active scientists in their own right, perhaps fulfilling the role of technical development and support within their own community.

Even though these roles have the relevant knowledge and skills to enable the usage by their communities on the various infrastructures, the current access mechanisms for the most part exclude them from accessing the means by which to deploy and integrate applications. Typically, deployment of an application on a site is only possible by having elevated privileges, which are of course strictly controlled and limited to the site owners, or administrators of Virtual Organisations[^VOsnoteverywhere].

<!-- Integration and Continuous Integration -->

<!-- Delivery and Continuous Delivery -->


<!-- How was Integration and Delivery done in the past ? -->

# Analysis of the Status-Quo

Before addressing the solution to the problem, let us first describe the problem itself. This is best done through considering the typical workflow of a new application request. Since at the time of writing there is only one distributed computing infrastructure, based on the grid paradigm and using grid middleware to integrate HPC sites, we will describe only this category.

## The Execution Environment

In general, in order to *execute* applications, an execution environment is required. This may be interpreted at various levels to be

  * a shell, on top of an operating system,
  * a kernel with a set of system-level libraries which are loaded at runtime.
  * a compiler and low-level libraries which are used to generate a binary
  * an API against which calls are made

In SAGrid, and for the rest of this article, we refer to **the environment which which the application is provided when it is scheduled on a worker node**. This implies a set of available

  * libraries (*e.g.* `libc`, `libgfortran`, `libpython`)
  * compilers (*e.g.* `g++`, `gfortran`)
  * system-level commands (*e.g.* filesystem commands - `cp`, `mv`)
  * shells (*e.g.* `bash` and associated libraries and binaries)

A full description of the execution environment can be found at [^executionEnvironment].

## Workflow of new applications

### Discovery

New users are often discovered during interactions at conferences, workshops, seminars etc. On rare occasions, they "pop-up" from nowhere on the internet, but often the bulk of the information exchange is done over email. Since the VO software manager or site administrator are the only ones who have the authority to deploy applications, these are required to be involved in the initial discussion regarding the needs of the user and the application. This initial step of *Discovery* is making superfluous demands on the site admins and removing control from the user.

### Porting

Porting of applications refers to the analysis of the prerequisites, usage model and resource requirements of the application, and adapting these to what is available on the execution environment of the grid.

# Hypotheses for the next Iteration



# Customisation of the platform

<!-- which plugins do we use and why -->


# Stuff we are doing wrong we could do better

1) The monolithic repo.
2) The SSHFS filesystem vs an NFS for the build artifacts.
3) Not using a job per version of the software.
4) I am of the opinion we should use more than one job per application.
5) We setup the jobs by hand - which constrain points 3 and 4


solutions :
1) split the monolithic repo
2) move to nfs
3) clean up mess caused by 1 andhttp://www.abinit.org/ 2
4)

# Footnotes and References

[^SAMLbridges]:
[^robotcerts]:
[^jungle]: "Jungle Computing: Distributed Supercomputing beyond Clusters, Grids, and Clouds." Seinstra, F. J., Maassen, J., van Nieuwpoort, R. V., *et al.* 2011, in **Grids, Clouds and Virtualization**, p 167
[^VOsnoteverywhere]: Bearing in mind of course that the concept of Virtual Organisations is not supported everywhere.
[^executionEnvironment]: damn, need to write another article.
