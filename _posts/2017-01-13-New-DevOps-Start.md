---
layout: post
title: 'A new start for AAROC/DevOps'
description: "Detaching AAROC/DevOps from it's past"
headline: "Detaching AAROC/DevOps from it's past"
category: blog
tags: [AAROC, code, DevOps, Github]
image:
  feature: separate.jpg
  attribution: "cc-by Mandy Goldberg on Flikr"
comments: false
mathjax: false
discourse: true
---

A few years back, we came to the conclusion that operating services manually was a pretty bad idea. The feeling that the proper configuration of grid middleware[^gLite32] was a dark art was pervasive - so many configuration files, so many separate services, so many configuration options ! Impossible to do _right_, impossible to _test_ and most of all, no way to keep knowledge about _what_ was supposed to be done, let alone _how_ it was supposed to be done. Deploying new sites or even individual services had to be done with the physical presence of an experienced operator, and rarely was there enough time to transfer whatever knowledge that person had to the staff at the new site.

# Genesis of DevOps in AAROC

During the [All-Hands meeting](http://agenda.ct.infn.it/event/895/)[^AllHands] in Pretoria, we had a few good presentations[^HazelhurstPuppet] [^KannelopoulosAnsible] on tools which we used by site administrators. The term "DevOps" was new back then and just gaining traction as a practice, but this meeting was the genesis of what would be come a rich and widely-used repository of code for the services in the Regional Operations Centre. Originally only [Puppet](https://puppet.com/), and then [Ansible](http://www.ansible.com) were used - a precursor to the many, many tools which would come in the future, particularly to manage cloud and container platforms. However, we have never argued about which tool is the right one, or tried to standardise on _one_, because the important thing is that whatever service is being offered to the community, that it is reliabily and reproducible deployable. The concept of "executable infrastructure" has been put forward several times[^ExeInfraUC2015] [^ExeInfraDI4R] as encapsulating this idea.

# Much more than Operations

We've worked hard to promote the DevOps culture in the region, because we're a distributed, multi-cultural group of people with widely varying skill sets. This diversity is a great asset if it can be properly harnessed, and if the right level of adherence to common practice and empathy with those who may do things differently from you can be achieved. The repository of code has really helped us deploy services in new places, better debug issues, manage upgrade cycles, middleware releases, etc. However, the importance of this repository extends far beyond the important, but somewhat staid world of infrastructure operations. We use it to generate documentation, research output and even run training and teaching events.

##  Documentation

Much of the need for a DevOps culture is for increased transparency in the _procedures_ - the need for them to be reproducibly executed by even new members of the collaboration. The tools which are used to _implement_ this culture go a long way to reducing the need for "manuals" and other forms of documentation. In the case of Ansible playbooks, the code itself is as easy to read as it is to write, which is to say that it is written in "plain English." This is all well and good as far as it goes, but what about our colleagues whose first language is _not English_, but French, Arabic, Aramaic, Yoruba, _etc_ ? No matter the level of intent to keep code expressive and clear, there is always some level of connotation or opacity in the way things are implemented, if you're new to the project, so some form of "getting started" manual for service deployment is necessary. There are some steps, for example, which are not automatable (such as site-specific variables or passwords), and thus need to be described specifically for human consumption.

The typical procedure for writing this information is to maintain it in the "README" file of the module, role _etc_ which is being used. We have been using [`mkdocs`](http://www.mkdocs.org/) to generate html documentation from these README files, which are typically written in Markdown or RST. This documentation is currently hosted at [afica.grid.org/DevOps](http://www.africa-grid.org/DevOps)[^WIPYO].

## Review and Publication

[AAROC/DevOps](https://github.com/AAROC/DevOps) aims to be an executable expression of our _actual infrastructure_. It is both a software package as well as a dataset, and as such needs to respect a few quality criteria - it should for example be tested at some level, and the contents should have undergone some level of peer review and discussion where appropriate. [Recent additions]() to the Github API[^GithubAPI] allow [protected branches](https://help.github.com/articles/about-protected-branches/), which repo maintainers can enforce code review on, such as automated testing and [review by actual humans](https://help.github.com/articles/approving-a-pull-request-with-required-reviews/). While we still have a long way to go to improve the quality of these outputs, we have started to publish the repository release via [Zenodo](https://zenodo.org). Assigning DOIs to code which represents the specific state of infrastructure is a good way to get credit for work done.

## Teaching

At the end of the day, code has to be written by _people_ - developers. Sure, the AI revolution may be right around the corner, but until we get there, our best bet for taking the collaboration forward sustainably, is to have as many people as possible capable of reading and writing the code for services. More eyes can also translate into better reviews, and therefore better tested and more widely-used code. To this end, we've been working on a companion repository to DevOps, specifically to improve the capability of people we potentially may be working with in the region to use Ansible[^WhyAnsible]. This repository can be used to deliver a short, self-contained course[^BootCamp]. The general idea is to fork the ["Software Carpentry"](http://www.software-carpentry.org) idea into an "Infrastructure Carpentry" concept... Something to blog about another time though.

# Time to stand on our own feet.

We originally forked an existing repository to get started, and eventually stabilised on [DevOps repo for the region](https://github.com/AAROC/DevOps). Since the fork of the [GRNET Ansible code for grid services](https://github.com/auth-scc/grid-services-deployment) way back in 2013, there have been some major changes.

Several releases of Ansible  have come out, some of them major, with backward-incompatible code; a full refactor of the code was done[^DevOps2015]. We have also added several services in the identity-management, application delivery and cloud service deployment areas which are not specifically for grid infrastrucutures. There was also a large  re-organisation of the repository to accommodate site-specific code, from whatever tool they are using.

The repository has taken on a life of it's own. With [8 releases](https://github.com/AAROC/DevOps/releases), [12 contributors](https://github.com/AAROC/DevOps/graphs/contributors), [24 forks](https://github.com/AAROC/DevOps/network) and just over [1700 commits](https://github.com/AAROC/DevOps/commits/master) to the master branch, it has totally diverged from the original repository from which it was forked. This has started to create some issues - [particularly in the way contributions are counted](https://help.github.com/articles/why-are-my-contributions-not-showing-up-on-my-profile/#commit-was-made-in-a-fork), and [the way in which GitHub indexes forks](http://stackoverflow.com/questions/33626326/how-to-search-a-github-fork-for-code-using-the-github-search-api) for searching. The time has come to detach the repository from the network it was forked from, and live it's own life.

Apparently, though, [this is not trivial](https://www.quora.com/Git-revision-control-How-can-one-detach-a-forked-project-in-GitHub) - although it's certainly possible. Simply creating a new repository and populating it with the content of the fork, to force a "fresh start", will cause you to lose all of the important metadata related to the repo - forks, stargazers, issues, wiki, etc. However, a brief exchange with - it must be said, a very helpful - GitHub helpdesk ensured that the relevant information was backed up before the detach took place.  

We now have a stand-alone repository which far better reflects the work done by the community, and puts it on a  better footing for the future.

# References and Footnotes

[^gLite32]: We're talking [gLite 3.2]() here kids... that was a LONG time ago !
[^AllHands]: This was one of the last technical training sessions we had ever run, in conjunction with GRNET, one of the partners of the very successful [CHAIN-REDS project](https://www.chain-project.eu) which we participated in.
[^HazelhurstPuppet]: [Site Administration Tools : Puppet](http://agenda.ct.infn.it/event/895/contribution/22/material/slides/0.pdf) - Scott Hazelhurst, AAROC / CHAIN-REDS All Hands meeting, Pretoria, 2013.
[^KannelopoulosAnsible]: [Site Administration Tools : Ansible](http://agenda.ct.infn.it/event/895/contribution/23/material/slides/0.pptx) - Christos Kanellopoulos, AAROC / CHAIN-REDS All Hands meeting, Pretoria, 2013.
[^ExeInfraUC2015]: [Executable Infrastructure for Collaboration at Regional Level](http://www.ubuntunet.net/sites/default/files/19.%20Becker%20-%20Executable%20Infrastructure.pdf) - Bruce  Becker, Ubuntunet Connect Conference 2015, Maputo, 2015.
[^ExeInfraDI4R]: [Executable Infrastructure for Africa and Arabia](https://www.digitalinfrastructures.eu/content/executable-infrastructure-africa-and-arabia) - Bruce Becker, Digital Infrastructures for Research Conference, Krakow, Poland, 2016.
[^DevOps2015]: Bruce Becker, Marco Fargetta, Chris Lee, Paschalis Korosoglou, Pavlos Daoglou, Bouchra Rahim, Gerrit Botha, (2015). AAROC DevOps pre-release [Data set]. Zenodo. http://doi.org/10.5281/zenodo.19100 [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19100.svg)](https://doi.org/10.5281/zenodo.19100)
[^WIPYO]: It's definitely a work in progress still, but hey - better than nothing, right ?
[^GithubAPI]: We are referncing [GitHub API V3](https://developer.github.com/v3/) here, specifically the part which controls how [branches are managed](https://developer.github.com/v3/repos/branches/)
[^WhyAnsible]: We have chosen Ansible as the tool for the bootcamp, because in our opinion it has the lower barrier to entry compared to Puppet or other tools, and it's simple serverless architeture makes it easy to demonstrate and teach.
[^BootCamp]: Bruce Becker, Chris Rohrer, & Marco Fargetta. (2017, January). AAROC/AnsibleBootCamp: Ansible BootCamp - Entebbe. Zenodo. http://doi.org/10.5281/zenodo.242394  [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.242394.svg)](https://doi.org/10.5281/zenodo.242394)
