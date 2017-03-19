---
layout: post
title: "PerfSONAR by SANREN"
description: Ever wanted to know how the network is doing ?
headline: The South African NREN has got network performance covered
category: blog
tags: [Announcement, perfSONAR, SANREN, network, performance, open infrastructure]
image:
  feature: spidernet.jpg
comments: true
discourse: false
---

# TL;DR - End-to-end performance is hard, SANREN has your back, with perfSONAR.

Applications in a distributed environment can depend critically on the performance of the network over which they run. Getting the most out  of the network involves first understanding where the bottlenecks are; SANREN's got you covered with perfSONAR.

# The SANREN backbone and the rest of the network

The South African NREN consists of a backbone connecting the main nodes at Universities across the country, as well as main laboratories and research infrastructure. This represents a game-changing investment in research infrastructure in South Africa, bringing researchers closer together and enabling a wide range of tools and services that were not feasible before.

The 10 GB/s backbone is extended from the nodes to the various institutes which are served by the NREN in a more capilliary fashion. From the pops to the campuses to the LANs and eventually the end-user's device (phone, laptop) or srever in a data centre. This complexity is often overlooked, and the beautiful, impressive simplicity of one number - the core backbone bandwidth - seduces us into thinking that we're suddenly going to shift data at light speed.

# Understanding end-to-end performance

We expect that the 10 GB/s of the backbone is translated into our actual experience of the application at hand, ignoring the fact that these applications required data to move in something less like a straight (pipe)line and more like a massive delta. The *actual* performance of the application is often determined by the largely by the slowest component in it, not  by the fastest. This may be anything from a congested switch to a misconfigured firewall or simply the network card installed on the receiving end. Aspects such as the kernel configuration of the sending and receiving machines - how it is configured to process the data coming over IP, and how this compares with the physical characteristics of the hardware - can also have a huge, unexpected impact.

Most of our network devices are configured for reliability and for handling typical traffic on the web, not the massive sustained throughput needed by advanced research applications. It is not uncommon to sense frustation in  a user's communcations when they are told that the university has 10 GB/s connectivity, but they are only experiencing orders of magnitude less than that. Understanding what to expect comes from knowing the relationship between the data you want and everything between it and the location in which it needs to be processed. Likewise, getting the most out of backbone investment like SANREN comes down to identifying and optimising every component on a path.

While it's fairly easy to do this for the backbone components, the complexity of the system - due to the number and variety of components - lower down the line, is a severe challenge. In order to deliver the best service possible and get the most out of a massive investment, a special instrument is needed to probe the performance of the network *on specific paths* - from end to end.

# Enter perfSONAR

<figure>
<img src="{{ site_url }}/images/perfSONAR-header.gif" href="http://www.perfsonar.net">
</figure>

The tool for this job has been developed over decades of research in network engineering : [perfSONAR](http://www.perfsonar.net). In their own words -

> "perfSONAR is a network measurement toolkit designed to provide federated coverage of paths, and help to establish end-to-end usage expectations.  There are 1000s of perfSONAR instances deployed world wide, many of which are available for open testing of key measures of network performance.  This global infrastructure helps to identify and isolate problems as they happen, making the role of supporting network users easier for engineering teams, and increasing productivity when utilizing network resources.  "

PerfSONAR provides a set of sensors which collect performance data on network traffic, and there are instances all across the globe, helping to identify and diagnose issues across almost any path that modern research data can travel.  This is an extremely powerful tool.

# PerfSONAR in South Africa

PerfSONAR in South Africa has been operational for some time - since 2012 in fact -  and has already led to significant improvements in data throughput from international laboratories like [CERN](http://www.cern.ch) to South Africa, supporting high-energy physics experiments, *e.g.* [ALICE](http://www.aliceinfo.cern.ch) and [ATLAS](http://www.atlas.ch). With currently 13 permanent nodes and the full backbone covered, it is firmly a part of the international perfSONAR network.

<figure>
<img src="{{ site_url }}/images/perfsonar-services-sa.jpg">
<caption>
Location of perfSONAR sites in South Africa, from <a href="http://stats.es.net/ServicesDirectory/">the perfSONAR service discovery page</a>. Image courtesy Roderick Mooi.
</caption>
</figure>
PerfSONAR is now a fixed feature of the South African NREN landscape and is used on a daily basis to support optimisation and improvement of the research network. It provides valuable supporting information to network engineers and administrators which need to identify bottlenecks and efficiently take action to resolve it - avoiding the usual "it's your side !" , "no it's your side" back and forth that can so often define network performance debungging. This is, in the final analysis, a great move for users, who get to experience the fastest possible network for their applications.

# Now that we've found love...

Of course, tools like perfSONAR only help to identify problems and misconfigurations, they don't automagically *fix* them; that would be just a little *too* awesome :wink:. Luckily there are a lot of proactive ways to address end-to-end performance tips and tricks which can be applied to speed up network transfers, from using different tools to tuning kernel parameters. The good folks at [Faster Data](http://fasterdata.es.net/) provide a comprehensive knowledgebase, which you can refer to if you want to squeeze every last bit of your available bandwidth. You may never get to the golden 10 GB/s, but hey at least you'll sleep better at night knowing there's just nothing more you can do !

# To know more

If you want to find out more about what perfSONAR take a look at the [perfSONAR website](http://www.perfsonar.net) and links therein. A good resource for analysing end-to-end performance is the [ESNet](http://www.esnet.net) knowledgebase and links therein.

To find out more about how perfSONAR is improving the use and capability of the NREN in South Africa, take a look at [Roderick's slides from TNC 2015](https://tnc15.terena.org/core/presentation/199) - where he goes into depth about the system's use in South Africa. If you're interested how perfSONAR could benefit you locally, don't hesitate to get in touch with Roderick Mooi (rmooi.at.csir.co.za) or Kevin Draai (kdraai.at.csir.co.za) at SANREN.

Lastly, to use the SANREN perfSONAR tools, take a look at http://perfsonar.sanren.ac.za

Make that data flow !

{% if page.discourse %}
# Discussion
<div id="discourse-comments"></div>

{% endif %}
