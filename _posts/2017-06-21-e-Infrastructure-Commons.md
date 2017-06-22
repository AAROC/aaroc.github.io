---
layout: post
title: 'Building the e-Infrastructure Commons'
description: 'Putting some form to a vague concept'
headline: 'How do you build something that nobody owns and everybody needs ?'
category: blog
tags: [licenses, infrastructure, commons]
image:
  feature: 15450651050_39f1616cb7_o.jpg
  attribution:
comments: false
mathjax: false
discourse: true
---

_update : Added a few comments on making the commons tangible_


In this post, we bring together two ideas which have helped to inform how we build the Africa-Arabia Regional Operations Centre - "executable infrastructure" and the "e-infrastructure commons".

<div class="center">
<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Beginning to worry that &quot;commons&quot; like &quot;excellence&quot; is a word we can all agree on, by avoiding having to admit we don&#39;t know what it means..</p>&mdash; CⓐmeronNeylon (@CameronNeylon) <a href="https://twitter.com/CameronNeylon/status/877808136220012544">June 22, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
</div>

We would like  to put some form to these vague concepts, and hopefully this form will provide better encouragement for those involved in the ROC - resource owners, operations specialists, developers, contributors of all kinds - to continue their support. At a bare minimum, we would like to have a public statement of intent, which contributors can decide whether or not to endorse.  A web page that says something like

> Infrastructure is for all, and it takes form in code.
> We recognise the following principles ...
> If you do too, sign the contributor agreement and contribute your infrastructure code to the commons.

Then we would have a form of non-binding adherence to a code of conduct which encourages the contribution of code for building infrastructure, to a repository.

# The commons, the commoners

Underpinning all of  this is the _"infrastructure as code"_ paradigm - a way of representing the physical hardware, the operating systems, the applications, and all of the connections between them, **in software**. This paradigm goes hand-in-hand with the **"DevOps"** movement, and implies a growing set of tools and workflows for expressing, testing, and delivering fully-functional platforms.
This is what we are all about in the ROC, with the added complication that we are a **federated**, **distributed** infrastructure aiming to offer resources to a wide range of scientific groups via more or less unique interfaces.
We want everyone using the services in the ROC to be able to do so in the same way (or at least, however they prefer), across all of the sites.

We use code for this - configuration and orchestration software. It may be "meta", but it's still code, and it is just as tangible a representation of our actual infrastructure and services, once it is executed, as the hardware itself.

However, we now run into some long-standing general issues around _sharing_ software. There are several legal issues (liability, ownership, copyright, _etc_ ) which, although considered since the start of the Free Software Movement, take on subtle implications now that we are building infrastructure. We want to have a framework which makes it not only **easy** for collaborators at institutes to contribute their code, but downright **attractive**.

Why should an institute working on orchestration for a compute service, a cloud platform, or a data infrastructure, or a science gateway, or an identity management system wish to contribute that code to a repository  ?
This brings into light the idea of the "commons"[^FertileDelta].

# Why are we doing all this ?

