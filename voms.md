---
layout: page
permalink: /voms/
title: VOMS
image:
  feature: Marvin-Gaye-Featured-Image.jpg
---

VOMS : Virtual Organisation Membership Service

# TL;DR

A VOMS adds <em>permissions</em> to your identity, allowing you to use services on the grid.

Quickstart :

  - [x] Register in VO with your personal certificate
  - [x] Copy personal certificate to <code>$HOME/.globus/user[cert,key].pem</code>
  - [x] Create a proxy : <code>voms-proxy-init --voms <voms> (e.g. sagrid)</code>
{% highlight bash %}
voms-proxy-init --voms sagrid
Your identity: /C=IT/O=INFN/OU=Personal Certificate/L=ZA-MERAKA/CN=Bruce Becker
Creating temporary proxy ................................................... Done
Contacting  voms.sagrid.ac.za:15001 [/C=IT/O=INFN/OU=Host/L=ZA-UFS/CN=voms.sagrid.ac.za] "sagrid" Done
Creating proxy .................................. Done
Your proxy is valid until Tue Dec 15 05:46:27 2015
{% endhighlight %}
  - [x] Check that the proxy is still valid : <code>voms-proxy-info --all</code>
{% highlight bash %}
subject   : /C=IT/O=INFN/OU=Personal Certificate/L=ZA-MERAKA/CN=Bruce Becker/CN=proxy
issuer    : /C=IT/O=INFN/OU=Personal Certificate/L=ZA-MERAKA/CN=Bruce Becker
identity  : /C=IT/O=INFN/OU=Personal Certificate/L=ZA-MERAKA/CN=Bruce Becker
type      : proxy
strength  : 1024 bits
path      : /tmp/x509up_u500
timeleft  : 11:56:53
key usage : Digital Signature, Key Encipherment, Data Encipherment
=== VO sagrid extension information ===
VO        : sagrid
subject   : /C=IT/O=INFN/OU=Personal Certificate/L=ZA-MERAKA/CN=Bruce Becker
issuer    : /C=IT/O=INFN/OU=Host/L=ZA-UFS/CN=voms.sagrid.ac.za
attribute : /sagrid/Role=NULL/Capability=NULL
timeleft  : 11:56:53
uri       : voms.sagrid.ac.za:15001
{% endhighlight %}


# Virtual Organisations

In order to register to a Virtual Organisation, you need a personal certificate from a [trusted Certificate Authority]( {{ site_url }}/CertificateAuthorities ). There are several VO's supported - see a full list at <a href="http://operations-portal.egi.eu/vo/search">the EGI Operations Portal</a>

# Attributes

Attributes

# Proxies
