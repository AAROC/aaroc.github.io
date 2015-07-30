---
layout: page
permalink: /cvmfs/
title: Application Repository
headline: How to get the shiny
tags: [cvmfs, howto]
image:
  feature: cvmfs-blocks.jpg
  attribution: 'CERN Virtual Machine Filesystem block diagram http://cernvm.cern.ch/portal/filesystem'
---
Here you can find how to mount the [CVMFS](http://cernvm.cern.ch/portal/filesystem) repositorues which deliver our applications to you. Think of CVMFS as a filesystem that you can mount - except a really fast and efficient one ! Just like mounting

<!-- TOC depth:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Quickstart Guide](#quickstart-guide)
	- [Prerequisites](#prerequisites)
	- [Mounting the repo](#mounting-the-repo)
- [More Details](#more-details)
	- [Local mount (private)](#local-mount-private)
	- [Feedback and suggestions](#feedback-and-suggestions)
- [Footnotes](#footnotes)

<!-- /TOC -->

# Quickstart Guide

If you want to skip ahead to the fun bits, start here. This is a quick summary of the information in [the CVMFS Technical Report](https://ecsft.cern.ch/dist/cvmfs/cvmfstech-2.1-6.pdf) on how to mount repositories.  

## Prerequisites

  1. <i class="fa fa-linux"></i> **We only support  Linux - specifically CentOS or Debian.**[^MacOSX]
  1. You need to have the CERN repos in your configuration :
      <i class="fa fa-arrow-right"></i> Install the [CVMFS Release](https://cernvm.cern.ch/portal/downloads) package for your system.
  1. Install the client : (re)
      1. `yum install cvmfs cvmfs-config-default` (RedHat derivatives)
      1. `dpkg -i cvmfs.deb cvmfs-config-default.deb` (Debian and Ubuntu)

## Mounting the repo

Mounting the repositories can be done either in "local" or "system"  mode.


# More Details

## Local mount (private)

To mount the repository locally in user space,

## Feedback and suggestions

<div class="row">
  <div class="col-md-6">
    If you want to report an <em>error</em> please <a href="https://github.com/AAROC/DevOps/issues/new?&labels=CVMFS&title=Problem%20mounting%20CVMFS%20repo">open an issue</a></div>
  <div class="col-md-6">If you have feedback or suggestions, please start a topic  on the <a href="http://discourse.sci-gaia.eu">forum</a></div>
  </div>


# Footnotes

[^MacOSX]: If you really want to Mac, check the full technical report on how to do that.
