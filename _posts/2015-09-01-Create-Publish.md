---
layout: post
title:  'Creation vs Publication'
description: 'Horses for courses in the Open'
headline: 'How to get things done that <em>stay</em> done'
category: blog
tags: [blog, Open Access, Github, collaboration, Persistent Identifiers, pubishing, creative]
image:
  feature: r7Z09Ht.gif
  attribution: Courtesy of [The Pattern Library](http://thepatternlibrary.com/#alchemy)
comments: true
mathjax: false
discourse: false
---

# Simple questions

The best questions are simple:

> When should we use github and when should we use oar?
>     -- Bjorn Pehrson.

This is always  a matter of style, and what suits the team you're working in, but here's how I feel comfortable:

# Different tools for different phases.

Github and OAR (whether the invenio-based OAR, or any other Open-AIRE compliant OAR) are two different things used for different stages in the scholarly communication lifecyle.

  1. Github is used for _collaborating_ and _creating_
  1. OARs are used for _publishing_ and _curating_.

## The creative phase.

I put everything I work on in Github, because I know that it will be :

  1. Change controlled - I can push updates to the repository and keep a log of my work
  1.  Testable - at ever commit I can trigger a set of tests if need be
  1. Collaborative - others can fork my repository, send me pull requests and contribute to it easily; github keeps track of the contributors.
  1. Safe - I'm never going to lose work if it's pushed to Github. I can replicate it to as many remotes as I like.

Now, this is during the _creative_ process, when there are changes under way and things are being built and tested. This goes for code as well as websites or even articles to journals.  when it comes to _publish_, the work is in a stable and publishable state - a kind of _version_ if you like. Now, Github and other similar services allow you to publish versions of you work, but how to you create something that will be citable with a persistent URI ? This is where OARs come in.

## The productive phase

When I am ready to say "ok, this product is final" - ie issue a permanent version, I usually assign a specific persistent identifier with a specific release. [Zenodo](http://zenodo.org) - which is based on [Invenio](http://invenio-software.org), which in turn Sci-GaIA's [OAR](https://oar.sci-gaia.eu) is based on) ) does this very nicely by connecting via API to Github, requesting the list of releases of a repository and issueing a [DOI](http://www.doi.org/) from [DataCite](https://www.datacite.org/) for a new release.

This  is one aspect of the persistence of a product - the other is the persistence of the creators of that product. While there is no unique way to do this, [ORCID](http://orcid.org/) is probably the most widely used and reliable.

## Reproducibility, Citability, Discovery.

This may sound like a lot of work, but actually there are many advantages to simply putting things on the web somewhere :

  1. By putting _products_ (code, articles, etc) into an OAR and issuing them persistent, unique identifiers, you can build a library of what you have published.
  1. By _linking_ them to the code and other tools which created them using Github, you can make these products _reproducible_, which is one of the main issues the project is trying to address.
  1. By complying with the OAI standards, your work will be included in the data and article citation indices and therefore will be more discoverable to other researchers.

# Dealing with Data

Finally, one place where Github "breaks down" is when it comes to dealing with large files, _i.e._ data. Git's change tracking algorithm sees every change to a binary file no matter how small as a 100% re-write and since it keeps the entire history of the file, this results in a very fast exploding repository. It's far better put data and large digital artefacts in a digital repository, which may or may not have change control in it... here, the important thing is the _semantics_ of **how** that artefact was created. If the data is linked semantically - via it's metadata - both to the creator and the creation process, then it is reproducible and citable.

--------


<h2 class="post-title text-center"><a href="http://www.sci-gaia.eu">Sci-GaIA</a> is working on an integrated Open Science platform which delivers these services to research communities.</h2>

------

# Comment, discuss, extend

If you'd like to give some feedback or extend the discussion, please head over to the original [topic](http://discourse.sci-gaia.eu/t/publishing-vs-creating-in-the-open/) on the discussion forum.

<div id='discourse-comments'></div>

<script type="text/javascript">
  DiscourseEmbed = { discourseUrl: 'http://discourse.sci-gaia.eu/',
                     discourseEmbedUrl: 'http://www.africa-grid.org/blog/2015/09/01/Create-Publish/' };

  (function() {
    var d = document.createElement('script'); d.type = 'text/javascript'; d.async = true;
    d.src = DiscourseEmbed.discourseUrl + 'javascripts/embed.js';
    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(d);
  })();
</script>
