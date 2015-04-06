---
layout: post
title: "NICIS : Stepping stone to a SA Cyberinfrastructure Commons ?"
description: Presentation given at CHAIN REDS Conference
Open Science at the Global Scale: Sharing e-Infrastructures, Sharing Knowledge,  Sharing Progress
headline:
category: blog
tags: [Open Science]
image:
  feature: testsignal.jpg
comments: true
---
# TL;DR

There are a lot of benefits from the development of an Open Commons for science, but what are these exactly, in the case of e-Infrastructure and e-Science ? What are these Commmons in South African e-Infrastructure ? Should there be one, what would the implications for researchers, educators, operators and developers in the region be ? This is the long writeup of a [talk](http://www.slideshare.net/brucellino/nicis-stepping-stones-to-a-cyberinfrastructure-commons) I gave on behalf of NICIS at the [CHAIN-REDS](http://www.chain-project.eu) [final project](http://www.chain-project.eu/final-conference). The end of the CHAIN-REDS conference is an opportune occasion to reflect on our path as NICIS starts, [EGI.eu](http://www.egi.eu) launches the [Open Science Commons](https://opensciencecommons.org) against the backdrop of the ever-growing [Open Access movement](en.wikipedia.org/wiki/Open_access). We explore how concepts such as the Commons, complex dynamic systems and market economics, applied to an e-Infrastructure, can be beneficial to those building, using and managing it.

# What does it mean to be a Commons ?

We often bandy around the phrase "The Commons" as if it were some well-defined, shared concept that we all agree is something worth aspiring to. Upon deeper reflection, though, perhaps it is not such a widely-held aspiraton, nor an objective concept, but something of a social construct. I, for example, do not know if "The Commons" holds the same connotations when translated into other languages; it is certainly a product of the society, and one may well assume that this concept is invariant across European society, but how does it fare when various African societies are interrogated, or other parts of the world ? This may seem like a philosophical or anthropological tangent, however given the vast recent interest in the concept from academic and scientific fields, I think it merits deeper thought before we start waving it about as the next big thing[^NotTheWholeStory].

<figure class="half">
<img src="{{ site_url }}/images/noise.gif" width="100">
<img src="{{ site_url }}/images/testsignal.jpg">
<figcaption>Looking for a signal in the noise</figcaption>
</figure>

We now investigate definitions and usages of the term, to see what it means to others, and how those meanings may be interpreted in our context - that of e-Infrastructure and e-Science.

## Dear Internet:

Our first instinct when trying to find out what something *means* is often to just ask the internet. So, what does google tell us about [the definition of The Commons](https://www.google.com/search?q=define:+The+Commons) ?

<figure>
<img src="{{ site_url }}/images/Define-commons.png">
<figcaption>The definitions of "The Commons" according to Google</figcaption>
</figure>

We find three definitions:

  1. ***the common people regarded as a part of a political system***
  2. ***land or resources belonging to or affecting the whole of a community***
  3. provisions shared in common; rations

Let's keep those first two in mind. What are some of the entities out there calling themselves "commons" ?

### The Creative Commons

Our next stop in the "What is a Commons" express is perhaps the most widely-known digital commons : the [Creative Commons](http://creativecommons.org). The Creative Commons is about rights - specifically copyright - in the internet era.

> **Mission** : Creative Commons develops, supports, and stewards legal and technical infrastructure that maximizes digital creativity, sharing, and innovation. <br>
> **Vision** : Our vision is nothing less than realizing the full potential of the Internet — universal access to research and education, full participation in culture — to drive a new era of development, growth, and productivity.
> <small>The [mission statement](http://creativecommons.org/about) of the Creative Commons.</small>

Here, interestingly, we see the word _"infrastructure"_. However, let's not ignore the words _"creativity"_ and _"sharing"_ Let's keep those in mind.

### The Wikimedia Commons

Following the Creative Commons, the next most visible "Commons" is perhaps the [Wikimedia Commons](https://commons.wikimedia.org/wiki/Main_Page). The Wikimedia Commons describes itself as

> A database of [...] media files to which anyone can contribute

Notable here, I think are the concepts of _"inclusivity"_ and _"contribution"_. This is a commons _for_ all, _by_ all.

### The Flikr Commons

Flikr is a commmercial photo storage and sharing website, once boasting the only relevant place on the web for serious photography. Things may have changed, as they always do and will on the web, however it is not disputed that Flikr has a huge set of digital media inn both private and public collections. A large portion of the public collections are donations from public library collections, most notably the [Library of Congress](http://loc.gov).

The Flikr Commons has two goals :

  1. To increase access to publicly-held photography collections, and
  2. To provide a way for the general public to contribute information and knowledge.

Again, we see both the benefits to the community (increased _access_, improved _participation_) as well as the responsibility that communities hold when participating (enriching the data with tags, etc.)

### The Internet Archive

A similar mission is held by perhaps the world's larges public internet library, [Archive.org](http://archive.org). This is again a metacollection of public resources, most of the content being in the public domain, created with preservation and access in mind. While it doesn't explicitly claim to be "a commons", the Internet Archive's [mission](https://archive.org/about/) includes:

  * Protecting our right to know
  * Exercising our "right to remember"

These are inalienable rights in the _real_ world, and most would consider them so in the _cyber_ world too. A Commons is therefore _also_ about telling us who we are and where we come from.

## Everybody comes from Somewhere

I come from Cape Town, which has, of course, the best commons of them all:

<figure>
<img src="https://farm9.staticflickr.com/8186/8077223474_227513ae66_b.jpg">
<figcaption><em>"Looking across Rondebosch Common at Table Mountain"</em> by <a href="https://www.flickr.com/photos/jennyhallward/">Jenny Hallward</a> </figcaption>
</figure>
<!--- TODO : figure out how to add the cc icon --->

The [Rondebosch Commons](http://www.capetown.gov.za/en/parks/Pages/RondeboschCommon.aspx) is a piece of land that was left _as-is_, in the shadow of Table Mountain, in Cape Town. The area supports natural vegetatio and wildlife, but is also used by local communities for a variety of specific activities. It is an example of the most commonly-used meaning for a "commons" - land which is not owned or regulated by any one entity (personal or corporate) in particular, but set aside for public use and governed by a collective authority (in this case, the local government)

###  Exploiting the Commons

One of the most associated phrases to "The Commons" is "Tragedy" as in ["the tragedy of the Commons"](http://en.wikipedia.org/wiki/Tragedy_of_the_commons). This economic theory has been explored in depth, and in the case of intangible resources such as software, skills and information, many different outcomes are more probably, including a ["Triumph of the Commons"](http://en.wikipedia.org/wiki/Comedy_of_the_commons#Triumph_of_the_commons). We will delve into the positive aspects of the Commons below, but would like to point out immediately that in the absence of a commons certain community activities are not possible. Using the analogy of the Rondebosch Common above, if that land had been developed into privately-owned structures such as the ever-present shopping mall, or a private park, the various activities that it currently supports would be impossible. Groups which use the Common for running practice, leading to happier and healthier communities, and schools which use the Common to teach children about the natural ecosystem and biodiversity of the area are just two examples.

The point to remember is that the Commons supports activities for which it was not originally intended, by allowing individuals or groups to exploit it, while nonetheless respecting the rights of the others.

## What is a Commons Anyway ?

So, the Commons is something that many talk about and we tend to take for granted the fact that there is a (forgive the pun) _common_ understanding. The audience may well be experiencing the confusion felt by "Lady" in the Disney classic [Lady and the Tramp](http://en.wikipedia.org/wiki/Lady_and_the_Tramp), upon the birth of "Darling's" baby. She hears everyone talking about and cooing over "Baby", but has no idea what they are actually referring to.

<figure>
<img src="{{ site_url }}/images/lady.jpg">
<figcaption>"What <em>is</em> a Commons anyway?"</figcaption>
</figure>
So, having done a short (and yes, somewhat biased) analysis of various kinds of Commons, perhaps we can extract the following defining aspects. The Commons:

  * **has the widest constituency: "Common People"**
  * **belongs to the whole** rather than some limited group
  * **provides infrastructure**, allowing people to **contributed and share**
  * **protects rights**
  * **improves access and participation**

If an e-Infrastructure is to be a Commons, or at least a stepping stone to a commons, then it should respect some or all of these aspects, in terms of the widest possible scientific and academic community.

## The Commons, Openness and Science

Let us concentrate now on the relevance of the Commons to these scientific and academic communities. We have [previously published](http://brucellino.github.io/blog/2015/02/24/ECommonsStrategy/) thinking around what an Open e-Science Commons would be, and how this would inform strategy for the evolution of SAGrid in South Africa.

<!--- a examples of Open science and Open Infrastructure -->
<div class="row">
  <div class="col-md-6">
    <a href="http://www.openingscience.org/get-the-book/"><img src="{{ site_url }}/images/Bildschirmfoto-2013-08-20-um-16.12.38-200x300.png" class="img-rounded img-responsive center-block" height="auto" display="block"></a>
  </div>
  <div class="col-md-6">
    <div class="row">
      <a href="https://www.opensciencecommons.org/"><img src="{{ site_url }}/images/OSC-side-web-350x80tsp1.png" class="img-rounded img-responsive center-block" height="auto" display="block"></a>
    </div>
    <div class="row">
      <a href="http://www.egi.eu"><img src="{{ site_url }}/images/EGI_Logo_RGB.svg" class="img-rounded img-responsive center-block" height="auto" display="block"></a>
    </div>
  </div>
  <div class="row">
    <div class="col-md-6">No discussion on Openness and the Commons for research would be complete without mentioning the <a href="http://www.openingscience.org">Opening Science</a> project and recently-released homonymous <a href="http://book.openingscience.org/">book</a>
    </div>
    <div class="col-md-6">The European Grid Initiative is one of the main supporters of the Open Science Commons, which aims to implement the reccomendations of the <a href="http://e-irg.eu/documents/10920/11274/e-irg-white-paper-2013-final.pdf">2013 White Paper</a> of the <a href="http://e-irg.eu/">e-Infrastructure Reflection Group</a>
    </div>
  </div>
</div>

Of course, this is by no means original or isolated work. There are entire infrastructures dedicated to enabling Open Science[^EGIasOpen], and many publicly- and privately-funded projects which are advancing this philosophy[^CCScience]. While it may not be universally applicable across all domains of research, the scientific method is at its heart Open. Although _some_ scientific research may be Closed, it would be hard to argue that the infrastructure that supports research communities _should_ be closed. We are not referring here to the individual resources - the data and compute facilities, as well as certain kinds of software - which are used to _exploit_ the Commons, but rather the environment, policies and infrastructure which enable this kind of exploitation - sharing resources and ex

> Being able to produce Open Science then goes hand-in hand with the development of a Commons on which to perform it.

# Systems Thinking

Only by placing constraints on a system, can it actually do work.

## e-Infrastructure as a Complex-Adaptive System


# The South African National Integrated Cyberinfrastructure System, NICIS

## A system for Cyberinfrastructure

## Components: Network

## Components: Compute

## Components: Data

## Components: People

# The Commons as an Exchange

# Implications for Commoners

## Teaching and Research

## Fork my Science

## Fork my Infrastructure

## New careers

# Implications for the Region

# Wherefore art thou, Commons ?

# The Commons: An interim conclusion

# References and Footnotes

[^NotTheWholeStory]: The analysis contained within this article can by no means be considered complete or unbiased. We consider what a Commons **is**, not what it **is not**. The negative definition of what comprises a Commons may be just as instructive as the positive.

[^OpeningScienceBook]: The Opening Science book is itself an Open Book, allowing anyone to contribute, according to theh guidelines set out by the authors. The book is a seminal work on the state of the art of Open Research at the dawn of the 21st century.

[^EGIasOpen]: Both [EGI.eu](http://www.egi.eu) and [OSG](http://www.opensciencegrid.org) have fully embraced this philosophy.

[^CCScience]: A good sample can be found at the [Creative Commons Open Science](http://www.creativecommons.org/science) page.
