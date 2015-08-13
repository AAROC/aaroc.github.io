---
layout: page
permalink: /AAROC/index.html
title: Everywhere we go, people want to know...
tags: [AAROC, about]
image:
  feature:
---

# We are the Africa-Arabia Regional Operations Centre

The tales of Sinbad the sailor tell of a mythical bird, the Roc, encountered along his adventures on the seven seas. Swooping in to save sailors in distress all over the seas and mountains of Africa and Arabia, the Roc has come to the rescue of the intrepid in harsh and unexplored environments. As such, it has been chosen as our mascot. There are several Regional Operations Centres, but there's only one Africa-Arabia ROC.

> "The mission of the Africa-Arabia Regional Operations Centre is to promote and support collective, coherent and sustainable interoperability of e-Infrastructures within the region and beyond, to peer infrastructures in the rest of the world; and to act as a point of coordination and support to computational resource providers in the region, in order to promote and develop regional scientific and technical collaboration."

<ul class=" nav-justified panel panel-title nav-pills" title="how can we help you?">
  <div class="panel-title">How can we help you ?</div>
  <li><a class="navbar" href="{{ site_url }}/research">For Research Communities</a></li>
  <li><a class="navbar" href="{{ site_url }}/sites">For Resource Providers</a></li>
  <li><a class="navbar" href="{{ site_url }}/funders">For funding agencies</a></li>
  <li><a class="navbar" href="{{ site_url }}/developers">For developers</a></li>
</ul>

## Supporters

The [Africa-Arabia Regional Operations Centre](http://roc.africa-grid.org) (AAROC) is a technical collaboration of institutes from across Africa and the Arabian states, sponsored by regional NREN Alliances - the [Ubuntunet Alliance](http://www.ubuntunet.net) in Sub-Saharan Africa and the [Arab States Regional Education Network](http://www.asrenorg.net) (ASREN) in North Africa and the Arabian peninsula, as well as [West and Central African Research and Education Network](http://www.wacren.net).

---

<figure>
{%  for supporter in site.data.supporters %}
{% if supporter.type == 'NREN' %}
<div class="col-md-3" data-toggle="tooltip">
  <a  href="{{ supporter.url }}" alt="{{ supporter.title }}"><img src="{{ site_url }}/images/{{ supporter.logo }}" height="40px"></a>
</div>
{% endif %}
{% endfor %}
<figcaption>Regional and National NRENs supporting the ROC</figcaption>
</figure>

<figure>
{% for supporter in site.data.supporters %}
{% if supporter.type == 'project' %}
<div class="col-md-6" data-toggle="tooltip">
  <a  href="{{ supporter.url }}" alt="{{ supporter.title }}"><img src="{{ site_url }}/images/{{ supporter.logo }}" height="40px"></a>
</div>
{% endif %}
{% endfor %}<figcaption> Projects supporting the ROC </figcaption>
</figure>

---

The ROC has grown out of several international projects, including a long series of FP6 and FP7 projects :

  * [EUMED](http://www.eumed.eu) project series
  * [EPIKH](http://www.epikh.eu) exchange programme
  * CHAIN and [CHAIN-REDS](http://www.chain-project.eu) project series

## Members

It is fully supported by national initiatives in South Africa, Algeria, Morocco, Egypt, Jordan, Kenya and Tanzania. This blog tells the story of maintaining and developing services for scientists in the region, focussing on technical challenges and successes, and discussing the tools of the trade.


# Coordination

The Regional Operations Centre is coordinated  by the [CSIR Meraka Institute](http://www.csir.co.za/meraka), via an MoU with [EGI.eu](http://egi.eu). Running core services which allow the exchange of operational information and service interoperability, the ROC provides transparent access to European infrastructure by Africans and vice versa.

---
<figure label="OLA">
  <img src="{{ site_url }}/images/600px-OLA_SLA_framework.png" href="http://www.egi.eu"></img>
  <figcaption>Schematic diagram of the framework of MoU's and OLA's that allow interoperability between EGI and AAROC infrastructures.</figcaption>
</figure>

---

The figure illustrates the framework of agreements which allow this interoperability:

  1. AAROC acts as a ***Resource Infrastructure Provider*** to EGI.eu, and signs an ***Operating Level Agreement (OLA)*** with EGI.eu.
     1. This OLA states the *minimum levels* of operation of services, as well as *which* services which are needed to interoperate.
     2. EGI.eu in turn signs a ***Service Level Agreement***, allowing the ROC to interoperate via central services.
  1. EGI specifies a common OLA which all production sites have to implement, in order to provide an infrastructure of uniform and acceptable quality. This includes aspects such as
    1. which ***services*** should be offered by sites
    2. which ***interfaces*** should be exposed
    3. the  level of ***reliability and availability.***
  4. AAROC ensures that all [sites]( {{ site_url }}/sites) in the region participating to the ROC enforce the OLA and provides technical support to those which need help.

Enforcing and measuring these OLA's is done via ***central services*** offered by EGI.eu and ***core*** services offered by the ROC. The ROC also offers it's resource providers (sites) ***support*** services.

# Services

Services operated by the ROC fall into the *'Core Services'*, and *'Support Services'*. These are integrated with the '*EGI Central Services*'

## Central Services

As part of the MoU with EGI, AAROC has access to [central services](https://wiki.egi.eu/wiki/Core_EGI_Activities) operated by EGI.eu. These include

  * [Regional Support Centre](https://wiki.egi.eu/wiki/GGUS:AfricaArabia_FAQ) in GGUS
  * [Regional Operations Dashboard](https://operations-portal.egi.eu/rodDashboard/ngi/AfricaArabia/) in the Operations Portal


## Core services

Core Services include :

  * **SAM-NAGIOS instance** for measuring availability and reliability of site services
  * **Accounting server** for summarising and publishing accounting data to the central
  * **Grid Computing services** such as Workload management and Top-Level Information Indices.
  * **CVMFS Data Repository** for application distribution

## Support services

Support is provided by the ROC directly, as well as by participating sites, for site configuration, technical support and consultancy. Configuration management and tools for service deployment are also part of our activities.
