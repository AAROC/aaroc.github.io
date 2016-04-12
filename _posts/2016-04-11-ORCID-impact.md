---
layout: post
title:  'ORCID - Y U NO sort by impact ? '
description: 'That list of works is going to get long, and indeed not all research output is created equal'
category: blog
tags: [blog, Sci-GaIA, e-Science, ORCID, DataCite, persistent]
image:
  feature: filter.jpg
  attribution: "Courtesy of SplitShire http://www.splitshire.com/wp-content/uploads/2015/01/SplitShire-6806-1800x1200.jpg"
comments: false
mathjax: false
discourse: true
---

# TL;DR : It would be nice if my ORCID works list could be ordered according to e.g. impact factor

Every year, we have an annual review of output by my institute[^Generic], which I'm sure is a common thing amongst research institutes, laboratories and probably universities. Now, I have my ORCID account connected with the [DataCite](http://www.datacite.org) "search and link", which automatically imports new works from DataCite-connected datacentres[^DataCiteCentres]. So, when my manager asked me for the year's scientific output instead of trawling through emails, files, calendar, _etc_, I simply went to [my ORCID profile](http://orcid.org/0000-0002-6607-7145 )[^yourORCID], and pulled out a list of works, which I then just handed over[^Actually]. Five seconds later, still patting myself on the back, my enthusiasm for this self-service mode of output evaluation was somewhat curbed. I had a feeling it was too good to be true...

# Easy, Tiger.

It turns out that at my institute, as at probably any serious research institute or university, not all scholarly output is created equal. Leaving aside the aspects of wider[^better] impact assesment in terms of _what_ kind of contributions count for assesment - ie, departing from the "traditional" list of journal article, conference proceeding, _etc_ and counting posters, blog posts, technical reviews, software, educational material, peer reviews, _etc_ - and concentrating only on the **quality** of the contribution, my manager was faced with a problem. Although ORCID did indeed show a comprehensive view of my research outputs, it did not say annything about which ones were eligible for inclusion in my _institutional_ assessment, because there was no way to map the object to the "publication count" as defined by my institute.

> I have project notes, conference posters, software releases, reproducible workflows, educational courses, and of course the "good-old" peer reviewed journal articles -
> How is the institutional librarian or group leader to know which ones are applicable ?

Hm. Fair enough...

# Institutional membership to the rescue ?

Now, it may be that if my institute has an [institutional ORCID membership](http://orcid.org/organizations/institutions), they would be able to [proactively obtain](http://members.orcid.org/profile-systems) my contributions for internal records, instead of relying on me to send them my (perhaps biased) report. This would allow them to both pull in works from sources which recognise my ORCID, and update my profile within the institute, as well as filter the works accorcding to their internal criteria, before harvesting them and submitting them to the institutional repository. Perhaps...

However, the single most important factor in _what_ to select from my list of works was whether or not the work was published in an accredited journal or publication. Whilst there are a few nuances to this, it essentially comes down to whether or not the publication is peer reviewd, and has [an impact factor](http://wokinfo.com/essays/impact-factor/).

# Sorting by impact factor

So even though I had to go through my list of works and send through a filtered list, selecting works based on the internal criteria of my institute, the integration of ORCID with the publishers (including DataCite) really saved an incredible amount of time. I could be fairly certain that if my work was _not_ in my ORCID profile, it would not satisfy the institutional criteria, since it would not have been published in an accredited journal, so I didn't have to spend those hours trawling my email, calendar, filesystem, looking for articles which I may have published by forgotten about. Yay ORCID !

However, I still had a fairly long list to go through, which was sorted chronologically. Whilst going through this list I had to check which source the contribution came from (which was pretty easy)

<figure>
<img src="{{ site_url }}/images/ORCIDworks-bruce-becker-04-2016.png">
<figcaption>Sample of works in my ORCID profile, retrieved 11/04/2016. The data source is clearly seen by the DOI prefix/suffix. The list is sortable by date, contribution type or title.</figcaption>
</figure>

However, to make things _even easier_ it would be awesome if that list could be sorted by **impact factor** instead of date. This would not only make my annual reporting much easier, but also allow those visiting my profile to see my **most impactful works first**.

# Ideas on implementation

## Repository Metadata ?

This is probably not trivial to implement, but if I had to think of a solution, it would need the impact factors of the data sources. I'm not sure if the [OAI-PMH protocol](https://www.openarchives.org/pmh/) allows for data centres to include their impact factor in their repository metadata (or if this even makes sense), but that might be one way. Another way would be for an ORCID service to cross-reference the contribution with Web of Knowledge data on impact factors, and try to guess what impact factor to weight the article with.

## Webometrics ?

Another aspect of a repository is it's [repository webometrics](http://repositories.webometrics.info/) score, where available. This is what we decided to implement in the [CHAIN-REDS](http://www.chain-project.eu) [Semantic Search](http://www.chain-project.eu/linked-data) tool. The issue here might be cross-referencing the DataCite data center identifier (the prefix, essentially) with the webometrics identifier. Of course, it would be even better if webometrics used the same persistence and uniqueness infrastructure as the rest of the academic publishing world, but we can't have _everything_ now, can we !

## Altmetrics ?

An alternative approach might be to forget about the publication and focus on the object; the works could be ranked by the [Altmetric score](https://www.altmetric.com/about-altmetrics/the-donut-and-score/), although this may imply some kind of relationship between [Altmetric](http://www.altmetric.com) and ORCID. The work should have a persistent, unique identifier and this should allow a unique Altmetric score, which seems to imply a well-formed algorithm for ranking works in the ORCID list... but here I confess my ignorance of whether or not this is actually feasible.

# Long story short : rank by importance.

So, basically : wouldn't it be nice to have an ORCID profile which at least tried to list my works ranked by "importance" ? We could have multiple definitions of what "important" means, but any of them would be better than ranking by something as insignificant as "title"[^nooffence]. This would really make the ORCID profile a more powerful tool in evaluation of researchers, both "at a glance", as well as during annual reviews as was my case.


# Disclaimer

Bruce Becker writes in his personal capacity and this post in no way reflects the policy or position of the Council for Scientific and Industrial Research. This article serves as a personal account and does not reflect any relationship between the CSIR and ORCID, DataCite or any other entity mentioned. It was written in the context of the [THOR Ambassador programme](https://project-thor.eu/become-an-ambassador/), which he is a member of.

# Footnotes

[^yourORCID]: *My* ORCID is <a href="http://orcid.org/0000-0002-6607-7145"><img src="{{ site_url }}/images/orcid_16x16.png" align="bottom" />orcid:0000-0002-6607-7145</a>
[^DataCiteCentres]: These are datacentres which have a DataCite DOI prefix associated with their repositories.
[^Actually]: Actually, I just sent the link to my profile. Ok, ***actually***, I just told him that the link was in every mail that I've sent in the past few months, because I've put my ORCID profile in my email signature, so *actually* there was no reason for all this email to be flowing around... but *actually* things weren't that clear cut as the discussion shows.
[^better]: Some would say "better".
[^Generic]: I'm keeping this post itentionally generic, since I feel that these issues will be experienced by many researchers and institutes, and that they are not specific to my institute. For the record, "my institute" is the [Council for Scientific and Industrial Researcher]
[^nooffence]: No offence meant, ORCID developers, you guys are awesome. It's just that "title" is not a good way to rank works, for obvious reasons.
