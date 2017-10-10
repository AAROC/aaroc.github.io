---
layout: page
permalink: /slack/
title: "AAROC is Slacking"
description: "How we use Slack"
headline: "Step into our office"
tags: [Slack, AAROC, automation, messaging]
image:
  feature: slack-large.png
  attribution: "Image courtesy TechCrunch"
codrops: false
gridlayout: true
discourse: true
---

<h1 class="text-center"><a class="social-icons" href="https://{{site.owner.social.slack}}.slack.com">
<i class="fa fa-slack"></i></a></h1>

<h3 class="text-center"><a href="https://{{site.owner.social.slack}}.slack.com">Join AAROC on Slack</a></h3>

# Africa-Arabia Regional Operations Centre is on Slack.

The Africa-Arabia Regional Operations Centre is a distributed initiative - we are people from all across Sub-Saharan Africa and the Arab states, trying to work together to maintain a platform for collaboration for the scientists we serve. 
It is impossible to meet face-to-face - often we have to co-operate with folks we've never even met. 
There's only  one way to do this - a central place where we can all talk to each other.

# Where work happens


Sure, we use slack to talk to each other, but it's also a key element of _getting work done_. We use slack in many ways to reduce the load on (human) members of the community, keep up to date with ongoing campaigns, projects and tasks. 

<div class="row">
  <div class="col col-md-6">
    <h3>Slack for humans</h3>
    Anyone in the community is welcome to join our slack. We consider the interaction between operators, developers and researchers to be at the heart of a vibrant e-Infrastructure community. Slack is good for realtime communications and chat - sometimes you need to have a longer or deeper conversation. For that we use <a href="http://discourse.sci-gaia.eu">the discussion forum<i class="fa fa-comments-o"></i></a>. Here are some of the ways we use slack to get humans talking:

    <h4>Operations</h4>We create a channel for each site participating, with the pattern <code>CountryCode-SiteName-ops</code> <em>e.g.</em> <a href="https://{{ site.owner.social.slack}}/messages/C0GJFG147"><i class="fa fa-slack"></i><code>za-chpc-ops</code></a>
    <h4>The Next Platform</h4>
    Computational platforms are continually evolving. Sites are always experimenting with new methods and tools. To make sense of it all, we often need to tap the collective experience of the community to find out what works. All things "next" are discussed in <a href="https://{{site.owner.social.slack}}.slack.com/messages/C51AR6TSQ"><i class="fa fa-slack"></i><code>next-platform</code></a>
    <h4>Research application areas</h4>
    If you're a scientist and want to know how to get the best use of the platform for your particular application, we create channels for domain-specific chats, like <a href="https://{{site.owner.social.slack}}.slack.com/messages/C109XBQH3"><i class="fa fa-slack"></i>hlt-research</a> for human language technologies.
    
   
  </div> <!-- humans column-->

  <div class="col col-md-6">
      <h3>Slack for automation</h3>
    We have a lot of helpers out there, checking our code, our services, making life easier for us. Messages from GitHub, Jenkins, Travis, Ansible and other automated beings out there help keep the team in tune with what's happening. Messages from robots are typically kept to specific channels like  <code>#code</code>, <code>#devops-bootstrap</code>
    <h4>CODE-RADE</h4>
    All of the <a href="{{ site.url}}/applications">applications built with CODE-RADE</a> talk to our slack. Code commits from GitHub, build, test statuses and issues for each application in the repository come to application-specific channels. If you're working on integrating a specific application, all you need to do is hang out in that channel to know how things are going. 

    Anouncements from <a href="https://ci.sagrid.ac.za">Jenkins</a> and CMVFS about repo transactions come to <a href="{{site.owner.social.slack}}.slack.com/messages/C03171E21"><i class="fa fa-slack"></i><code>coderade</code></a>

    <h4>Foundry</h4>
    We follow the <em>Everything == Code</em> pattern. Our services are built, tested and deployed from code - typically found in <a href="{{ site.owner.social.github}}/DevOps"><i class="fa fa-github"></i> DevOps</a>. When our containers, images, and services are built, our community is immediately informed, via messages from <a href="https://quay.io/organization/{{site.owner.social.quay}}">Quay</a>, <a href="https://hub.docker.com/u/{{site.owner.social.docker}}">Docker</a>, <em>etc</em>
  </div> <!-- automation column -->

</div> <!-- row -->