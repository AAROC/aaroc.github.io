---
layout: post
title: "WIP: Executable IdP and LDAP services"
description: Some Ansible roles for ldap and shibboleth IdP services are under development 
headline: Some Ansible roles for ldap and shibboleth IdP services are under development
category: DevOps
tags: [DevOps, ExecutableInfrastructure, shibboleth, ldap, identity services, work in progress, update]
image: 
  feature: 
comments: true
---

# TL;DR

As part of the [ei4Africa](http://www.ei4africa.eu) project, we've worked on deploying several identity providers in Africa. Maintaining them has becoming something of a pain. It's time to bring some Dev to Ops; here's where we're at.

We previously released [IDPPublic](https://github.com/AAROC/IDPPublic) - a web interface to allow Identity Provider adminstrators to easily manage their enrolments. However, this pre-supposed a working backend LDAP and [Shibboleth IDP](http://www.shibboleth.net). While we had developed a guide for installing and configuring this, the inevitable config drift occured and some services stopped working. We started dealing with this in the *old-school* - exchanging several emails and config files, but eventually we just ended up logging into a bunch of machines and making changes.

# Nope nope nope nope nope

Logging into someone else's machine is a little like... 

<figure>
  <img src="{{ site_url}}/images/nope.gif">
</figure>

so... we decided to go ***#DevOps*** on that problem.

We're working on an [Ansible](http://www.ansibleworks.com) role to be able to apply an [LDAP role](https://github.com/AAROC/DevOps/tree/master/Ansible/roles/ldap) to the ldap machine and a [Shibboleth role](https://github.com/AAROC/DevOps/tree/master/Ansible/roles/shibboleth-idp) to the shibboleth machine.

The LDAP role has been finished (17/09/2014) and we're working on the shibboleth role. 

# If it doesn't execute, it doesn't exist

Of course, code is cool,but not magic. Just like all good hackers, every commit gets tested. We're using [Travis-CI](https://travis-ci.org/AAROC/DevOps) to do this, but tests will fail until we get the testbed machines provisioned by the cloud at INFN Catania. As soon as we're build-passing, we'll make a nice long writeup.

Until then, the shibboleth-idp services of the Catch-All federation are going to be a bit smoke and mirrors. Stay tuned...


