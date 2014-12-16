---
layout: post
title: Reconciliation Day
description: Quick update on what's going on
headline:  Quick update of what's going on
category: blog
tags: [AAROC, collaboration, Ops, recovery]
image:
  feature: MandelaReconciliation.jpg
comments: true
---

What's the point of having a blog if things aren't updated regularly, right ? Since we had a major failure of the core services and are working on setting up some failover capability with the team in Rabat, why not take a moment to update the world with what's going on...

# We're on slack

The communication issue has been bugging me. Sites being unresponsive is usually just a symptom of bigger problems... and certainly having to deal with email is one of those problems. So, with all this talk of automation, I started poking about on the web to see what other people were doing. Now, our love for [github](http://github.com) is widely and profusely professed, and we certainly use it a lot, but it's not as real-time as we need for a communications platform. On the other hand, while using [IFTTT](http://ifttt.com), I saw that one of the channels for automation was a thing called [Slack](http://slack.com). A few minutes of poking and clicking, and we had [Slack for Africa-Arabia Regional Operations Centre](https://africa-arabia-roc.slack.com). And we were like ...

<figure>
<img src="http://i.imgur.com/oOMBn.gif">
<figcaption><b>Oh. Yes.</b></figcaption>
</figure>




The awesome is... awesome. It's hard to describe how great slack is so far (one of those "Matrix" things, I guess - you've got to see it). Now, slack is for *team* communications, so it's privately accessible. We're also using the free version, so there's something left to be desired - particularly the limit on integrations. However, it's these integrations that are making life great for us. Just an example, we've configured Github events on our [DevOps repo](https://github.com/AAROC/DevOps) to notify a few of the channels, so that we can code and chat about what we're doing.


We've also got a couple of monitors and RSS feeds included - Nagios events from our [NGI SAM-NAGIOS](https://nagios.c4.csir.co.za/nagios/) show up - when the damn server is up ! (but more about that later) - as well as alerts from [Boundary](http://boundary.com). So, yeah... all this meant that our site admins now have a really groovy place to hangout and chat.

# Core services downtime blues

We had an *"event"* at the OpenNebula cluster hosting most of the ZA-MERAKA core services... let's just say that things got a little toasty in the server room. Not good... So, after a few frantic emails, the services came back and with minor updates were back to their previous glory. But this kind of thing is bound to happen more and more frequently in the future. Restarting services and setting downtimes - especially for core ROC services such as SAM-NAGIOS, WMS, top-BDII, etc are just not going to cut it.

<figure>
<img src="http://media.tumblr.com/6d8157e8b3fd9fe2ae9940bd87e47a4d/tumblr_inline_na61koZWk31raprkq.gif">
<figcaption>Ensuring critical infrastructure availability, Africa-style.</figcaption>
</figure>

It's bad enough that our SAM-NAGIOS instance was misbehaving, probably due to being out of date, for a few weeks before this little incident; it has caused the [Availability and Reliability](http://operations-portal.egi.eu/availability/siteAvailabilities) to be reported as unsatisfactorily low. Although violating the OLA in place with EGI.eu is bad enough, this is not the kind of reliability that we would like to have to report to users. So, we're trying to set up a failover mechanism for at least the BDII and SAM-NAGIOS instances. An [operations campaign](https://github.com/AAROC/DevOps/wiki/Core-Services-Failover-Campaign-2014) has started, with MA-01-CNRST as leader. Stay tuned.

# Stuff we're still working on

We're getting close to the completion of the Jenkins CI platform for continuous integration and delivery of applications. Fanie at UFS is himself busy with a major overhaul of the inventory there, given the lapse of the summer holidays. I presented some of this at UCT both during the [e-Research conference](http://www.eresearch.ac.za/) and to the UCT CompSci department while I was down there. It's looking really great.

For now, that's all !
