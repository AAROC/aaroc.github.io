---
layout: post
title:  'CODE-RADE in CVMFS global repositories'
description: 'How do we construct the namespace of our repos'
category: blog
tags: [blog, CODE-RADE, CVMFS]
image:
  feature:
  attribution: ""
comments: false
mathjax: false
discourse: true
---

# TL;DR - We need to get our repo configuration for CODE-RADE into EGI

# Deploying CODE-RADE is kinda manual :wrench: No Likey :frowning:

At  the moment, if you want to use CODE-RADE repositories at your site, you need to [follow some manual steps](http://www.africa-grid.org/CODE-RADE/site-admin-quickstart/) to get everything configured. This puts us at a bit of a disadvantage compared to the other organisations who are automatically configured when you install the CVMFS packages. This _can_ of course be addressed, simply by including our configuration into the way EGI distributes the repo information for various communities. We therefore have some choices to make, no matter how trivial they may seem.

# CVMFS Global Repository configuration

We have been in discussions with the CVMFS Task Force for quite a while now to decide how to do this. Recently we got this email :

> We discussed about the option to have everything under `/cvmfs/<Africa-Arabia_repo_name>.egi.eu/<various_projects_repos>/...` ,
> but also there might be a solution to setup something like `'africa-arabia.org'` name space
> (i.e. `/cvmfs/<repo1>.africa-arabia.org/...` and `/cvmfs/<repo2>.africa-arabia.org/...`
>  etc repositories).

So, what to do ?

# Current and future situation

At the moment, we have one, perhaps two Stratum-0's in South Africa. The CODE-RADE Stratum-0 has in principle 3 repositories (`fastrepo`,`devrepo`, and `apprepo` - describing the quality assurance of the hosted apps), but this is still discussing only application delivery. CODE-RADE is in some sense community infrastructure, and supported by the ROC.

It's conceivable that more Stratum-0's would come online from other providers in the region, which may fall into the ROC - the region is certainly large enough for there to be scope for this. So, perhaps using the AAROC namespace might be the way to go. It's not clear to me yet if there is any pro or con to either choice[^discuss], but it seems to me that **we should choose the "namespace" option**. The most important thing is to ensure that it's easy to add a new repo under the namespace with minimal manual reconfiguration on the part of the Stratum-1's and sites.


# Footnotes and references

[^discuss]: Be sure to discuss this on the related topic in [the forum](http://discourse.sci-gaia.eu)
