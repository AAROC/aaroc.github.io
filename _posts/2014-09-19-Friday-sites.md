---
layout: post
title: Site configuration 
description: Site Configuration
headline: What to do when your site wants to join the grid
category: Blog
tags: [AAROC, operations, setup, documentation, middleware, tgif, EGI, EMI, Globus, middleware]
image: 
  feature: Matterhorn.jpg
comments: true 
---
# TGIF !

It is friday, which means... basically more work to do on the weekend for most of us. But let's not let that get us down. After all, it's Happy Hour or Family Time (or whatever you're in to) ***somewhere*** out there in the world.

Before we get our Friday on though, let me tell you a story about a fairly common situation... 

> Scientist meets science, science requires computing, computing requires configuration and sharing....
<figure>
  <img src="{{ site_url }}/images/no.gif"></img>
</figure>
> ...  scientist cries, suffers, ditches everything and contemplates the futility of it all on a  beach somewhere. 

Most times, and especially when it comes to sharing and integrating "computing" in a larger infrastructure like AfricaGrid, this leads to hours of painful confusion as to what the heck to do when it comes to setting up the new shiny. 

We've all been there. This grid thing is *hard*, time is limited and we're all under pressure ... 
<br>
***why can't there just be a simple guide to set up a new site !?*** 
<br>

Part of that is just "writing proper documentation is boring[^ouch]", but part of it is legitimately difficult. There are so many variables and choices to make that it's almost impossible to give a definitive guide to someone coming into this game for the first time. 

# It's happening, right now... and it's so wrong.

This is a summary/repost of a situation happening right now at [UKZN](http://www.ukzn.ac.za), where a physicist[^also] and member of [SA-CERN](http://www.sa-cern.ac.za), in the  [ATLAS](http://atlas.ch) collaboration is trying to get some kit integrated. There is, as usual, someone in a support department of the university who is actually tasked with getting the installation finished, and we're liaising with Sahal (in this case) as the primary user. 

In a perfect world, the "tech-support" guy[^notreally] would just recieve a set of instructions and go off and follow them to a tee. As I've already said above, this is pretty much impossible, bar generating highly customised instructions, which is why we are putting less effort into *documentation* and more effort into [*code*](http://aaroc.github.io/categories/index.html#devops). We want to be able to ask for a few relevant variables, and then provide the code to *execute* the installation and configuration of relevant services in one go. 

***#DevOps FTW baby !***

# It's happening now, and it's muuuuch better.

We've made great strides towards providing the code for this "*executable infrastructure*" for the various services expected in grid sites. In the [AAROC DevOps Github repo](http://github.com/AAROC/DevOps), you can find mostly [Ansible](http://ansibleworks.com) playbooks. Not that we have a preference for Ansible - we are encouraging sites using [Puppet](http://www.puppetlabs.com), Chef or whtever else to commit their magic to the repo. It's turning, slowly into a shared repository of ***actual sites*** - the code contains not only the *model* of the site (variables, service states, etc), but also a *method* - more like an "*algorithm*" than just information - for creating the actual site. Kinda like DNA in a way, in that it describes the machine and the model. Anyway, that's an analogy for another time. 

# So, what's a guy to do ? 

Let's take this case in point, at UKZN. What follows is a short summary of the acutal mails which were exchanged with the site contact. Hopefully this can be of use to our site admins and directors the next time a new site comes along and wants to help us build this thing called e-Infrastructure in Africa. 

## Get in touch.

It would be a shame for the guy setting up the cluster not to have help - he can write to operations-africa-grid@africa-grid.org for friendly advice.

## There is actually some documentation, believe it or not.

The official documentation for middleware is hosted by the *middleware product teams*. Things get a little confusing, so if you're interested, this is how things work : 

  1. the product teams make software. These are things like CREAM, DPM, Globus, etc. The actual packages and components. 
  1. it goes into one of the distribution repositories. These are EMI and Globus.
  1. Infrastructures repackage the repository artifacts (the rpms or debs) according to the SLAs they may have with their sites or technology providers. 

So, you end up with things like [UMD](http://repository.egi.eu), the Lord-of-the-Rings-inspired "Unified Middleware Distribution" which packages some things from [EMI](http://www.eu-emi.eu), some things from [Globus](https://www.globus.org/) and some things from their own. 
WLCG is also an infrastructure, so they repackage stuff too and there isn't an easy-to-describe mapping between these[^venn].

What we usually propose to new sites is to deploy a site according to the basic interoperability requirements between AfricaGrid and EGI, and then make tweaks on top of that. 

So, if you want to **install** packages, you should use the UMD repository : [http://repository.egi.eu/](http://repository.egi.eu/)

If you want to read the **documentation**, you need to follow the product pages - mostly [http://www.eu-emi.eu/products](http://www.eu-emi.eu/products)

Each package has 

  * Functional  Description: 
  * User Guide:  
  * Client Installation and Configuration   
  * System Administrator Guide 
  * Service Reference Card 
  
I would start at the latter and find the product you're interested in. 

## For example...

Let's say you want to have a new UI. You go to [the UI product page](http://www.eu-emi.eu/products/-/asset_publisher/1gkD/content/emi-ui-2) and look for the **System Administrator guide**. Following this you are almost 100 % guaranteed to be able to deploy a vanilla service. You need to communicate the requirements of the machine to your infrastructure provider (in this case the university), which are in the Service Reference Card, then you need to ensure that the service is properly integrated into the rest of the infrastructure by communcating the site- or service-specific configuration. These are things like the site-bdii endpoint, the VO's enabled at the site, etc.

This last step is usally done by opening a ticket on GGUS to certify the site. This is a purely [operational procedure](https://wiki.egi.eu/wiki/PROC09) and means that the ops VO is enabled and the probes that check it on that VO by [our  nagios](https://nagios.c4.csir.co.za/nagios) all pass. 

## Be smart

Finally, while the guy setting up the cluster can of course decide whatever he/she likes, we've done a lot of sites and if you're starting from scratch, you truly do not want to do it by hand when there are ready-made playbooks for you. 
<figure>
<img src="{{ site_url }}/images/nodevops.gif">
<figcaption>It's just so '90's you know ?</figcaption>
</figure>

Whenever he's ready or wants a hand or some suggestions, get them or you to drop a mail to the operations mailing list above.

# Footnotes

[^ouch]: Ouch ! But yes, it's true, we like hacking better than writing documentation, we know, it's not a great excuse. Hey, anybody want to volunteer ? Not all at once now...
[^also]: Also, buddy and dancing legend - [this guy](https://www.facebook.com/sahal.yacoob)
[^notreally]: We find this an almost derogatory term, "tech support". We really believe that there is place for a third career of science here, which is fundamental to e-Science and collaboration, and we're trying to fund ways to share it. See [http://brucellino.github.io/thesituation/AAROC-Open-Science/](http://brucellino.github.io/thesituation/AAROC-Open-Science/)
[^venn]: Maybe one day soon, someone clever will create the definitive Venn diagram and angels will sing.
