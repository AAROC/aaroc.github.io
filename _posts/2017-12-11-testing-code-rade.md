---
layout: post
title: 'Testing CODE-RADE'
description: 'Improving usability by rigorous testing'
headline: 'AAROC  <i class="fa fa-heart"></i> reliability'
modified:
category: blog
tags: [CODE-RADE, Environments, Docker, Jenkins, Ansible, Continuous Delivery]
image:
  feature: "prime-time.jpg"
  attribution:
comments:
mathjax:
discourse: true
---

In this post, we discuss how we can ensure that products in our application repository are ready to use.
In order to know whether the applications that we build in our Jenkins are properly built, we include a _test_ phase between build and deployment.
Similarly, the only way to know whether our **execution environment** will work in the wild is to **test it too**.

CODE-RADE is designed to deliver products to arbitrary endpoints in a **non-invasive** way.
The removal of this restriction on where the applications will actually run may seem like an invitation to uncertainty, but in practice these environments end up being one of four categories[^DeploymentScenarios] : 

  - Single user laptops
  - Shared HPC clusters
  - IaaS clouds 
  - Container platforms

As a platform, we need to provide reliable means to provision CODE-RADE client environments on _at least_ these and the only way we'll know that they are reliable is to actually test it in them.

# Testing


Testing in this case starts with the code which expreses the environment, which is implemented in an Ansible role[^ContinuousDeliveryPost].
This was done for two reasons:

  1. Make the configuration **declarative**
  1. Make the provisioning **portable** and **repeatable**


By expressing the configuration in this way, it's easier to see where errors arise, to track down bugs across deploys and maintain the code in the long run.
What is  more, it gives some freedom of choice in the provisioning the execution environment by infrastructure providers.

## Bias


Bias is a terrible thing, which can convince you of things that aren't true.
In order to be sure that we are not biasing our configuration, provisioning and deployment methodology towards one or another personal favourite, we should try to write "minimum bias" tests - tests which make the least assumptions about the environment as possible.
Previous efforts in testing Ansible roles consisted of applying them to some pre-defined environment, _e.g._ running them against vanilla Travis instances.
This is not sufficient in many cases, as it does not provide the coverage that we need in CODE-RADE.
Remember, we need to assure _arbitrary_ execution environments!
This is not just along the operating system axis, but also along the deployment axis - _e.g._ Docker, virtual machine, IaaS cloud, _etc_.
In order to do this, we need a testing _framework_ - not just individual tests - such as [TestInfra](http://testinfra.readthedocs.io/), [ServerSpec](http://serverspec.org/) or our personal favorite [InSpec](https://www.inspec.io/).

Luckily, the universe is a magical place and someone invented [molecule](https://molecule.readthedocs.io/).
Molecule allows us to combine builders, provisioners, testing and linting or style checks into one combined workflow, for various scenarios.

## Function over Form


Separation of testing from provisioning means that we can publish the tests independently of the rest of the workflow.
In principle, it is _these tests_ which decide whether the environment is properly deployed, regardless of the method used to achieve it.
These are tests of the _final state_ of the deployment scenarios, and seek only to answer the question - with as little bias as possible - "Has the environment for CODE-RADE been deployed correctly ?".


# Continuous Integration


While the monitoring of production infrastructure seeks to detect defects in the "steady-state" of a system, testing in continuous integration seeks to detect errors introduced by _changes_.
The testing phase is a crucial part of adding reliability and clarity to the development cycle, giving project contributors and maintainers confidence in developing features or responding to requests.
The testing phase seeks to answer questions such as: 

 - "What will happen to aspect X, if I change aspect Y?"
 - "Will change Y have unforeseen side-effects on the system that affect it's performance or break it?"

Not all contributions and changes will result in positive outcomes, some of them will inevitably break the system, and we need to detect those breaks _before_ they are propagated to the production environment - indeed, preferably **as early as possible**[^FailFast].

To this end, we have introduced molecule into our continuous integration pipeline.
In order to run these tests, we need to consider the various scenarios in which the CODE-RADE execution environment could be deployed, and create relevant testing scenarios for them.

## Testing Scenarios

In order to test scenarios, we first need to imagine and create them. 
Sure, we can't imagine _all_ environments possible, but we can consider common aspects of various _kinds_ of environments.
As we mentioned above, the environment should pass similar tests irrespective of the environment.
For example, it should have the CVMFS configuration, repository keys, bash-modules package, and some user environment configured.
We have initially created three testing scenarios, using molecule.
Looking at the `molecule` directory of the [role](https://github.com/AAROC/cvmfs-client-2.2), we can see  three subdirectories: 

  - `default`
  - `openstack`
  - `virtual_machine`

These each define different **drivers** which molecule uses to provision the environment - `docker`, `openstack` and `vagrant` respectively.
The tests themselves are kept in each scenario's `test` subdirectory, and are implemented with TestInfra, the default testing framework used with Molecule.
The tests run at the `verify` stage of the testing strategy as their role is to check that the actual environment created by the playbook is correct, irrespective of how we created it.
These tests include, _e.g._:

  - Is the `cvmfs2` executable available ? 
  - Is the client package installed in the correct location ? 
  - Is the `code-rade.africa-grid.org` repository mounted ? 
  - Does the repository contain the correct version ?

For more details on how these tests are expressed, see [the default scenario tests](https://github.com/AAROC/cvmfs-client-2.2/blob/master/molecule/default/tests/test_default.py).
There are probably other tests that we can imagine, coming both from the Dev (_i.e._ those contributing to the actual Ansible role) as well as the Ops (_i.e._ those responsible for using the role at their sites and keeping things running) sides.

One thing is sure : **we have far better understanding of where, when and how this role fails, by testing it in realistic scenarios.**

## Open Source Open Tests

CODE-RADE is an Open Source project - we want to position it firmly in the Commons: a piece of infrastructure that anyone can contribute to and use.
This means that we need as much transparency in the process of contributing to it as we can handle, so the tests need to be publicly visible and linked to the codebase.
In fact, we have a [section of CODE-RADE](https://ci.sagrid.ac.za/view/Infrastructure) just for infrastructure.
There, you can find the current and historic results for  the [tests of this role](https://ci.sagrid.ac.za/view/Infrastructure/job/CODE-RADE-Role).
We also test the role in [Travis](https://travis-ci.org/AAROC/cvmfs-client-2.2).

# Summary

In this post, we have discussed how we approach testing the role responsible for the creating the CODE-RADE user environment.
This role is meant to be used by site administrators and users alike, with whatever provisioning system they prefer, to configure their site to use CODE-RADE.
CODE-RADE is designed to be non-invasive and community-based, and we place a high premium on the reliability and automation of the provisioning tools, in order to reduce to as near to zero as possible the barrier to entry for all.
Using the fantastic tool Molecule, we are able to simulate the expected environments, and test the deployment in various scenarios, giving clear and actionable feedback on any changes  to the code.
The ability to run the same tests over arbitrary environments means that site operations teams can express the expected behaviour of the system independently of the way in which it is provisioned, reducing bias in the development side, and increasing our trust in automated deployments.


# References and Footnotes

[^DeploymentScenarios]: We will write up how one can actually use CODE-RADE in these scenarios perhaps in a later post.
[^ContinuousDeliveryPost]: See the post on [Delivering Execution Environments]({{ site.base_url }}{% post_url 2017-12-09-CODE-RADE-delivered %})
[^FailFast]: What is meant by "fail fast" - detect failures as soon as possible, so that they can be addressed, before their impact has wider-ranging consequences. 