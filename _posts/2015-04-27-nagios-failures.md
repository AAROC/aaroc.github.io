---
layout: post
type: status
title: Why always on a weekend ?
description: A full disk meant nagios died
headline: Too many messages !
category: blog
tags: [operations, nagios, monitoring, status, downtime]
image:
  feature:
comments: false
---
This morning, before getting ready for the day, I took a few moments as usual to check the status of the monitoring, expecting DZ-ARN-01 to have reached "green" Availability and Reliability. This was indeed the case, but I noticed two things when poking about :

  1. MA-01-CNRST had 11 alarms against it - this looks like some kind of drastic failure at the site, perhaps an electrical outage over the weekend.
  2. The nagios messages were not being sent to Slack, even though I had spent some time last week configuring this.

Somewhat miffeed, I went to take a look at the nagios probes running on the [AAROC nagios instance](https://nagios.c4.csir.co.za), mutting unspeakable epitaphs under my breath. Lo, I was greeted with

<figure>
<img src="nagiosdead-april.png"></img>
<figcation>Damn right I believe this to be in error !</figcaption>
</figure>

Horrified, I immediately thought that there had been a break-in. However, after a quick check it was clear that everything was in order, except for the fact that

{% highlight bash %}
df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00
                      5.8G  5.5G     0 100% /
/dev/hda1              99M   34M   61M  36% /boot
tmpfs                 3.0G     0  3.0G   0% /dev/shm

{% endhighlight %}

Yep, that'll do it...

<figure>
<img src="http://media.giphy.com/media/ZNHYND1c5ihYQ/giphy.gif" width="480" height="249" ></img>
<figcaption>Hulk smash full disk ! Actually wait, Hulk diligently clean full disk</figcaption>
</figure>

A quick check showed that it was the rejected messages director in `/var/spool/nagios2metricstore` that were the offending culprits. I cleaned this out and restarted stuff. We're still not getting messages into Slack, but at least the monitoring is back up.

Great way to start a Monday :unamused:

  - Bruce
