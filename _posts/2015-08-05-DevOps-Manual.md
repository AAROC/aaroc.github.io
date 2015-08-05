---
layout: post
title:  '"Manual" vs "DevOps" - which is better ?'
description: 'How should we teach the deployment, operation and maintenance of e-Infrastructure services ?'
headline: "Of course, both."
category: blog
tags: [blog, DevOps]
image:
  feature: sciencepattern.png
  attribution: http://thepatternlibrary.com/#science
comments: true
mathjax:
discourse: true
---


This question arose during an email exchange with colleagues from [CESNET](http://www.cesnet.cz/?lang=en) recently, in the context of the upcoming [workshop on identity federations](http://osscom2015.osscom.org/?q=content/workshop-joining-eduroam-and-identity-federation) at the [OSSCOM](http://osscom2015.osscom.org/) conference. There will be an _install fest_ :tada:

# How should we teach and collaborate ?

This is great, but there are different philosophies about going about this. Essentially, everyone can agree that we don't want to have "black box" solutions for eduroam and other federated identity services - this may solve an immediate need, but can create a clientele system where remote experts are needed to operate local services. Also, everyone can agree that _learning_ how services work is a good idea, and that _knowledge transfer_ is part of the desired process.

The question then becomes - **How do we teach the installation, operation and maintenance of these services in a sustainable way** ?

While a student is in the classroom, during the event, it's arguable - but by no means guaranteed - that they will have a clear understanding of the technology thanks to their contact with the demonstrator/lecturer ; but what about those who are not able to attend ? What happens _after_ the event ?

The approach we've taken in the [Africa-Arabia Regional Operations Centre](http://www.africa-grid.org) is to develop functional descriptions of services using [Ansible](http://www.ansible.com) and [Puppet](http://www.puppetlabs.com) which not only _document_ the procedure, but also _implement_ it.

# Procedures versus states.

So, while a manual, step-by-step approach can highlight and explain aspects in a procedural way, a DevOps approach can do the same, but in an _idempotent_ way. The difference is that if you go through the manual and follow all the steps to a tee, you should end up with a working system. Ok great ! Now, peturb that system a little - change a variable, update a package, etc - the manual is out of date and needs to be followed again from the starting point. Also, configuration drift can easily occur and usually can't be remotely verified without some form of intrusion (either authorised or not...)

On the other hand, an Ansible playbook makes statements about the desired _state_ that aspects of a service should be in -

  * `a certain file should exist and have certain contents`
  * `connectivity to this host should happen on such-and-such a port`
  * `a certain process should be started and should belong to a certain user`

It lets the developer focus on the _what_ and leave the _how_ to the orchestration engine.

> This is code.

And as code, it can be version controlled, tested, forked.


This is why we are pushing the DevOps model, and encourage anyone in the region to collaborate with us by using and contributing to the [DevOps](https://github.com/AAROC/DevOps) repository. We hope to do the same for radius server installation and are planning to do this for the Shibboleth-3 deployments soon after August.

# Reproducible deployments

By abstracting and co-ordinating _roles_ (ie, services configured in a certain way) we can allow sites to easily whip up complex  configurations of services quite easily. But best of all, it's reproducible. We can and do test roles while developing them, and this provides us with good reference examples (this is done in the `dev` branch, if anyone is listening). Once these are known to give the desired end states, they can be forked and used to instantiate specific states, using different variables site by site. This makes it easier to identify and resolve problems - as well as make the return on investment in time spent during a workshop far greater.

So - will you teach the "DevOps" way in your next eduroam, identity federation, `<insert_service_here>` workshop ?