There is a tug towards the opening of access and participation to the products of publicly-funded research, and parts of the Open Science movement are due to this tug. This often addresses scholarly communication and research objects like data sets and other research outputs.
The [H2020 guidelines on dissemination of research outputs](http://ec.europa.eu/research/participants/docs/h2020-funding-guide/cross-cutting-issues/open-access-dissemination_en.htm) states that  grant winners have to deposit (publish) the data, software, and other output... but they do not say anything about the actual infrastructure that is built. If we consider that our infrastructure is code, it's not a huge leap to expect

What does e-IRG say ?

The [2016 e-IRG Roadmap](https://eirg.eu/roadmap) states in section 5.4 :

> Another area of legal issues concerns software licenses. Software licences should allow free use (but not necessarily free of charge) by different scientific communities via the communication (network) infrastructure. Other areas have been dealt with in the past and progress has been made with the recent laws in the areas of State Aid, Data Protection and Network Regulation developed at European level.
> Scientific software offered by national, regional and disciplinary centres is (and should be) under special licenses tailored to the local requirements negotiated by software licence providers.
>
> **Software tools provided as a service under the e-Infrastructure Commons must either have a public license or should be offered under special license conditions for the European scientific community.**

This statement aligns our activity to build and publish an executable expression of infrastructure with the roadmap that the e-IRG has envisioned for the European Open Science Commons.

## Public infrastructure with public funds

First of all, let's try to narrow down what kind of code we are talking about.
We are not referring to the software of the _application_ - the actual data storage service, the actual HPC application, the actual local resource manager, the actual identity store. We are referring to _how_ that software is deployed - the configuration, monitoring, integration, _etc_.
The intellectual property of the person, team or institute which developed the service is not in question, but rather the ability to reproduce and reliably deliver that service in an arbitrary environment.
In a research environment, usually created with public funds, this is almost an obligation.

## Extending and scaling infrastructure

The second issue we are trying to address is that of interoperability and scalability of services in an environment which has too few humans. We face a severe lack of resources of all kinds in Africa, so wasting the most precious ones (humans) on needlessly manually installing and tuning services is evidently a bad idea.
If instead we could deliver code which had already been developed for certain environments, tested against them, inspected and reviewed by peers, and could be **executed** in order to build e-Infrastructure, this would be a much better investment of effort[^ExecutableInfra]
It would also make it much easier to extend infrastructure, wherever resources could be found - at new sites (universities), or at commercial providers.

## Resilience to change

Finally, adopting this paradigm of _infrastructure as code_, and providing a framework in which it is feasible and attractive to _share_ that code makes it run. Our platforms and middleware stacks are changing rapidly. The concept of infrastructure is also changing, the expectations of research communities are changing. In a way, this is a **good** thing - many more opportunities are open to many more people now - but with these changes sometimes comes an erosion the desire to collaborate and contribute to a common effort.

Instead of one middleware stack to integrate fairly similar resources, we now have choices to make all the way from the OS and kernel to the authentication mechanism. It can be overwhelming, especially in the absence of strong leadership and community.

## E Pluribus Unum ?

Having a **single** entity in Africa which owns, operates and arbitrates e-Infrastructure is neither feasible nor desirable. On the other hand, making 'every provider a king" ends in chaos. There is clearly a tradeoff to be reached. **Some** complexity is required in in order to offer relevant services and allow for some creativity. **Some** diversity in compute frameworks and platforms is desirable in order to satisfy various workflow demands, but **too much** makes it confusing to the user and creates too much overhead for the operator.

Neither, in my opinion, can the right balance be determined _a-priori_.

# Touching the commons

Experience is probably the best guide when determining what to support and integrate and what to consider "outside" the commons. However, it should be agreed that there there **is** a commons, and it should be tangible.

The big idea is to have a library of infrastructure as code, which :

  1. describes what we have all built
  2. is expressible in some executable way
  3. is attributed to the correct people
  4. can be easily shared.
  5. is attractive to contributors

This could provide the basis for all kinds of other scholarly and technical output. It would be a tangible representation of things that are so often hidden in data centres, trenches or the deep blue sea.

# Legal, License, and Community Conduct Issues

As soon as we start talking about sharing and contributing, we run into intellectual property issues. These are not by any means intractable, and are governed by the **license** that is chosen to stipulate how and when people can use the software, as well as what liability the copyright holder has towards the end-user. The end user in this case is an institute or group participating to the infrastructure by providing resources.

Since we are building code for **infrastructure**, we want :

  1. Code to be owned by the contributor
  2. Waive liability
  3. Ensure a certain level of quality
  4. Accept appropriate contributions
  5. Define a form of community maintenance responsibility

Some of these can be covered by a license, whilst others can be encapsulated in the form of a Code of Conduct in the repository.

## License

So, which license should we choose ?  The obvious place to start would be [choosealicense.com](https://github.com/github/choosealicense.com). We had a bit of a discussion about which license to choose [on the forum](http://discourse.sci-gaia.eu/t/which-license-for-e-infrastructure-code/2593). But what about other infrastructure projects ? After a brief scan of some of their repos, I came up with the list below[^notExhaustive]

  * DataCite : MIT
  * EUDAT : GPL ?
  * EGI : [Apache-2.0](https://wiki.egi.eu/wiki/EGI_Tools_Licenses)
  * ORCID : MIT
  * Zenodo : GPLv2
  * OpenAIRE : MIT / Apache-2.0
  * GEANT : MIT / Apache-2.0


# Way forward

We have a solid base of code to start from - [AAROC/DevOps](https://github.com/AAROC/DevOps). This is where we want to encourage contributions to, but it is not clear how or why to do that.
The first steps are

  1. to clarify the contributor agreement and code of conduct, by writing a statement of principles on the AAROC public web page
  2. This page should have a clear call for contributions
  2. Write a code of conduct in the repository, outlining how contributions are accepted, reviewed and published.
  3. Create a "contributors" file to acknowledge the ownership and contribution of various people and institutes.

Eventually, we could curate these contributions via a dedicated collection or repository.

Stay tuned...

#  Acknowledgements

Acknowledgement for discussion of ideas and background go to

  * [Mozilla Science Lab](http://science.mozilla.org), particularly their [Working Open Workshop](http://mozillascience.github.io/working-open-workshop/)
  * A lot of background came from reading the work of [Nadia Eghbal](https://github.com/nayafia), and in particular the [contributing template](https://github.com/nayafia/contributing-template)
  * [Martin Fenner](http://orcid.org/0000-0003-1419-2405) from [DataCite](https://www.datacite.org)
  * The [Github Open Source Guide](https://github.com/github/opensource.guide)

## How to choose a license ?

The following folks and articles have informed much of what I've written here :

* [Sam Halliday's](https://github.com/fommil) presentation at scalasphere[^fommilPres]
* ["A Quick Guide to Software Licensing for the Scientist-Programme"](https://doi.org/10.1371/journal.pcbi.1002598)[^HowLic1]
* ["How to choose a license for your software"](http://doi.org/10.5281/zenodo.30997)[^HowLic2]

# References and Footnotes.

[^notExhaustive]: This is not an exhaustive, nor authoritarian list. In some cases, I took the most-used license, when there were several
[^FertileDelta]: All this started a few years ago. [This blog post](http://www.africa-grid.org/blog/2014/11/26/Terre-des-hackers/) laid out a vision of what kind of environment would represent fertile land to _inhabit_ as researchers.
[^fommilPres]: ["Free, Libre and Open Source"](http://fommil.com/scalasphere16/), by Sam Halliday, Scala Sphere 2016
[^HowLic1]: Morin A, Urban J, Sliz P (2012) "A Quick Guide to Software Licensing for the Scientist-Programmer". PLOS Computational Biology 8(7): e1002598. https://doi.org/10.1371/journal.pcbi.1002598
[^HowLic2]: Sufi, S. (2015, September). "How to choose a license for your software. Zenodo."
[^ExecutableInfra]: See the recent talk on ["Executable Infrastructure"](https://www.digitalinfrastructures.eu/content/executable-infrastructure-africa-and-arabia) at DI4R Krakow for an expansion of this idea.
