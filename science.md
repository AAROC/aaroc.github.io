---
layout: page
permalink: /science/
link: science
modified: 07 July 2015
title: For those about to Science !
headline: Scientist ? Student ? Researcher ? If you want to run applications, you've come to the right place.
tags: [research, science, applications, users]
image:
  feature: labtocat.png
codrops: false
---

<h1>Using the platform</h1>

As infrastructure providers, we're here to make sure there's enough power to get what you want to do done. There are many ways to interact with the infrastructure, such as command-line interfaces, REST API's and web-based services. There is no catch-all "correct" way, and you may need to experiment a bit to find the best method for your project(s).
<div id="content">
    <ul id="tabs" class="nav nav-tabs" role="tablist">
      <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab" class="active">First time users</a></li>
      <li role="presentation"><a href="#compute" aria-controls="compute" role="tab" data-toggle="tab">Computing</a></li>
      <li role="presentation"><a href="#data" aria-controls="data" role="tab" data-toggle="tab">Data management</a></li>
      <li role="presentation"><a href="#sgw" aria-controls="sgw" role="tab" data-toggle="tab">Science Gateways</a></li>
      <li role="presentation"><a href="#vos" aria-controls="vos" role="tab" data-toggle="tab">Virtual Organisations</a></li>
      <li role="presentation"><a href="#openscience" aria-controls="openscience" role="tab" data-toggle="tab">Open Science</a></li>
    </ul>

  <div class="tab-content">
    <div role="tabpanel" class="tab-pane fade active" id="profile">
      {% include AuthnAuthz.html %}
      {% include Middleware.html %}
    </div> <!-- tabpanel -->

In order to execute applications and store data on the grid, you'll need a *context*. This is provided through an *identity* provider and an *authorisation*.

  <div role="tabpanel" class="tab-pane fade" id="compute">
    Coming soon.
  </div>

  <div role="tabpanel" class="tab-pane fade" id="data">
    Coming soon.
  </div>

  <div role="tabpanel" class="tab-pane fade" id="sgw">

    <h1>Science Gateways</h1>

    We offer access to several Science Gateways. These are easy-to-use web interfaces to predefined applications. Most of them are based on the <a href="http://www.catania-science-gateways.it">Catania Science Gateway Framework</a>, and rely on standards-based technologies :
    <ul>
      <li><a href="https://redmine.ogf.org/projects/saga-wg">Simple API to Grid Applications</a>, in particular, the <a href="https://forge.in2p3.fr/projects/jsaga">jSAGA implementation</a></li>
      <li><a href="http://en.wikipedia.org/wiki/Java_Portlet_Specification">JSR 268/286 Portlet Standard</a></li>
      <li><a href="http://en.wikipedia.org/wiki/SAML_2.0">SAML-2.0</a> and <a href="https://shibboleth.net/">Shibboleth</a>-based identity federation.</li>
    </ul>

  </div>
  <div role="tabpanel" class="tab-pane fade" id="vos">
    Coming soon.
  </div>
  <div role="tabpanel" class="tab-pane fade" id="cli">

  <h1>Wanna drive stick ?</h1>

  Most of our sites provide <a href="http://eu-emi.eu">EMI</a> middleware interfaces, particularly gLite. If you would like to use the command-line interfaces to these, take a look at <a href="{{ site_url}}/grid-tutorial">the tutorial</a>
  </div>
  <div role="tabpanel" class="tab-pane fade" id="openscience">
  coming soon
  <!-- Open data
  persistent identifiers

  -->
  </div>

  </div> <!-- tab content -->
</div>
