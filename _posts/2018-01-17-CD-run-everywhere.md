---
layout: post
title: 'Delivering CODE-RADE environemnts'
description: 'Perfectly-crafted environments'
headline: 'AAROC  <i class="fa fa-heart"></i> automated delivery'
modified:
category: blog
tags: [CODE-RADE, Environments, Docker, Jenkins, Ansible, Continuous Delivery]
image:
  feature: "igor-ovsyannykov-284219.jpg"
  attribution: <a style="background-color:black;color:white;text-decoration:none;padding:4px 6px;font-family:-apple-system, BlinkMacSystemFont, &quot;San Francisco&quot;, &quot;Helvetica Neue&quot;, Helvetica, Ubuntu, Roboto, Noto, &quot;Segoe UI&quot;, Arial, sans-serif;font-size:12px;font-weight:bold;line-height:1.2;display:inline-block;border-radius:3px;" href="https://unsplash.com/@igorovsyannykov?utm_medium=referral&amp;utm_campaign=photographer-credit&amp;utm_content=creditBadge" target="_blank" rel="noopener noreferrer" title="Download free do whatever you want high-resolution photos from Igor Ovsyannykov"><span style="display:inline-block;padding:2px 3px;"><svg xmlns="http://www.w3.org/2000/svg" style="height:12px;width:auto;position:relative;vertical-align:middle;top:-1px;fill:white;" viewBox="0 0 32 32"><title>unsplash-logo</title><path d="M20.8 18.1c0 2.7-2.2 4.8-4.8 4.8s-4.8-2.1-4.8-4.8c0-2.7 2.2-4.8 4.8-4.8 2.7.1 4.8 2.2 4.8 4.8zm11.2-7.4v14.9c0 2.3-1.9 4.3-4.3 4.3h-23.4c-2.4 0-4.3-1.9-4.3-4.3v-15c0-2.3 1.9-4.3 4.3-4.3h3.7l.8-2.3c.4-1.1 1.7-2 2.9-2h8.6c1.2 0 2.5.9 2.9 2l.8 2.4h3.7c2.4 0 4.3 1.9 4.3 4.3zm-8.6 7.5c0-4.1-3.3-7.5-7.5-7.5-4.1 0-7.5 3.4-7.5 7.5s3.3 7.5 7.5 7.5c4.2-.1 7.5-3.4 7.5-7.5z"></path></svg></span><span style="display:inline-block;padding:2px 3px;">Igor Ovsyannykov</span></a>
comments:
mathjax:
discourse: true
---

# How do we get CODE-RADE where it's needed ? 

CODE-RADE is a repository of pre-built applications for arbitrary environments - just mount the CVMFS repo, add the relevant application to your shell, and boom you're down with the science.
But kids these days are all about the instant gratification.
They don't want to sit around editing configuration files, running playbooks! If you can't give them a docker image to run, they will pass you right by as if your awesome project didn't even exist.

##  Maintaining the Cambrian explosion

In the container world this is almost trivially easy in most cases - just build the container any way you know how and push that baby to a public registry.
But what happens when the number of applications you need to maintain starts rising fast ?
How does one ensure that the images for all of those containers are maintained, secure, functional, available ?

In CODE-RADE, we solve this by having a single source for expressing _any_ of the environments, and factoring the actual applications out of it.
The applications are built and tested atomically, but the test, stage and prod environments are kept exactly the same[^12Factor_dev_prod_parity].

[Last time](../{{ page.previous.url }}) we spoke about ensuring access to persistent products across build stages; this time we'll discuss how we create the actual build, test and production environments from the same [Ansible Role](https://github.com/AAROC/cvmfs-client-2.2)[^CVMFS-role], using a Jenkins pipeline.

## Continuous Assurance

A word about prod, before we show how we do this.
Operations people are famously queasy about pulling new applications into their perfect prod environment.
In the cloud world this is inevitably exacerbated, what with the "bring your own appliance", and the aforementioned kids these days pulling Docker images that some random guy on the corner built for them, like they're popping painkillers[^apologies].
How can we assure the infrastructure providers that these appliances are actually safe and do what they say they will do ?
Well, our solution has typically been : "Get the infrastructure providers to tell you".

By this, we mean : if the infrastructure providers can come up with the assertions that will convince them that the appliance will play nicely with their policy, we can submit the products that we build to these tests automatically. 

Have the means to transparently verify and audit the result of tests run against execution environments themselves (independently of the actual applications), allows us to better convince infrastructure providers to allow us to run on them. 

# Shipping the CODE-RADE execution environment

There's a common saying these days : 

> X as code

where X can be interpreted as "infrastructure", "compliance", _etc_. 
This saying expresses the desire to have tasks expressed as some thing which can be _executed_, _automated_ and _tested_.
It belies our belief that things which are built this way are more reliable, durable, resilient than those built requiring manual human intervention.
It implies that we can and should express our strategies and solutions in some concrete, objectively-verifiable form, making whatever we build easier to understand and easier to collaborate on.
We have tried to do this in the case of the CODE-RADE execution environment.

## Ingredients

We've built a pipeline which produces executable environments (Docker images, KVM or OVA images) from something very similar to plain English (YAML - or rather, an Ansible role).

### A single source of truth

