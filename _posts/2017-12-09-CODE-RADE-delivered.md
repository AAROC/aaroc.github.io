---
layout: post
title: 'Delivering Execution Environments'
description: 'Putting 12factor to use'
headline: 'AAROC  <i class="fa fa-heart"></i> users'
modified:
category: blog
tags: [CODE-RADE, Environments, Docker, Jenkins, Ansible, Continuous Delivery]
image:
  feature: delivery.jpeg
  attribution:
comments:
mathjax:
discourse: true
---

We've shipped a lot of applications in the CODE-RADE CVMFS repository, and the project is getting some nice attention from kindred spirits intent on solving the application delivery problem. 
It's time to put a bit more focus on the user experience

# CODE-RADE runs everywhere

One of the main selling points of CODE-RADE is that the applications in it are built for _arbitrary_ environments.
This is a big claim !
Design decisions have been made to make this achievable, in particular building large matrices of project configurations, for various sites, processor architectures, operating systems, versions and dependencies.
However this is all relevant on the CI side, not necessarily on the user's side.
A user doesn't have an _arbitrary_ enviroment, they have a very _specific_ environment - and they're usually quite attached to it !
It would be nice to offer a "quickstart" environment to the curious, without making any assumptions about where it will be running.
If we have designed the platform correctly, we should be able to execute the applications in it in arbitrary environments, but we'll only be able to _show_ that if we actually _provide_ the environments.

This post deals with how we've started work on delivering the execution environments for Docker, OpenStack, and Vagrant users.
We'll focus on the Docker environment, because that's the easiest. If you'd like to skip ahead and see how we've done it, go straight to <a href="#Figure1">Figure 1</a>.

# One role to rule them all

## Environments 

When we to the "execution environment", we mean the environment which is using the products built by CODE-RADE.
This is not to be confused with the _build environment_, which is used to build the products.
You might be waving an accusatory finger at us at this point, for not respecting [Dev/Prod parity](https://www.12factor.net/dev-prod-parity) - why do we have different environments for build and prod ?
The answer is that the build environment is more focussed towards _compilation_ and _testing_, whereas the prod environment merely needs to _execute_ - there is no need to burden it with compilers, libraries and tools which are not needed outside of  the test environment.
So, the _test_ environment is a bit different from the _dev_ environment. 

That being said, the actual dev environment should be the same as the prod environment - and what is more, there is more than one of these[^CODE_RADE_Hypothesis_3].

## One codebase

Making no assumptions about the execution environments means that we need anticipate many different environments which users could be executing the applications in.
This may seem like an onerous task, but the magic of DevOps comes in.
Still following the 12factor pattern, we maintain only 1 code base which is used in several deploys[^OneCodeBase] : 
[cvmfs-client-2.2](https://github.com/AAROC/cvmfs-client-2.2).

This is an [Ansible role](http://docs.ansible.com/ansible/latest/playbooks_roles.html), which you can use via [Galaxy](https://galaxy.ansible.com/AAROC/cvmfs-client-2-2/), and which indeed is used to express the various environments in which you can use CODE-RADE.
This same role is used when expressing three different environments : 

  - Docker containers
  - OpenStack machines
  - Virtual Machines

The role is developed independently of the environments, and is designed to simply mount the the repository in an uninvasive way.
This role is also tested independently (more on that later), and then used to express the user environments we referred to above.

# Continuous Delivery

Nowadays, no project worth its salt will provide a quickstart without a Docker image.
Our first challenge therefore is to provide something that we can `docker run`.
From the user's perspective, this usually comes down to browsing to the registry page which has that app, pulling it and running it, but we need to ensure a _continuous delivery pipeline_.
That means that all changes the role need to be tested (in a testing environment), built (into a re-usable format) and delivered (to the registry or store).

## Docker

In the case of Docker, this is done by testing the role, then using the role to build an image, and pushing that image to a docker registry[^Quay].
The flow is described in <a href="#Figure1">Figure 1 below</a>

<div class="figure text-center" id="Figure1">
<img src="{{ site.url }}/images/code-rade-exec-flow.svg">
<figcaption>Figure 1: Workflow to enable continuous delivery of the dockerised execution environment.</figcaption>
</div>

This is the "easiest" in a sense, because we only need to build one image, there is a pre-existing and publicy-available registry to get the image from and the user only needs a Docker environment to run it.
Without any extra tooling, one can simply do a `docker run` and have CODE-RADE.
But what about the other environments - running virtual machines on one's own laptop, or using prebaked images in a private cloud ?

## Virtual machines

Virtual machine images are not as easy to distibute as Docker contianer images, because there isn't a widely-accepted, publicly available registry where we can push to, and users can pull from. Sure, there are community-maintained registries such as the [EGI AppDB](https://appdb.egi.eu), and images stores in individual cloud image stores. 
We want to maintain the pattern of one codebase, so we should build these all from the same Anisble role.
This role can be used by whatever provisioning system the using site may have: Foreman, Packer, Terraform, Chef, _etc_.
We will provide a default means to build and deliver these images, using the same Ansible role, with Packer: 

{% highlight yaml %}
"provisioners": [
    {
    "type": "ansible",
    "playbook_file": "cvmfs-client-2.2.yml"
    }
{% endhighlight %}

where the playbook to run is extremely simple: 

{%  highlight yaml %}
- hosts: all
  name: Enable CVMFS
  become: true
  roles:
    - cvmfs-client-2.2

{% endhighlight %}

Now, we can use the same Packer configuration to build VMs for our local VirtualBox, a remote OpenStack glance, or any variety of other endpoints[^PackerEndpoints].

# Summary

CODE-RADE is designed to build and delivery arbitrary research applications to arbitrary execution environments.
While we have covered the continuous integration and delivery of these artefacts in previous articles, we haven't yet focussed on how we deliver the actual execution environment.
This is done with every effort to respect the 12factor application pattern, particularly respecting the goals of 

  - having one code base
  - maintaining dev/prod parity
  - using declarative formats

We've provided an [Ansible role](https://galaxy.ansible.com/AAROC/cvmfs-client-2-2/)[^cvmfs_client] which can be used to provision these arbitrary environments, with a wide choice of provisioning systems.

This work should significantly reduce any barriers to using the CODE-RADE platform, from a user point of view.


# References

[^CODE_RADE_Hypothesis_3]: See CODE-RADE Hypothesis 3. 
[^OneCodeBase]: See 12factor.net , [factor 1](https://www.12factor.net/codebase). "One codebase tracked in revision control, many deploys"
[^Quay]: We use [Quay](https://quay.io/organization/aaroc) for our images. It's just better, you know...
[^PackerEndpoints]: Packer has a [large variety](https://www.packer.io/docs/builders/index.html) of options for builders.
[^cvmfs_client]: Bruce Becker, & Sean. (2017, August 4). AAROC/cvmfs-client-2.2: CODE-RADE cvmfs client role v1.1.2 (Version v1.1.2). Zenodo. http://doi.org/10.5281/zenodo.839002 [![DOI](https://zenodo.org/badge/63867294.svg)](https://zenodo.org/badge/latestdoi/63867294)

