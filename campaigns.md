---
layout: page
permalink: /campaigns/
title: Operations Campaigns
tags: [Campaigns, Operations]
image:
  feature: topguntocat.png
---

# AfricaArabia ROC Campaigns

*Operations Campaigns* are medium-term projects which are conducted as needed, when there is a request from EGI, an ROC site or a user community, which requires ***coordinated*** action at most or all sites. Campaigns should have a leader, who is responsible for getting sites to stick to a schedule or taking action; campaigns are also time-limited, meaning that they have to have a start and an end. They differ from [projects]({{site_url}}/projects/) in their

  * **Scope**: Campaigns are usually of very limited scope, addressing a single focussed aspect of site services
  * **Impact on sites**: Campaigns should affect all sites, hence the need for coordinated action
  * **Interested parties**: Campaigns affect only the [operations team]({{site_url}}/operators)

While this is just another way of doing what we've always been doing, it gives some more visibility to important ROC-wide tasks and allows clearer delegation of tasks. Also, it will allow us to report better to supporting projects such as [CHAIN-REDS](http://www.chain-reds.eu) and [ei4Africa](http://www.ei4africa.eu), as well as relying parties like EGI.eu. Campaigns are documented on the [Github wiki pages](https://github.com/AAROC/DevOps/wiki/Ops-Campaigns) of the [AAROC](https://www.github.com/AAROC) [DevOps repo](https://github.com/AAROC/DevOps).

# Operations Campaigns
<!-- We need to sort on the state to put the campaigns under way first -->

{% assign sorted_campaigns = site.data.campaigns | sort:'priority' %}

<table class="table table-hover table-condensed">
  <thead>
    <tr>
      <th>Name</th>
      <th>Leader</th>
      <th>State</th>
      <th>Period</th>
    </tr>
  </thead>
{% for campaign in sorted_campaigns reversed %}
{% if campaign.name != null %}
  <tr>
{% if campaign.wiki != null %}
    <td class="text-left"><a href="https://github.com/AAROC/wiki/{{ campaign.wiki }}"><span><i class="fa fa-github-square"></i></a> {{ campaign.name }}</td>
{% else %}
    <td class="text-left"><span><i class="fa fa-github-square"></i> {{ campaign.name }}</td>
{% endif %}
    <td>{{ campaign.leader }}</td>
    <td><span class="label label-{{ campaign.state.label }}">{{ campaign.state.name }}</span></td>
    <td>{{ campaign.start }} - {{ campaign.end }}</td>
  </tr>
{% endif %}
{% endfor %}
</table>
