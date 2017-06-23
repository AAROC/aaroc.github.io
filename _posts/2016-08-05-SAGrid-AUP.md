---
layout: post
title: "Updated SAGrid VO AUP"
description: "Asking for your support of our support"
headline: "Sites supporting the SAGrid Virtual Organisation are asking members to do them a solid."
category: blog
tags: [blog, sci-gaia, thor, datacite, data, citation]
comments: false
mathjax: false
image:
  feature: aup-post-header.jpg
discourse: true
codrops: false
---

# TL;DR : If you use it, support it.

Provisioning e-Infrastructure is a thankless job, take it from us. Nobody wants to hear about how you've configured your services _"just right"_, how you're collaborating behind the scenes, how you're constantly putting out fires big and small so that research can be done. Usually, folks just skip ahead to the research bit and the researchers get the kudos.

This is  as it should be. Everybody has their part to play, and we know that the reason that we build and maintain distributed computing services is not for their own sake, but rather to enable scientific progress and discovery. You may be expecting a "but", right about now - and you'd be totally right.

#  You are all awesome, but...

Here's the thing :

> We can't do this without a positive feedback loop.

A positive feedback loop is a process which enables long-lived features in complex systems[^feedback], by enhancing small perturbations and bringing a form of order to an otherwise chaotic system. This order is exactly what the Africa-Arabia Regional Operations Centre aims to bring to the vast pool of computing resources in our region, and by doing so, better support and stimulate research outputs. A positive feedback loop in this case may just be as simple as pointing back to the original perturbation[^feature], by citing that work in your subsequent research outputs.

# What, When, How ?

Having dealt with the "why", you may be saying to yourself :

> Great, I'll buy that - but how _exactly_ are we to go about this ?

What do we cite ? Where do we cite it and when is it appropriate to cite, rather than acknowledge the work of the VO ? Most importantly, _how_ should one cite this properly ?

## What

Let's start with the easy bit - what to cite. The new [Acceptable Use Policy](https://voms.sagrid.ac.za:8443/voms/sagrid/aup/load.action) states :

> All research output (articles, data sets, analytic results, etc) which result directly from the use of the resources which support this VO shall contain \\
  1.1 Citation of the paper describing the infrastructure: \\
      "The South African National Compute Grid" \\
      B. Becker et al. \\
      IST-Africa 2009 Conference Proceedings, Paul Cunningham and Miriam Cunningham (Eds), IIMC International  Information Management Corporation, 2009, ISBN: 978-1-905824-11-3\\
  OR \\
  1.2 Acknowledgement of the use of the resources in the relevant section, using the following phrase : \\
     "The authors acknowledge the support of the Africa-Arabia Regional Operations Centre and EGI.eu. This work was produced in part thanks to the resources of the sites supporting the sagrid VO.

So, you know, you've got options. The first of these options is the "first post" of the old SAGrid project, where the original motivation, implementation and so on was described.

## When and How

So, now you know _what_ to cite, the question becomes - _when_ do you add acknowledgement support ? We  foresee this sort of acknowledgement statement or citation of prior art in two different scenarios:

  * if you are writing a paper which contains results obtained by the usage of the sites supporting the virtual organisation, **or**
  * if you have had direct support from the staff of participating sites, in the preparation of your paper,

you should use the acknowledgement phrase, in the section of your paper's template (usually towards the end). This usually applies to domain-specific research - climate, chemistry, machine-learning, bioinformatics, _etc_.

If, however, you are working on a **platform** or **service** which uses AfricaGrid services via  their APIs, or specific endpoints, and supports the users of  the Virtual Organisation[^AAROCCite], you should cite the "first post" paper we mention above. This is especially important when you can consider your work a kind of "derivative" of the infrastructure and which depends on the open nature of it. Our access and intellectual property policies depend on this kind of reciprocation of support, in order to engender the positive feedback loop which keeps the infrastructure in place, and justifies further investment.

# Hold on a second : data.

Before we end off here, let's talk for a second about data. Here, we are referring to data which has been generated on the sites supporting the VO, and published in an open access data repository. Data like this should in principle e issued a [DataCite](http://datacite.org) [DOI](https://www.datacite.org/dois.html) - that is a persistent identifier which allows people to both retrieve and identify that data for the forseeable future. When such data is published, it should follow the [DataCite metadata schema](https://schema.labs.datacite.org/meta/kernel-4.0/)[^DataCiteSchema4], which makes provision for certain kinds of acknowledgement of support, including `<contributors>`. The [`ContributorType`](https://schema.labs.datacite.org/meta/kernel-4.0/include/datacite-contributorType-v4.xsd) can include "other" :

{% highlight xml %}
<xs:schema targetNamespace="http://datacite.org/schema/kernel-4" elementFormDefault="qualified">
  <xs:simpleType  name="contributorType" id="contributorType">
    <xs:annotation>
      <xs:documentation>The type of contributor of the resource.</xs:documentation>
    </xs:annotation>
    <xs:restriction base="xs:string">
    <xs:enumeration value="ContactPerson"/>
    <xs:enumeration value="DataCollector"/>
    <xs:enumeration value="DataCurator"/>
    <xs:enumeration value="DataManager"/>
    <xs:enumeration value="Distributor"/>
    <xs:enumeration value="Editor"/>
    <xs:enumeration value="HostingInstitution"/>
    <xs:enumeration value="Other"/>
    <xs:enumeration value="Producer"/>
    <xs:enumeration value="ProjectLeader"/>
    <xs:enumeration value="ProjectManager"/>
    <xs:enumeration value="ProjectMember"/>
    <xs:enumeration value="RegistrationAgency"/>
    <xs:enumeration value="RegistrationAuthority"/>
    <xs:enumeration value="RelatedPerson"/>
    <xs:enumeration value="ResearchGroup"/>
    <xs:enumeration value="RightsHolder"/>
    <xs:enumeration value="Researcher"/>
    <xs:enumeration value="Sponsor"/>
    <xs:enumeration value="Supervisor"/>
    <xs:enumeration value="WorkPackageLeader"/>
    </xs:restriction>
  </xs:simpleType>
</xs:schema>
{% endhighlight %}

This space can be used to acknowledge the support of the VO, and you can simply put the reference referred to above in there. Now, this may not be the perfect way to acknowledge the contribution that the infrastructure has made towards your work, and right now there may not even _be_ a perfect way to do this. We do, however _need_ it - so please help by [continuing the discussion](http://discourse.sci-gaia.eu/c/commons) on the African e-Infrastructures discussion forum, or over at the [THOR project knowledge base](https://project-thor.readme.io/).

Rock on, beautiful scientists...

# Footnotes and References

[^feedback]: We use the analogy of the gridcloud as a [complex system](https://en.wikipedia.org/wiki/System_dynamics) often. The first known reference and exploration of this idea was a [talk](https://prezi.com/89bkbbre5vk1/out-of-turbulence-discoverability-of-african-scholarship/) given to a workshop in Nairobi on the discoverability of African Scholarship.
[^feature]: Call it a _feature_, an _intervention_, whatever - it's something that externally drives the system past equilibrium. In this case, equilibrium is a chaotic mess. Thermodynamic equilibrium is a terrible way to get work done.
[^AAROCCite]: We will have a similar page on the ROC's website to explain how to cite or acknowledge support of the ROC as a whole when dealing with infrastructure developments, which are not specific to individual communities.
[^DataCiteSchema4]: Here, we are referring to version 4 of the [**"DataCite Metadata Schema for the Publication and Citation of Research Data. Version 4.0. DataCite e.V."**](https://schema.labs.datacite.org/meta/kernel-4.0/metadata.xsd)
