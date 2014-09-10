---
layout: post
title: "Now you can cite APHRC's data"
description: Reporting on some work to increase visibility and citability of Social Science data in Africa.
headline: Reporting on some work to increase visibility and citability of Social Science data in Africa.
category: CHAIN-REDS
tags: [Open Data, Collaboration, persistent identifiers, DataAccess, Data Repositories]
image: 
  feature: handle-pid.png
comments: true 
---

# TL;DR
<br>
As part of the [CHAIN-REDS](http://www.chain-project.eu), we have been working with the [African Population and Health Research Centre](http://aphrc.org) in Nairobi to improve discoverability and usage of their data sets. In particular, we've used a CHAIN-REDS service to issue their data sets [persistent identifiers](http://en.wikipedia.org/wiki/Persistent_identifier), so that researchers using this data can cite it reliably.
<br>

# A success story. 

This is a short success story of working with a leading research institute in Kenya, the African Population and Health Research Centre. As with all stories, it has a couple of characters who play parts, a bit of tension to resolve, a climax and ... a happy ending ! Of course, what you'll read here is a highly simplified account (as with all good stories), and is mostly to draw a line in the process in order to show some progress to the reviewers of the CHAIN-REDS project. 

We think this is a success story not only because of the fact that we finished what we set out to do, but because the slow cogs of intra-African collaboration did turn, and that cumbersome engine actually did some work[^thermo]. All of the actual results aside, consider how what is reported here may affect you, your work, and your collaboration. 

## What's this all about ? 

Good question; the answer depends on whether you want the short answer or the long answer.

  * **Short Answer**: It's about being able to cite datasets in scholarly output, in a consistent, reliable, persistent way
  * **Long Answer**: It's about data. Not even Big Data, just messy, important, relevant data. 
  
It's not often the long answer is shorter than the short answer; the "data issue" is so complex that a lot of time could be spent going into all of the implications of the APHRC's data, its openness, its availability, the reproducibility of the analysis thereof... If the average reader's attention span is anything to go by, I've only got you for about 3 or 4 minutes, so let's leave that for another day[^data4dev]. What we will go into is one quite simple aspect:

***Persistent Identifiers*** ... or rather - ***"Who issues our Persistent Identifiers"***

## The players 

> All the world's a stage, and men and women merely players. <br>
>   They make their entrances and their exits, <br>
>    And one man in his time plays many pars.<br>
>  - William Shakespeare, *'As you like it'*

It's very hard to *design* such a collaboration, although for these successes, a certain environment is certainly necessary (one which favours and supports collaborations, even in the absence of obvious direct benefits). This work was undertaken by members of three institutes, but we have to thank the [Carnegie Foundation](http://www.carnegie.org) for funding the [workshop](http://openuct.uct.ac.za/blog/promoting-discoverability-african-scholarship), organised by the [University of Cape Town](http://www.uct.ac.za)'s [OpenUCT](http://openuct.uct.ac.za/) initiative. Thanks to this fortuitous meeting, we were put in touch with the APHRC in Nairobi. The matter of their data was on the agenda : how to make it available, how to ensure that the right people get credited, how to ensure that the investment made in collecting the data - including the ability to analyse it, remains exploitable by Africans themselves. I attended the meeting as a representative of CHAIN-REDS project, to propose the Africa-Arabia Regional Operations Centre as a focal point for collaboration for African researchers... and to have a peek around Nairobi to see what fun things were happening there. 

## APHRC's data - the most important player of them all

APHRC is non-governmental research institute in the social sciences domain. They collect data sets of high social importance, especially in the Sub-Saharan region, relating to health and wellbeing, social and economic indicators, food security, etc. This data is collected in a rigorous way, and is often used to prepare policy statements and responses to societal challenges in Nairobi, Kenya and beyond. Since it has such great importance and the ramifications of the analysis and interpretations of this data go deep, it is understandable that it should be held to account. The data should be accessible, understandable, and reliable, if possible, permanently. 

## Software and data environment

Data collected by the APHRC is done so using the [Data Documentation Alliance](http://www.ddialliance.org) - a metadata schema which allows for the curation of the full cycle of research data, in the social sciences domain[^households]. Furthermore, they are using software from the [International Household Survey Network](http://www.ihsn.org), in particular the microdata portal. Remember this, it'll be relevant later.

So, the stage was set for the players (APHRC and their data, CHAIN-REDS and the ROC) for this little part of the "great play" of science. 

# Data Accessibility, Reproducibility, and Trustworthiness (DART)

Let's review some very simple, painfully obvious facts:

  1. One can only conduct reliable fact-based research if one has access to reliable facts - access to the data. 
  1. Of course, making sense of the facts, requires some context and understanding of the data (metadata)
  1. In order to be able to reproduce the analysis or results (and so, reinforce or counter-state research outputs), the data should be cited in the original research using a *persistent reference*

A scientific or scholarly output can be considered of higher quality if it not only produces a result, but publishes in an open way, the *method* and *means* by which that result was obtained. 
CHAIN-REDS has proposed, as part of its work plan, to demonstrate a combination of services to enable [Data Accessibility, Reliability and Trustworthiness](https://www.chain-project.eu/services). These services include metadata harvesters and semantic search engines based on metadata vocabularies, data transfer and retrieval systems and the usage of the [handle](http://www.handle.net) system to issue persistent identifiers. Let's see what all this has to do with APHRC's data.

## Accessibility

The first point here - Accessibility - has already been taken care of by APHRC. They had recently installed and configured the [microdata portal](http://aphrc.org/catalog/microdata/index.php/catalog/) at their site, which gave full access to the metadata. In order to access the raw data, one needs to sign a usage agreement, but this is done only to ensure that usage of the data occurs under the license agreement, and that users understand the policy. Any researcher can create an account and access the raw data if they so please, so the data is "open" in this sense. 

## Reproducibility

In order to claim that analysis of the data is *reproducible*, the data should of course be *discoverable* for a good period of time. If the data were published in the portal, then a campaign of analysis undertaken, and subsequently ended and then the portal taken offline, the results or interpretation of the data analysis would be no less reproducible than if the data had never been published in the first place. Reproducibility therefore implies ***persistence*** of the data sets; at the very least, a ***persistent identifier***, which will not change in time and doesn't depend on the physical or temporal location of the data. As suggested earlier, this is where we come in (stage left, with a bang) to the story.

## Trustworthiness

In a certain sense, the trustworthiness of the data depends on it's quality. This aspect, in a simplistic approach, is improved by the fact that it was undertaken by a respected institute[^citizen]. However, the use of a metadata schema (the DDI data schema) and widely-used tools (provided by the IHSN) certainly play a large role in this. While I won't go any deeper into the aspect of provenance and trustworthiness for lack of space, it's an interesting question to consider : 

> How do we decide which data is to be trusted  ?
<figure>
  <img src="{{site_url}}/images/ResearchCycle.gif">
  <figcaption>DDI in the full lifecycle of research data</figcaption>
</figure>[^DDIfig]
The one point we do wish to re-iterate is the primacy of the data repository. The fact that the data has been collected and kept in an institutional repository, with associated metadata of a certain standard associated with it, increases the likelihood that others will re-use it... precisely because they can trust it. Using - or in this case, ***citing*** the data - brings in turn great benefit to the research ecosystem around the data repository, and reinforces the conditions which generated it. By this, we mean that if the data is seen to be cited and used by others, the funders of the study will be convinced that providing these resources to the APHRC was worth the investment[^dataCurrency].

# The Success - PIDs for APHRC's data

Apart from including the APHRC data repository in the [CHAIN-REDS Knowledge Base](http://www.chain-project.eu/knowledge-base?p_p_id=ChainMap_WAR_ChainMap&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&tabs1=DR%20Site%20View)[^kb], the small role we played in this story was that of simply to :

  * ***issue persistent identifiers*** to the data sets of the APHR, 
    * allowing researchers to cite them, 
      * and citation indices to evaluate impact.
  
> "Why make such a big fuss over this ?"  <br>
>                    - Everyone reading this.

Well, simply because it's quite hard to get a DOI or other handle from an authoritative source in Africa. A simple glance at [DataCite]'s webpage will show only one issuer in Africa[^doiInSA]. While there are several [Open Access Document Repositories](http://www.chain-project.eu/knowledge-base) are issue authoritative persistent identifiers to their digital objects using the handle system, this is rarely the case for data repositories. The cost of obtaining a prefix from the relevant authority is certainly a prohibiting factor and to a first approximation may account for the lack of such DOI mints in Africa. However, in this case a further complication arose, which - if not the first issue that is confronted, certainly one of the most complex: metadata schemas. 

To our knowledge[^help], here simply does not yet exist a nice, comprehensive metadata harvester for digital data objects as there does for digital repositories. There are some initiatives, such as DataCite, which go some way to solving this, but automated discoverability remains a problem. So, unable to bring about world peace, we did the closest we could given our limited resources.

## The European Persistent Identifier Consortium - EPIC
<figure>
  <img src="{{site_url}}/images/handle-pid.png">
  <figcaption>Schematic representation of handle system resolution of digital objects</figcaption>
</figure>
[EPIC](http://www.pidconsortium.eu) is a consortium of institutes participating or otherwise involved in the [EUDAT](http://www.eudat.eu) project. Facing a similar problem to that of APHRC - needing to assign persistent identifiers to lots of digital objects in lots of data repositories - a prefix was obtain from CRI, in order to issue authoritative PIDs, or *handles* to data sets and other digital objects. A handle server operated by [GRNET](http://www.grnet.gr) currently issues PID's under this prefix. GRNET, as a partner of CHAIN-REDS - and thanks to an MoU signed between APHRC and the project[^talkToUs] - thus has the capability to issue PIDs in the form of handles to the data sets published by APHRC. 

## The gory details

While the actual issueing of the data sets was almost trivial, the reasoning and implementation bear mentioning here. Firstly, the handle server exposes a very user-friendly [REST interface](https://epic.grnet.gr/api/v2/). Credentials for the APHRC organisation were issued by GRNET thanks to the above-mentioned MoU, allowing us to write a few lines of python to issue the PIDs. The code[^ZenodoDOI] essentially 

  1. Extracts the latest list of data sets from the APHRC repository in CSV format
  1. Interrogates the API to see  whether the data set has been already issued a PID
     * If not, a PID is requested using the manual name assignment, using the same name of the data set in the APHRC catalogue
  1. Finally, updates the CSV with the newly-issued PID associated with the data set.

{% highlight python %}
    for row in df.itertuples():
        dataCollectionName=str(row[2])
        dataCollectionNumber=str(row[1])
        SUFFIX =dataCollectionName
        URL=REPO_URL+dataCollectionNumber
        URL_TO_OPEN=PIDSERVICE_URL+SUFFIX
        JSONDATA=[{'type':'URL','parsed_data':URL}]
        JSONDATATOSEND = json.dumps(JSONDATA);
        REQUESTDATA = urllib2.Request(URL_TO_OPEN, data=JSONDATATOSEND)
        REQUESTDATA.add_header('Content-Type','application/json')
        REQUESTDATA.add_header('Content-Length',len(JSONDATATOSEND))
        REQUESTDATA.get_method = lambda: 'PUT'
{% endhighlight %}

***Now, you can cite APHRC's data[^datacitation] ! hdl:/11239/***

<figure class="half">
  <img src="{{site_url}}/images/APHRC handles.png">
  <img src="{{site_url}}/images/converted-7217d904.gif">
  <figcaption>Left: Screenshot of the list of PIDs issued to APHRC data sets. Right: Demonstration of handle resolution using the <em>handle.net</em> service</figcaption>
</figure>

In principle, this PID should be included in the metadata of the digital object, and thus be directly associated with the data set, wherever it goes. 

# Conclusion and Next Steps

This work is the result of a fruitful collaboration, born from the presence of CHAIN-REDS activities in Africa. It is a small step forward in support of Open Access and Open Science in the region, and holds promise for continuing in various forms even after the end of the CHAIN-REDS project.

CHAIN-REDS has provided support and a concrete demonstration of a widely-used service in an area of high societal impact. The usage of PID's has been demonstrated and feasibility of using the REST API of the PID consortium confirmed
Clearly this work is only the end of the beginning, so let's attempt a brief look into the crystal ball to see what the near future may hold...

  *  **Ensure handover of the tool to APHRC**: We have provided a short support and consultancy service to APHRC, but in the long run, this should be used entirely by them, independently of any particular project. Of course, the code is open... so this should be quite easy.
  * **Promote the usage of the service amongst researchers and open access activities**: The issuing of PIDs could (should?) become routine while collecting and documenting data. Since the issueing of PIDs is a cost-free activity[^what-costs], the assignment of PIDs to data sets needs not be inhibited. Already the issueing of handles to digital objects in document repositories[^DSpace] is gaining traction, at least in South Africa and Kenya, and could become widely-spread.
  * **Interoperability with the Semantic Search Engine**: Some work should be done to investigate the interoperability of IHSN  and OAI. Where is the IHSN harvester, how does it work, what are the interfaces, etc ? It seems after brief investigations on the web that it would be possible to include the IHSN-linked microdata repositories to the [CHAIN-REDS Semantic Search Engine](https://www.chain-project.eu/linked-data).
  
Fun time, so stay tuned !


# About

## The CHAIN-REDS project

CHAIN-REDS is a FP7 project co-funded by the European Commission (DG CONNECT) aiming at promoting and supporting technological and scientific collaboration across different e-Infrastructures established and operated in various continents, in order to define a path towards a global e-Infrastructure ecosystem that will allow Virtual Research Communities (VRCs), research groups and even single researchers to access and efficiently use worldwide distributed resources (i.e., computing, storage, data, services, tools, applications).

## The Author

Bruce Becker is the coordinator of the Africa-Arabia Regional Operations Centre. He works for the [CSIR](http://www.csir.co.za) [Meraka](http://www.csir.co.za/meraka) Institute, in the [SANREN](http://www.sanren.ac.za) competency area, in the group. He represents the [Ubuntunet Alliance](http://www.ubuntunet.org)


You can find him on twitter at [http://www.twitter.com/brusisceddu](@brusisceddu), and on Github at [http://www.gtihub.com/brucellino](@brucellino). You can look at his [google scholar](http://scholar.google.it/citations?user=IjK816QAAAAJ&hl=en) page, but he would prefer that you look at his [Impact Story](http://www.impactstory.org/BruceBecker).

# Acknowledgements 

This work was funded by the [CHAIN-REDS](http://www.chain-project.eu) project (grant agreement 306819). Bruce Becker represented the [Ubuntunet Alliance](http://www.ubuntnet.org) for research and educational networking in Africa, as the official partner of the CHAIN-REDS project. Special acknowledgement to Michelle Willmers at the [OpenUCT Initiative](http://www.openuct.ac.za )

## Special thanks 

Special thanks goes to the members of APHRC, in particular the IT department and [Statistics and Surveys Unit](http://aphrc.org/our-work/research-programs/statistics-and-surveys-unit/) members : 

<figure class="third">
   <img src="http://aphrc.org/wp-content/uploads/2013/10/Paul-Odero.jpg">
   <img src="http://aphrc.org/wp-content/uploads/2013/10/Faye-Research2.bmp">
   <img src="http://aphrc.org/wp-content/uploads/2013/10/Donatien-Beguy_site.jpg">
</figure>

<div class="col-md-4">  
<p class="text-italic cursive small font-size:16"><a href="http://aphrc.org/team/paul-odero/">Paul Odero</a></p><em>APHRC IT Manager</em>
<p class="small">
Paul is in charge of all IT and web-based systems at the Center including the intranet and has worked towards the improvement of APHRC’s web systems and implemented open source solutions. He has over 7 years’ experience in Web Systems Development and holds a Bachelor of Science degree in Information Technology from Jomo Kenyatta University of Agriculture and Technology.</p>  
</div>  

<div class="col-md-4">  
<p  class="text-italic cursive small"><a href="http://aphrc.org/team/cheikh-mbacke-faye/">Cheikh Mbacke Faye</a></p>
<em>APHRC Senior Research Officer</em>
<p class="small">
Cheikh joined the Center in 2010 as the country manager for the Measurement, Learning and Evaluation (MLE) project in Senegal. He is currently acting as a senior research officer working with the Statistics and Surveys Unit (SSU).</p>  
</div>

<div class="col-md-4">  
<p class="text-italic cursive small"><a href="http://aphrc.org/team/donatien-beguy/">Donatien Beguy</a></p><em>APHRC Head of Statistics and Surveys Unit (SSU)</em>
<p class="small">
Donatien is the head of the Statistics and Surveys Unit. He holds a PhD in Demography from University Paris 10 (France), 2007, a Master of Arts degree in Demography from University Paris 1 (France), 2003 and a Bachelor of Science degree in Statistics from the National Higher School of Statistics and Applied Economics (Ivory Coast), 1998.</p>
</div>
<br>

# Footnotes and references

[^citizen]: This is not to say that individuals or citizen groups could not undertake similar activities themselves - we indeed hope that by providing open access to the underlying tools and services to such entities, that good research can be undertaken. 
[^data4dev]: A good start would be to read [the need for a data revoltion in Africa](http://aphrc.org/blog/you-say-you-want-a-data-revolution/) and other `#data4dev` links via twitter.
[^thermo]: Yes, I'm still clinging to my thermodynamic interpretation of e-Infrastructure. 
[^households]: It is particularly widely used in household surveys.
[^dataCurrency]: This brings back the analogy of data as a currency, which holds great value to the entity which creates it.
[^doiInSA]: This is the [South African Earth Observation Network](http://www.saeon.ac.za), run on behalf of the [South African National Research Foundation](http://www.nrf.ac.za). It is not yet clear *who* SAEON is authorised to issue DOI's for, but we've been in discussion with all parties.
[^CHAIN-KB]: Here we cite the CHAIN-REDS Knowledge Base, which contains one of the largest collections of metadata sources of Open Access repositories on the world. It has been compiled by using the OAI-PMH protocol. Most repositories have been automatically discovered using [OpenAIRE](http://www.openaire.eu), however a significant portion have been "discovered" by CHAIN-REDS and added manually during the course of the project. 
[^help]: We did a bit of research on this, but it's a vast topic. Please leave feedback in the comments if you have informative or even contrary views on this point, we'd be very open to understanding this better.
[^talkToUs]: If you're reading this and are thinking "hey, I could use some PIDs myself", please don't hesitate to get in touch. 
[^ZenodoDOI]: Bruce Becker (2014). Demonstrator Release. ZENODO. 10.5281/zenodo.11613
[^what-costs]: Of course, issueing a prefix costs money, but cost is not calculated on a per-object basis.
[^DSpace]: Such as the several [DSpace](http://dspace.org) repositories which enable automatic handle assignment currently operating in the region. It's not clear whether the majority of these however have CNRI-assigned prefixes and are thus globally resolvable.
[^kb]: The CHAIN-REDS Knowledge Base is one of the largest compilations of e-Infrastructure related information including projects, computing centres, data and document repositories, etc.
[^DDIfig]: See [http://www.ddialliance.org/what](http://www.ddialliance.org/what)
[^datacitation]: Becker, Bruce (2014): PIDs issued to APHRC microdata portal. figshare. http://dx.doi.org/10.6084/m9.figshare.1165516 Retrieved 14:59, Sep 09, 2014 (GMT)
