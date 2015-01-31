---
layout: page
permalink: /science/
title: For those about to Science !
tags: [research, science, applications, users]
image:
  feature: labtocat.png
---

Scientist ? Student ? Researcher ? If you want to run applications, you've come to the right place. As infrastructure providers, we're here to make sure there's enough power t get what you want to do done. There are many ways to interact with the infrastructure, such as command-line interfaces, REST API's and web-based services. There is no catch-all "correct" way, and you may need to experiment a bit to find the best method for your project(s).

Here are a few pointers to get you started.

# Getting started

In order to execute applications and store data on the grid, you'll need a *context*. This is provided through an *identity* provider and an *authorisation*.

## Signing up.

The resources provided by the ROC are owned and operated by several different institutions, in a federation. In order to provide transparent access to these, we allow central registration via the [Perun](http://perun.c4.csir.co.za) service. If you're a new user, and you'd like to start using the grid, sign up to the [Catch-All VO](https://perun.c4.csir.co.za/non/registrar/?vo=sagrid.ac.za) for the region.

This will give you access to the user interfaces, and identify you to various services.
## Choose a VO

There's a catch-all one.

But you can select lots of different ones

## Everywhere you go, you always take your ID with you

By default, identification is done with perosonal x.509 certificates [get yours](httpsL//security.sanren.ac.za./CA).
Federated identity helps you to get on the grid.

# Science Gateways

We offer access to several Science Gateways. These are easy-to-use web interfaces to predefined applications. Most of them are based on the [Catania Science Gateway Framework](http://www.catania-science-gateways.it), and rely on standards-based technologies :

  * [Simple API to Grid Applicaitons](https://redmine.ogf.org/projects/saga-wg), in particular, the [jSAGA](https://forge.in2p3.fr/projects/jsaga) implementation
  * [JSR 268/286 Portlet Standard](http://en.wikipedia.org/wiki/Java_Portlet_Specification) and the [Liferay](http://www.liferay.com) portal
  * [SAML-2.0](http://en.wikipedia.org/wiki/SAML_2.0) and [Shibboleth](https://shibboleth.net/)-based identity federation.

# Wanna drive stick ?

Most of our sites provide [EMI](http://eu-emi.eu) middleware interfaces, particularly gLite. If you would like to use the command-line interfaces to these, take a look at [the CLI user guide]({{ site_url}}/grid-tutorial)
