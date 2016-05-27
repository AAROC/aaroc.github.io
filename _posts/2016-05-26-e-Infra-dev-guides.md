---
layout: post
title:  'e-Infrastructure and Science Gateway Development Guides'
description: 'Part of the Sci-GaIA deliverable series'
category: blog
tags: [blog, VO, gLite, grid]
image:
  feature:
  attribution: ""
comments: false
mathjax: false
discourse: true
---

We had a discussion yesterday about Deliverable 1.1 - **"e-Infrastructure & Science Gateway Development Guide for NRENs and Communities of Practice"**. I would like to have some further discussion on the scope and content and explain what we've got so far in the ROC.

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Scope](#scope)
- [Deployment guides](#deployment-guides)
	- [Upstream providers](#upstream-providers)
	- [Services covered](#services-covered)
- [Operations Guides](#operations-guides)
- [Where to find material](#where-to-find-material)
	- [DevOps Documentation](#devops-documentation)
	- [Services and components](#services-and-components)
- [Summary](#summary)

<!-- /TOC -->

# Scope

The deliverable talks about development guides but we are really referring to _deployment_ guides, except in very few cases. It doesn't make sense to talk about middleware development guides, since the the middleware development guides are scoped purely to the few projects which are actually developing the middleware. However, it _does_ make sense to talk about community portal and science gateway development guides, I think, since these are always somewhat different from each other.

# Deployment guides

Which ***deployment*** guides are we talking about here specifically ? The starting assumption is that the intended audience is on the *ops* side of the field and that. People in ops are expected to provision the relevant hardware and use the relevant orchestration tool to deliver the service. In most cases, this means running an Ansible playbook against an inventory. The guide here should tell the operator :

  1. What suggested resources to provision
  1. What their inventory should look like
  1. Which playbooks are relevant
  1. Which variables need to be configured

The model is that _services_ map to _roles_ and these _roles_ are the responsibility of the _dev_ side. The developers of the ROC team are responsible for developing and testing their roles, while the site administrators are responsible for deploying the services accordingly. This nice, clean model can never work 100% in practice, due to the scale, scope and heterogeneity of our ROC, so it  should be treated as _just a model_. The general principle however that services are encoded into something that is executable should be upheld.

In the case of services deployed with Ansible, the information and required action referred to above should be written in the README relevant roles. The roles thus express the services, albeit in an abstract way. The playbooks which express the "proper" way of deploying services, and thus combined with the group variables of the site, as well as any specific customations that the site may want to apply, are the specific expression of how those services are instantiated.

## Upstream providers

Where we are consumers of middleware from upstream providers, such as in the case of FedCloud or grid sites, the documentation of the service as provided by the middleware provider should be used as the reference material, and we should avoid re-writing site administrator and user manuals. However, a series of pages may be maintained describing issues arising, workarounds, specific tweaks and aspects _not_ covered in the upstream documentation. The goal is to avoid writing as far as possible, since this has implications for future commitments.


## Services covered

This section describes what services need to be covered. We consider services which make sense to talk about in the context of the Regional Operations Centre, which goes beyond compute and data services, but stops short of NOC-level services. In terms of the Virtual Research Environment stack, with user-facing applications on the top and network infrastructure on the bottom, we should cover the services which are _not_ in the domain of either the user community themselves or the underlying site _resource_ owners. These are :

  1. Catania Science Gateway Framework
    2. web application container
    3. tracking database
  2. Federated Identity Services
    3. Federated Identity providers
    4. Local identity store
    3. Federated Service providers
  1. Open Access data repository
  2. Identity Management service (ie Perun)
  1. Grid Services
    2. Site services (According to [EGI RC OLA](https://documents.egi.eu/document/31))
      3. information provider capability
      4. compute capability
      5. storage capability (optional)
      6. accounting capability
      7. user interface (optional)
  1. FedCloud services (According to [EGI FedCloud Manual](https://wiki.egi.eu/wiki/MAN10) )
    2. Cloud management framework (OpenStack/Synnefo/OpenNebula)
    2. Information provider capability
    3. Accounting capability
    4. VM replication capability
    5. OCCI endpoint (optional)
    6. Nova endpoint (optional, for Native OpenStack)
  3. Core services
    4. Top-level information provider capability
    5. monitoring capability
    6. workload management capability (optional)
    7. metadata service (optional)
    8. VOMS (optional)
    9. Data movement service (optional)

This may be expanded upon later. In particular it would be nice to have at least a default implementation of HPC cluster deployment, which could be integrated into the ROC via OCCI.

# Operations Guides

The responsibility of the developer to provide documentation and testing of the services ends with the deployment guides referred to above. However, this does not cover the day-to-day operation of the services - what standard procedures need to be taken into account regarding common activities. Since the ROC is a collaboration beyond merely a distribution of resources, these _procedures_ are extremely important.

The operations _guides_ are very sensitive to the operating _environment_. The ROC only needs to define the lowest common denominator in terms of operations producers, on a service-by-service basis, in order to improve the effectiveness of the collaboration. Most of this common set of procedures has  bee written by EGI, and can safely be adopted for use by sites providing sets of the services referred to above. However, sites which are part of large community infrastructure such as H3A, WLCG, Earth System Grid Federation, etc need to ensure that they _also_ respect the operating guides of those communities.

Importantly, we do _not_ yet have guides on how to contribute either to the dev or ops side in most cases. There is a `CONTRIBUTING.md` file (as per the suggested good practice of the [Mozilla Science Working Open Workshop](http://mozillascience.github.io/working-open-workshop/contributing/)) for the [DevOps](https://github.com/AAROC/DevOps) repo,  but it is as yet incomplete. Most of  the other services have no such contribution guide.

# Where to find material

It makes sense that the deployment and operations guides be easily findable from the [AAROC website](https://www.africa-grid.org). To this end, we have created a page [for operators](http://www.africa-grid.org/operators) as well as one for [service developers](http://www.africa-grid.org/developers). The former has sections on :

  * Overview and intended audience
  * Regional Operator on Duty
  * Operational Security
  * Site Operations
  * Deployment guides
  * Reference

Most of these sections still need to be fleshed out entirely.

## DevOps Documentation

We have tried to persuade site operators to commit any relevant _code_ which is used to configure their sites and services to the common [DevOps](https://github.com/AAROC/DevOps) repo - either as a submodule, by sending pull requests from their forks, or by commiting directly where possible. This has the advantage of having most of the functional expression of our services in one place, so that there can be some peer review and oversight. However, since tools such as Ansible and Puppet encourage proper software development principles, including inducing developers to document their code, **we can use this repo to generate a complete set of documentation** for our services.

Using Github Pages, we can also ensure that the documentation is in an easy-to-find place :

> [africa-grid.org/DevOps](https://www.africa-grid.org/DevOps)

This documentation has just been started, and uses the READMEs of the various modules and roles to generate the documentation pages. We still need to write the specific guideson how to define sites, which variables are necessary for which services and so on, but the structure is now in place to commit decent documentation via the repo itself.

## Services and components

Components such as Ansible roles are easy to document since they are abstract and need only refer to internal aspects. However, combining  these components into properly-configured services at  a site, which in turn respect various OLA and standard operating procedures, is a nontrivial task, since it requires some institutional knowledge of the collaboration and the distributed computing platform. We _do_ need to provide human-readable guides at a very high level, as well as the machine-readable guides, in order for newcomers to get bootstrapped as well as work as autonomously as possible.

# Summary

Given the scope of the audience - NRENs, communities of practice, and e-Infrastructure operators - it is a huge ask to develop deployment guidelines for an exhaustive set of e-Infrastructure services. It is also not reasonable to expect that there is a single entry point for _all_ documentation. However, by defining the suite of services as we have done here, we come up with a more formulaic approach to providing documentation for how things are _done_ and what to do when things go wrong. By providing a single page :

> [africa-grid.org/operators](http://www.africa-grid.org/operators)

we can provide a fairly comprehensive anchor for operators of most e-Infrastructure services to refer themselves and their collaborators to.
