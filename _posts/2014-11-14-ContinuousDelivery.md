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

Porting of applications refers to the analysis of the prerequisites, usage model and resource requirements of the application, and adapting these to what is available on the execution environment of the grid (see above). This usually implies resolving the dependencies which are actually required by the specific version and configuration of the application, and then providing a script which executes the compilation and installation in VO-specific directories at the remote site. Again this had to be done by the VO software manager.

<figure>
  <img src="{{ site_url }}/images/EGIAppDB-All.svg">
  <figcaption>Summary of all scientific applications registered in the EGI application database</figcaption>
</figure>
<!----
Include the total number of applications
--->

Since there is no general solution to porting applications, but only a general methodology, the procedure has to be done from the start for each discovered application. Considering the number and diversity of scientific applications, this can become a prohibitive bottleneck. Considering *only* the applications registered in the [EGI Application Database](http://appdb.egi.eu) (see figure[^EGIAppDB] above), it is clear that for the infrastructure to indeed be useful as a general-purpose platform for research, access needs to be granted to more than the restricted set of Software Administrators.

Even if we could assign domain-specific contact points, the complexity of the application landscape in domains is such that it remains an overwhelming task to quickly respond to all new requests. The nature of scientific research is often such that applications are updated and created at a rate that scales by that of actual scientific discovery. Since these applications themselves aid scientific discovery, in some cases, this rate can be almost exponential.
<!--- ok, we're exaggerating a bit? --->

<figure class="half">
  <img src="{{ site_url }}/images/EGIAppDB-physics.svg">
  <img src="{{ site_url }}/images/EGIAppDB-bio.svg">
  <figcaption>Breakdown of number of applications in scientific subdomains for physical (left) and biological (right) sciences, taken from EGI Application Database.</figcaption>
</figure>

Of course, these are *just the applications which have already been ported*, and the true number is far larger and increasing - not only in number but also in complexity, as hardware and platforms evolve. Furthermore, we are not counting the *dependencies* of these applications, the integration of which can represent some of the largest barriers. We must thus ask ourselves, if we are building an e-Infrastructure for scientific collaboration and research,

> What is it good for ?

A new model of interaction between service providers and consumers needs to be built, having the characteristics of being distributed, automated trust-based and inherently open. The existing roles of Software Administrator, By integrating existing tools, simulating production environments and applying appropriate access policies and functional tests, we can build a transparent system whereby any researcher can propose a new application, have it tested automatically and allow the software administrator to establish a level of trust even with applications which they have not themselves ported.

# Hypotheses for the next Iteration

From a user's perspective, the motivation of the many barriers erected by the design of infrastructure itself need to be re-evaluated. We now proceed to do so, by forming some hypotheses regarding the usage of research applications, and suggest some corresponding routes of action.

  1. **Hypothesis:** *"It always comes down to an application."*
     - In the final analysis, the new user will request an application or suite of applications which need to be executed.
     - **Suggested Action:** *"Focus on the application"*. Direct all efforts to the characteristics of the application in question.
  1. **Hypothesis:** *"No software is an island."*
     - Everything of use to a user has dependencies, whether they be system-level or supporting software frameworks
     - **Suggested Action:** *"Make these dependencies explicit from the start"*.
  1. **Hypothesis:** *"Applications need an environment."*
     - It is extremely rare for applications to be fully self-sufficient, they need at the very least some form of environment to execute, be it only a shell. Often this is far more, such as specific libraries, environment variables, *etc*.
     - **Suggested Action:** *"Make this environment explicit from the start"*
  1. **Hypothesis:** *"There is more than one environment"*
     - Infrastructure providers cannot be forced to provider a single execution environment and can choose which operating systems. Similarly, users will tend to choose the environment which is right for their applications - whether it be the selection of a particular framework or hardware.
     - **Suggested Action:** *Simulate the various execution environments so that users can access them while porting their application*
  1. **Hypothesis:** *Solutions decay*
     - The process, including the dead ends that led to that specific endpoint, are part of the solution and should be kept in a version-controlled repository. Merely having instructions available on a wiki or such is not sufficient and can often be misleading. Since we are determining the *process* that leads to a specific executable, the process itself should be *executable*.
     - **Suggested Actions:**
       - *Recognise that solutions decay and code for the future*.
       - *Keep solutions in an* ***executable*** *format, in a* ***version-controlled*** *repository.*
  1. **Hypothesis:** *Most work in porting applications can be automated*
     - *Humans need not apply*[^CGPGrey] for certain tasks. They are better suited to application- and service-level integration, since they will be more rigorously repeatable and provide a more robust means for demonstrating the results.
     - This also has the corollary that when humans *do* perform these tasks, they are actually getting in the way of progress - ***less*** human intervention is sometimes required, not more. This is particularly true for testing and integration tasks, where there is a strong motivation to tweak the process and hide details from the user (and peer technical experts), so as to force the passing of tests.
     - **Suggested Actions:** Integrate various software, middleware, version control, testing and infrastrucutre services as far as possible via ***Open APIs***.
   1. **Hypothesis:** *A solution can be implemented*.
      - Continuous integration as a methodology, as well as the tools suited to the job have been around for a good while. The web has been evolving rapidly to enable teams of developers to collaborate on software projects. With minor changes in methodology, the adoption of relevant tools and the integration of services, existing scripts which may be untrustworthy and bug-prone can be transformed into automated jobs for producing cross-platform executable artifacts.
      - **Sugested Actions:** *Use the web to communicate; adopt widely-used automation, delivery and testing platforms*.

# Implementing A better deal for researchers

Considering the hypotheses and suggested actions in the previous section, we propose that this represents a 'better deal' for researchers who want to exploit e-Infrastructure. The barrier to entry is not only lowered, but the bottleneck represented by the Software Administrator has been transformed into a far more accessible access point represented by the integration service itself. Proposing a new application to be ported into the grid (or HPC/cloud etc ) infrastructure could become as simple as sending a pull request to a repository which automatically triggers testing on the desired platforms. However, the details of the implementation need to take into account several other issues:

  1. trust
  2. lifecycle management
  3. delivery

In the first case how can the researcher *prove* to the resource provider that their proposed application will actually run on the proposed architecture ? Functional tests




<!----
# Customisation of the platform
--->
<!-- which plugins do we use and why -->
<!----

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

---->

# Footnotes and References

[^SAMLbridges]:
[^robotcerts]:
[^jungle]: "Jungle Computing: Distributed Supercomputing beyond Clusters, Grids, and Clouds." Seinstra, F. J., Maassen, J., van Nieuwpoort, R. V., *et al.* 2011, in **Grids, Clouds and Virtualization**, p 167
[^VOsnoteverywhere]: Bearing in mind of course that the concept of Virtual Organisations is not supported everywhere.
[^executionEnvironment]: damn, need to write another article.
[^EGIAppDB]: Taken from the EGI Application Database
[^CGPGrey]: This phrase is taken from a great video by [CGPGrey](http://www.cgpgrey.com/) - ["Humans need not apply"](http://www.cgpgrey.com/blog/humans-need-not-apply), describing the advent of mass automation and the effects on society.
