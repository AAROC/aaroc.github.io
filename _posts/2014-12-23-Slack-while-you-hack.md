---
layout: post
title: Slack while you hack
description: We're turning slack into a cosy home for ourselves !
headline: Slack while you hack
category: blog
tags: [AAROC, collaboration, DevOps]
image:
  feature:
comments: true
---

TL;DR - We're in a dev sprint to get playbooks working for automated grid site deployment. In the meantime, we are also trying to actually deploy said grid sites in various parts of Africa. Working on code and supporting people using that code can be tricky, unless you've got a great communication and collaboration platform like Slack to work on. --

# This is 2015, nobody calls it 'The GRID'

Ok, it's *almost* 2015, but as the year winds down, we're assuming that pretty much everyone is either at the beach, at home with their family or

'The GRID' has done a lot of very impressive things (not least, it convinced normally sane people that it should be spelt with ***ALL CAPS***, as if it were some form of sentient being worthy of praise and adulation). Now, when people refer to *The GRID*, they usually mean '[WLCG](http://wlcg.web.cern.ch)' . AAROC coordinates something looser, something more flexible than that. It's a service federation, and those services are starting to multiply...

The *'traditional'* compute and data services such as HPC, persistent storage, workload management, *etc* are provided to us by the middleware provider (mostly [EMI](http://eu-emi.eu) / [UMD](http://repository.egi.eu)). They have their own product management teams and we're happy customers. however sometimes you need to be in control and that means developing your own services. Mature services such as the ones implemented by our middleware providers are fit for operation in a production environment - but they don't start off as such. Most of the new services we're providing - Executable Infrastructure, Identity Federation, Application Integration, etc - come iteratively into being. There is, therefore a merge between the "Developer" world and the "Operations" world.

# AAROC is DevOps

This makes AAROC *DevOps* - the new buzzword that's putting a blink in everyone's eye. There are definite aspects which identify a *developer* and others which identify an *operator*. Sometimes these aspects are at odds with each other - for example, a developer wants the quickest turnaround possible between writing their code and seeing it in action; the operator however is loath to put new applications into action before they are convinced that they will not break anything. As we discussed in a separate [article]({{ site_url }}/articles/ContinuousDelivery), a objective third party is needed to establish trust by running specific and relevant test of the developers' code. In our case, this is Jenkins, along with other robots. However, we still need that common ground to hangout, exchange messages, let each other know what we're doing - robots included. For us, it's turning out to be slack.

# Communicating on Slack

Take our "Executable Infrastructure" project. Here we're aiming to be able to deploy and configure any of our supported services using DevOps tools such as Puppet or Ansible. While developing the code, we need to test it ; it would also be nice to inform the team that we're running tests and what the outcomes were, for example.

---
<figure>
  <img src="{{ site_url }}/images/Ansible_on_slack.png"></img>
  <figcaption>Here, Ansible is announcing the execution of the ansible-executor playbook on the ZA-MERAKA-DEV site. All information and variables are taken from the playbooks themselves in github.</figcaption>
</figure>
---

We've added Ansible as one of the members of the team, allowing it to send messages to our [Slack instance](https://africa-arabia-roc.slack.com), telling the team what it's doing. At the moment, we're running the playbooks by hand, so Ansible is really just a proxy for a developer who is testing out playbooks on the dev site, but in the near future, these will become integrated into our Rundeck instance, allowing operators or developers to request configuration deployments. With this integration, the operators have a far better idea of what the developers are doing.

This is quite simply done by adding a pre-task to the roles in the playbooks, similar to this one which rus the WMS playbook :

{% highlight yaml %}
- hosts: wms-servers
  name: Deploy and configure WMS
  user: ansible
  sudo: true
  pre_tasks:
    - name: Announce the play via Slack
      action:
       module: slack
       domain: africa-arabia-roc.slack.com
       token: xxxxx
       msg: "Running WMS play on {{ inventory_hostname }} at {{ site_name }}"
       channel: "#devopssite"
       username: "Ansible on {{ inventory_hostname }}"
       link_names: 1
  roles:
   - bootstrap
   - common
   - certificates
   - umd
   - wms
   - yaim
{% endhighlight %}

In this way, we hope to keep the developers and hackers on speaking terms with the operators, and ensure that this grid/cloud/whatever you want to call it thing (as long as it's not capitalised !) is a friendly place for both.
