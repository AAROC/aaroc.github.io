---
layout: post
title: DevOps Pre-release v0.0.3
description: A pre-release of the Ansible playbooks for executing infrastructure services in the Africa-Arabia Regional Operations Centre.
headline: A pre-release of the Ansible playbooks for executing infrastructure services in the Africa-Arabia Regional Operations Centre.
category: DevOps
tags: [AAROC, operations, services, identity, federation, ldap, release]
image: 
  feature: collabocats.jpg
comments: true 
---

# TL;DR
We have tagged a release of the [DevOps](https://github.com/AAROC/DevOps) repository which contains the code to execute infrastructure in the Regional Operations Centre. This release contains the playbooks and roles necessary to configure a shibboleth identity provider, connected to an ldap backend. 

# Background and Introduction

We are in the business of providing relevant computing services to research collaborations, be they small or large. The underlying idea is that research collaborations need ICT services and that no single institute can provide all of them. This point of view is often a very hard one to accept, since the pressures of research activities demand action, and it's usually easier to take action yourself than delegating (and trusting) someone else to do it. Need a cluster ? Build it yourself. Need a data repository ? Build it yourself. Need a software repository ? Built it yourself. Need an identity provider ? Build it yourself... and so on. 

However, as the activities become more complex, and require the integration of more and more tools, it becomes clear that "Just do it yourself" is not an option, and is what separates infrastructure from resources. 

We will discuss in this contribution, the case of deploying the services necessary to provide a [Shibboleth](http://www.shibboleth.net) identity provider with [ldap](http://www.openldap.org) identity database ldap backend. This is a very common setup which a community adopts in order to participate to an federation of services and identities. By enabling trust between service providers (SP's) and identity providers (IdP's) via common policies in a federation, it becomes much easier to provide access to diverse services to individuals from various communities, at scale. Since trust is at stake, it is very important to deploy and configure these services, as well as enforce consistent policies, at the local level, such that by then simply exchanging metadata, these can be included in the federation.

We consider the Catch-All Federation, which has been adopted particularly in the Sub-Saharan and Arabian context, and discuss here the development and design philosophy of an automated, distributed, collaborative tool to enable the execution of the deployment of these identity providers in the region.

# Development philosophy

Most of the time the following happens:

  1. Someone gets idea, implements idea through a series of hack
  1. Convinces others to try it; writes instructions based on their understanding.... <br>
  1. Spends eternity trying explain what exactly they meant.

Astute observers will have noted that two obligatory steps are missing: 
  
  1. '???' - because we're all already confused enough and 
  1. 'Profit', because that's not part of the plan and if it does come about, well, just call it blind luck.

Furthermore, although I'm loath to call them *barriers*, we are certainly dealing with cultural and language issues. It would be impossible for this *not* to be the case given the vast geographic area we are dealing with. Emails and badly-written documents are just not going to transmit a coherent message. 

## DevOps to the rescue

***DevOps*** is a paradigm in the IT services and applications world which assumes a far greater communication between those *dev*eloping services and those who *op*erate them. There are a lot of interpretations of just what DevOps is, and if you ask the internet, you'll get a lot of discordant answers. Here's just one of many opinions of what it means : 
<!----
<iframe src="//www.slideshare.net/slideshow/embed_code/37658068" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;"> </iframe> 
---->
Let us consider the context of African e-Infrastructure, in the particular case of the Africa-Arabia Regional Operations Centre.

In some spheres, saying that a project or a team is "DevOps" has been interpreted to mean that it has adopted a certain tool or methodology[^tool-method].
It's a culture of trust, confidence and openness, not just a technology

but technology is necessary... more about that later.

## Infrastructure is code

In fact, we take this to a further extreme, and claim that 

> Everything = code

Even this very article you're writing is code (in this case, markdown). Why do we go to this extreme ? Well, there are a few things you can do with something when you consider it as code. First of all, you can *create* and *share* it, and those who you share it with will have something concrete, rather than an idea. Code is an implementation of an idea, not the description of it.

Secondly, it can be version-controlled and tagged. This is especially important in a distributed environment, when several different institutes are collaborating around a project and need a reference which can unambiguously refer to what state their services are in. 

Finally, when `infrastructure == code`, there's far less room for misunderstanding. When errors arise, and they will, we can *know why* first, because the infrastructure has been defined (this machine has these variables, it's this kind of OS, this code has been executed on it), and we have a common understanding of what is being done. Sure, you could do everything according to the book and then *describe* your progress and issues, but there's so much room for misinterpretation that it's almost bound to waste a whole lot of everybody involved's time. 

## Code is Open

The code is in an open-source repository, and is of course freely-available to whoever wants to use it. It has, however a clear scope and is not being developed for the world at large, but rather for the operators of the support services which African e-Science communities rely on. There are two relationships which are implied:
  
  1. The relationship between developers and operators.
  1. The relationship between operators and users

In former, openness is necessary to develop confidence and trust between those developing the services and those deploying it. Considered from a sustainability point of view, it is one of the most important cultural aspects to have in place to promote sustainability of the collaboration. Without openness, trust between the developers and the operators of the services would dwindle and the community would dissipate.

In the latter, users would question the wisdom and necessity of relying on services which were unreliable, and - since there is no lack of similar services in the wider internet - would either look to purchase a similar product, or decide to develop one for their own use. As we have mentioned before in previous articles, our point of view is that when services are not developed for common (or rather, collective[^pvh-collective]) use, they actually become detrimental to the wider scientific community, since they undermine the cross-cutting infrastructure and support teams, in favor of shorter-term, narrower-scope goals[^ok-these-are-fine-too].

Since there is no contractual obligation, usually, between developers, users and providers, the entire ecosystem is built on mutual respect and trust, and the procedures, as well as the final software products should reflect that.

## Try before you buy (Continuous Integration)

One of the means of producing this trust is to provide software products which have already been tested. The design philosophy discussed below expects that :

> Anything in the master branch will deploy

This means that whatever has been included in that branch has already been tested and, at least once, has passed certain tests. Although this is by no means a "certification", the playbooks are automatically run on every commit via a continuous integration platform[^travis-ci]. The usage of Travis as a continuous integration tool, as well as a cloud-based testing environment allowing us to consider more than one operating system and combination of service deployments. In fact, at every commit, Travis schedules tests on the nodes defined in the development site inventory and the outcome of these tests is displayed prominently in the front page of the repository. 
<!-- put in a screenshot or whatever of the DevOps front page -->

This is just one more aspect of the open nature of the relationship between all involved. 

  * Stuff broken ? check the build... 
  * Builds failing ? why is it in `master` ? 

## Living beyond the project

The campaign of deploying identity services was started in the context of the [ei4Africa](http://www.ei4africa.eu) project and the initial impetus was certainly necessary to get things started[^project-over]. Without the project scope, structure and of course funding, it is very difficult to imagine that the results seen so far would have been attained, based on pure stochastic motion... Timelines and deliverables were imposed thanks to the project and mostly because of these, we have created a collaboration which could indeed endure. Certainly, a top-down approach, where project managers tell a centralised team of developers to produce results, and developers tell operators to deploy their fruits of their labours, cannot be sustainable even in the medium term. There are far too many use cases, far too many variables to satisfy and consider that the only option is to impart a structure which can be adopted by a wider community. If the result of the ei4Africa project would be just to write a document descring how a particular state (of services) can be arrived at, perhaps it would suffice at the end of the project, but it would be almost immediately be obsolete. By adopting a more open, flatter, executable paradigm, we are hoping to leave something which is capable of germination, cross-pollination from other ecosystems, and eventually, sutainable growth.

# Design philosophy

Certain cultural and organisational aspects of the situation had to be taken account when considering the design of the actual implementation. These include the following :

  * There is widespread need and desire for federated identity services[^true-for-other-things], in places which differ drastically in their characteristics. From large, established, well-funded universities, to underdeveloped, disconnected, research laboratories or centres, all over the region.
  * There is widely-varying capability to deploy, operate and support these services.

These aspects have didactic, as well as operational design implications. 

## Mode of deployment

In order to provide the ability to decentralise operations, we need for this code to be executed locally at the point of service deployment. This case would be most desireable for example when there is an experienced site administrator, who would like to have full control over the configuration and knows very well the implications of deploying services in a certain configuration. There are of course security considerations here, since perhaps remote connections from unntrusted sites could be considered a threat. In this case, the **operator** could 

  1. clone the repository to a local control node, perhaps behind a network DMZ
  1. add their inventory and site variables
  1. Execute the configuration
  1. Either contribute their local changes to the original repo or push them to a local, site-specific repo.

However, it is also desirable - and in some cases necessary - for an expert to be able to take remote control of a site and execute the configuration from a remote location. This was indeed performed on several occasions, essentially by the site administrators handing the developers the keys to the kingdom - allowing them remote ssh access to a priveliged account. In this scenario, the **developer** :
  
  1. Connects to the remote site over the internet, using a secure protocol
  1. Discovers site inventory and variables (perhaps through private communication, or by investigation of the state of the machines)
  1. Updates the repository with this information and commits it to version control
  1. Executes the configuraiton remotely (again, using a secure protocol).
  
It is important to note that the communication of *what* has been done, as well as *why* is included in the source code, in the "DevOps" approach, whereas before, much information and context is lost since this is transmitted in emails, which may be just summaries or descriptions of what has been done. In fact, in most cases, the message is *"It's working now"* and nobody is the wiser.

## The choice of Ansible

We come now ot the discussion of the choice of technology for implementing the executable infrastructure. We have chosen Ansible for the following reasons : 

  1. It is agentless 
  1. We're already using ssh
  1. It doesn't specify an architecture
  
The most desirable configuration and deployment system for our case would be one that was as flexible as possible. While any of puppet, chef, etc could have been well tasked to deploying these services *in principle* - and are indeed used widely for these very tasks - the master-slave architecture dictated by the system did not fit our highly distributed, flat hierarchy. A system which could be defined in terms of local variables, providing models of services 

# Features of this release.

This release provides the ability to deploy the following services or combinations thereof:

  1. LDAP identity database backend
  1. Shibboleth IDP
  1. Web frontend (tomcat servlet) for managing requests

## LDAP Server deployment

By default, we assume that there is an OpenLDAP server to contain the identities of the entity in question. An [LDAP](http://www.openldap.org) role has been developed to ensure that the correct policies and configuration is provided. In this case, the ldap server is defined in the inventory as the target for the role. The server packages and modules are both installed and configured using the `ldap` role. The most important aspect of this role is the variables which are used for applying the model correctly to the site : 

  * `tls_cacert_dir` - directory containing CA certificate files 
  * `domain`: the host domain name of the Identity provider that is being served by this LDAP backend
  * `organisation`: the Org name of the IdP
  * `admin`: the administrator user name
  * `Administrator`: the Administrator group name
  * `idp_group`: the gorup into which users who belong to the IdP are added
  * `user_cn`: normal user common name
  * `user_sn`: normal user surname
  * `user_given`: normal user given name (ie, the user's actual name)
  * `user_initials`: initials of the user (given and surnames)
  * `user_email`: primary email address of the user
  * `user_secondary_email`: secondary email of the user
  * `user_org`: Organisation to which the user belongs
  * `user_country`: ISO code of the country from which the user comes. 
  * `user_registered_address`: the address with which the user has registered (usually the same as the primary email address). This is used as the identification token.

Defaults for these are provided in the `vars` directory, or can be passed as usual on the command line to Ansible, however sensitive variables such as passwords should be kept in an Ansible vault file, so that they are encrypted before being pushed to the repository.

The ldap role is not a generic OpenLDAP deployment, since it has been developed with the purpose in mind of interacting with a Shibboleth Identity Provider. Therefore there are some variables related to this function, such as the `idp_group`. Also, the ldap role invokes a specific firewall role to apply the proper iptables configuration; this information is contained in the `meta` section of the role. 

## Shibboleth Identity Provider

The shibboleth Identity Provider role has the purpose of integrating the ldap database as identity backend to the identity federation. The three plays of the playbook are as follows : 
  
  - `install.yml` : installs the Shibboleth package and installs it
  - `tomcat-config.yml` : configures the tomcat server, including various aspects of the JVM which the shibboleth webapp will run under.
  - `configure.yml` : configures the XML files which describe the IdP and ensures that services are restarted.

This role essentially ensures that there is proper integration between the ldap backend and shibboleth IdP, and applies the relevant policy in terms of attribute resolution and filtering which are decided by the federation. It also uses the firewall role as a depedency.

## IDP Web frontend

In order to provide identity managers with an easy-to-use gui to process requests from new or recurring users, a web application[^IDPPublic] was developed. This frontend has been previously released in a [separate repository](https://github.com/AAROC/IDPPublic), and with DevOps v0.0.3, we provide a playbook to deploy and configure it automatically. The variables needed by the play are the version of IDPPublic to be used, and the user admin password. One of the main benefits of this playbook is that it maintains consistency between other services at the site, settting contact email addresses, host names for ldap and shibboleth IdP servers, etc in a self-consistent way. This highly reduces the possibility for typos and other human errors, which result in large demands on subsequent support.

The full play looks something like this 

  * Play 1: 

```
- name: Configure the LDAP machine
  hosts: ldap-server
  remote_user: ansible
  sudo: true
  roles:
  - ldap
```

     This configures configures the LDAP server, by applying a single role. It should be noted that we assume that the `bootstrap` role has been applied to all machines, before the plays, but they are not explicit dependencies, since some of the conditions are a matter of style and may vary from site to site based on the site admin's preferences.
     
  * Play 2: 

```
- name: Prepare the identity machine
  hosts: shibboleth-idp
  remote_user: ansible
  sudo: true
  roles: 
  - fmarco76.tomcat 
  - shibboleth-idp
```

     This play applies two roles - the tomcat and shibboleth idp role - to the shibboleth IdP host machine, in that order.
  
  * Play 3:

```
- name: Deploy web interface
  hosts: shibboleth-idp
  remote_user: ansible
  sudo: true
  roles:
  - fmarco76.IDPPublic
```

     The final play installs the web interface on the Shibboleth IdP host machine and configures it according to the site variables defined in `group_vars`, `<role>/vars`, etc.

So, we have seen that with just a few variables and an inventory, an nontrivial combination of services can be reliably deployed and configured with a single  push of a button. What is more, if something changes or breaks, that ***same*** push of a button will take you back to safety, thanks to the idempotency of Ansible[^not-always-idempotent].

# Use Cases

The obvious question of course is 

> ok wiseguy, sounds great, but how does it work ? 

The simple answer is the following.

  1. Prepare the basic resources - host(s) with internet connectivity and a basic EL6 or Debian 6 Operating System
  1. Define your inventory - which hosts will act as the idp, which hosts will act as the ldap server, etc.
  1. Define your site variables 
  1. Execute the `idp-ldap.yml` playbook in the repo.

It couldn't be much easier right ? But of course, there's more to it  than that. 

Having described the design and development philosophy and functionality of these playbooks, let us now consider how they may be used at various sites. We consider the most common use cases, given our experience : ***Deployment, Rolling Updates and Disaster Recovery.***

## Deployment

The most obvious and urgent use at the current point in time is to be able to deploy these services from scratch. This effort has been one of the main efforts in the ei4Africa project, and while we have had success at various sites, the struggle to maintain various installations and transfer knowledge in a sustainable way has been one of the driving forces behind this development. In the deployment case, the initial state is a simple as possible - basic operating system (of those supported by the playbooks) and ssh access. From this state, the final state may be reached by applying the relevant roles, using the playbooks provided.

<figure>
<img src="{{ site_url }}/images/playbook-diagram-deploy.svg">
<figcaption>Using the playbooks to deploy services on vanilla sites. <br>Or "How to turn vanilla operating systems into a cup of coffee".</figcaption>
</figure>


## Rolling Updates

The next use case which we envision is to apply rolling updates. While the "deployment" scenario described previously has obvious initial benefits, it can describes a prescribed initial state, which is also assumed to be *static*. A major benefit of the the DevOps approach is that the *same operations* can be made, using updated parameters, to keep the site in an up-to-date state. 

DevOps recognises that there are different *roles* involved in the maintenance and uptake of IT services: the developer and the operator. We aim to make this separation of roles clearer by expecting each to have a more limited set of skills and responsibilities, so as to lighten the load on each. Since the code is tested at each commit, developers can ensure that there is a more linear development. What is more, when code is merged from the development branch into the master branch, operators will be informed that it is time to run an update by simply doing a git update. If done properly, this could be automated using cron-like tools.

## Disaster Recovery

Disaster recovery is the third scenario in which we foresee these playbooks having impact. Disasters come in all forms, from hardware failures, malware, natural disasters...

<figure>
<img src="http://imgs.xkcd.com/comics/s_keyboard_leopard.png">
<figcaption>And, of course, PEBKAC</figcaption>
</figure>
... and so on. One of the most devastating disasters, however, is often not considered one - staff turnover. When expert knowledge is maintained in a single person, as is often the case, the loss of this person - be it due to them moving on, changing career, etc - represents the loss of the ability to provide the service. This can be protected against by encoding the knowledge as we have done here, in some executable form. 

# Future developments

This is certainly just a milestone in a long-term development strategy. We lay down here some ideas about future developments which could improve both the quality and usability of the repository.

## Functional tests

Functional tests in this case do not refer to the state changes, facts, or other messages which Ansible produces, but rather tests which make sense to *humans*. For example, if an ldap server is configured correctly, a sane system administrator might reasonably be expected to retrieve the list of identities; a test could be easily defined to do this. Futher functinoal tests should simulate user behaviour in some way - 
  * Are we able to connect to the service via the right ports ? 
  * Is certain text apearing in a certain page or not ? 
  * Can we retrieve metadata and does it have a certain structure ?
*etc*. Specific tests should be defined for as many aspects of the functionality of the service as possible, given that these tests need to be conducted in a non-interactive way.

Furthermore, one of the ways to increase trust between operators and developers would be to publish the results of functional tests which are performed on the code once a commit has been made. A common method is to use gerrit to run tests that have been defined, before code is committed to a repository. This may be overkill for our use case, though.

## Resiliance.

In our case, we understand resilience as the capacity of a service to return to "normal" levels after an event which is not necessarily a *disaster*, but nevertheless degrades or disrupts the service. Sometimes the entire site is not affected, or only some aspects of a service are affected (such as lost credentials, or a corrupted configuration file. Often, without full understanding of the connection between services, it is easy to futher degrade the configuration by attempting to make changes by hand. By having pre-tested playbooks which define the desired state, system administrators can reliably return to the proper configuration; or at the very least commmunicate with better accuracy where a problem lies, based on where the playbooks fail.

Currently, the playbooks, as mentioned above, assume a certain set of initial states for which they are guaranteed to work. In further development of these playbooks, we aim to add some "intelligence" to these playbooks, to take specific actions based on the other possible states. In particular, the configuration of the ldap server will be addressed, to allow for integration existing ldap databases instead of starting from scratch.

<!---
try to deploy on purposefully broken or half-configured systems.
--->

##  Further functionality
<!--- check whether declarative and transactional are the right words for this. --->
One of the main selling points of the *"DevOps"* approach is the benefit of **idempotency**. The declarative, rather than the transactional, nature of tools like Ansible makes it much easier to both *specify* (by writing code) and *understand* (by reading the code) system states. In some aspects of these playbooks, as we mentioned in the footnotes, idempotence has been lost, which reduces the set of initial states in which a system can be for the code to work. This reduction is quite small, since very few assumptions have been made, but it violates the development philosophy.

Apart from this cross-cutting aspect, certain specific functionality is planned to be added, for [release v0.0.4](https://github.com/AAROC/DevOps/milestones/10) :

  1. Liferay on Glassfish deployment
  1. Catania Science Gateway Grid Engine deployment
  1. shibboleth service provider
  1. customisation of IDPPublic web interface
  1. better security and handling of passwords (into vault)

# Summary

We have tagged a pre-release version of Ansible playbooks which can be used to deploy identity services necessary for the creation of Shibboleth Identity Providers, in an identity federation. Benefits of the DevOps approach, compared to following a manual guide are : 

  * maintains consistency between services at a site, with less room for human error
  * allows separation of development and deployment roles, increasing trustworthiness and improving support mechanisms
  * rolling updates can be consistently applied by following release tags, making only minimal changes

# Footnotes and References
[^tool-method]: To be more specific, that the development team has adopted an agile approach to service or application development and that the operations team is using one or more tools, for deployment: *e.g.* Puppet, Chef, Ansible for configuration management and provisioning and Continuous Integration tools such as Jenkins to to provide continuous integration, deployment and monitoring of these services or applications.
[^infracode]: http://devops.com/blogs/infrastructure-as-code/
[^pvh-collective]: To quote Peter van Heusden.
[^ok-these-are-fine-too]: This is not to say that services should **not** be developed with the afore-mentioned 'shorter term, narrower-scope' goals - these are undoubtedly necessary in certain cases, particularly where speed and agility is required. However, where services  become so cross-cutting that they they are no longer the domain of a single group or even scientific community, they tend to become fragmented and the effort to provide them to more researchers multiplies.
[^travis-ci]: We are currently using [Travis CI](http://travis-ci.org) for this.
[^true-for-other-things]: This is true for other services which we are developing executable infrastructure for too, such as data repositories, HPC services, etc, but for the sake of sticking to the scope of this release, we only focus on the FedId stuff here.
[^project-over]: The ei4Africa project finished on October 31st and was given an "excllent" review rating, with the Executable Infrastructure, which this release forms part of, featuring in this decision quite highly.
[^IDPPublic]: BRUCE BECKER and MARCO FARGETTA, 2014. IDPPublic: Cleaned release (online). 2014. S.l.: ZENODO. Available from: http://dx.doi.org/10.5281/zenodo.12228.
[^not-always-idempotent]: It should be mentioned that there is not 100 % idempotency, particularly in the ldap roles, since some of the tasks are transactional. State changes are inevitable when information retrieval is done, for example, and some of the plays will come up as `changed` when running playbooks against perfectly-configured sites.

The [collabocats](https://octodex.github.com/collabocats/) image in this post is used courtesy of [@jasoncostello](http://www.github.com/jasoncostello)