It's important to note that there is **only one** entry point to the pipeline - the Ansible role itself.
This means there is **only one** thing to debug, **only one** place to make changes.

### To each his own

From this unique source of configuration, we can diverge into different _environments_ which will each have their peculiarities - some will have stringent policies to respect; others will be lightweight, and yet others will assume some further constraints on the environment given special hardware.

All of these different environments can define their own tests, and these tests can all be kept with the role itself[^using_molecule].
It is important that the tests themselves are kept in synchronisation with the role so as to avoid undesirable "he said/she said" arguments with operators of various platforms - we want to run their exact same tests in our pipeline as they have onsite.

### Arbitrary platforms

When we say "Execute everywhere", what we really mean is that products of the CODE-RADE platform - the tested and built scientific applications - can  be executed in arbitrary environments.
In practice, we need to build the environments and _ship_ them to the platforms which infrastructure providers offer to users (unless of course the infratructure provider is the user themslef, _i.e._ running stuff on your own laptop).
In a cloudy world  these platforms are typically virtual machine or container orchestrators, _i.e._ things like OpenStack, AWS, Azure, Kubernetes, OpenShift, _etc_. 


## The CODE-RADE execution environment pipeline

<figure id="CODE-RADE-flow"> 
<img src="{{ site.url }}/images/CODE-RADE-env-delivery.png">
<figcaption>The CODE-RADE pipeline for delivering the execution environment for a few specific platforms. Green arrows represent successful flow, red arrows feedback from failure events.
</figcaption>
</figure>

### Trigger, Build, Test

In <a href="#CODE-RADE-flow">the figure above</a>, we show a schematic diagram of the delivery pipeline.
As we mentioned in <a href="#a-single-source-of-truth">the previous section</a>, everything starts with any changes committed to the repository which contains the Anisble role expressing the environment.
When changes are made, our [Jenkins](https://ci.sagrid.ac.za) is informed and triggers a build and the pipeline starts. The pipeline makes use of Molecule during the build and test phase.
Both the container image and the virtual machine images are built, by using the local Docker API and an OpenStack Nova API[^VespaOpenStack].

At any point in the pipeline if a stage fails, an issue is opened against the repository and the developer is informed that their pull request or commit requires attention.
If the build passes successfully, the next phase of the pipeline is triggered - testing.
We take the tests defined by the application itself, as well as the downstream infrastructure providers [described above](#continuous-assurance) and run them against the provisioned instances (either Docker containers of VM's spawned in the cloud).
This is done in practice with [TestInfra](http://testinfra.readthedocs.io/).

### Deliver !

If tests pass, it's time to deliver that sucker !

This is done by using the relevant tool to push the relevant artifact to the relevant registry.
From here, we expect that production environments will _pull_ that artifact from the registry _as needed_ (_i.e._ when changes are detected, or once every user-triggered request).
The job of the pipeline is to ensure that : 

  1. The registry always has the _latest_ version of the image
  1. The registry always has a _tested_ version of the image
  1. Users of the image can always correlate an _artifact_ with the _build_ and _change_ that generated it.

In practice, we use [Packer](https://www.packer.io) with an [Ansible provisioner](https://www.packer.io/docs/provisioners/ansible.html) - using the **same code that was used during the build and test phase** to deliver the VM, and Ansible Container to push the image to a registry[^quay].
Thus, in any given cloud platform, if we have the credentials to it, we can push an image of the environment necessary to use applications in the CODE-RADE repository.

# Getting to production

But what about _arbitrary_ platforms, or platforms which we can't predict will want to use our images ? 
Since we can't predict which platform will be used, we certainly can't have access credentials to it.
Instead, we must rely on these platforms _pulling_ the artifacts, after being somehow _notified_ about their existence or changes to them.
This can be done if there is some form of central registry like the [EGI Applications Database](https://appdb.egi.eu) which contains metadata of appliances which sites use to provision environments triggered by user requests. 

After having had a short email exchange with the developers of the AppDB, and EGI User Support groups, we will propose in the next article how to include this endpoint in the CODE-RADE continuous delivery pipeline. Special thanks to **Marios Chatziangelou** and **Giuseppe La Rocca** for valuable comment, feedback and suggestions.

# References and footnotes

[^12Factor_dev_prod_parity]: Here, we maintain the [Dev-Prod parity](https://12factor.net/dev-prod-parity) required in 12 Factor applications.
[^CVMFS-role]: Bruce Becker, & Sean Murray. (2017, August 4). AAROC/cvmfs-client-2.2: CODE-RADE cvmfs client role v1.1.2 (Version v1.1.2). Zenodo. http://doi.org/10.5281/zenodo.839002
[^apologies]: With apologies to [David Gilbertson](https://hackernoon.com/@david.gilbertson), this bit was inspired by [his article](https://hackernoon.com/im-harvesting-credit-card-numbers-and-passwords-from-your-site-here-s-how-9a8cb347c5b5)
[^using_molecule]: By far the easiest way to test Ansible roles in various scenarios I've found is using <i class="fa fa-github"></i> [molecule](https://github.com/metacloud/molecule)
[^VespaOpenStack]: We would like to thank the University of Catania for their generous support in providing the test environment, via the VESPA project OpenStack installation. Special thanks to @mtorrisi.
[^quay]: We use [Quay.io](https://quay.io/organization/aaroc/) as a default registry.