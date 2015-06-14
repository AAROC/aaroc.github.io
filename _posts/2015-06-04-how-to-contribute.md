---
layout: post
title: "How to contribute"
description: Friendly reminder of  how to contribute to the AAROC DevOps repo
headline: 'Adding more flavour to the pot'
category: blog
tags: [github, contributing, DevOps, Ansible, federation, edugain]
image:
  feature: images/participation-cc.png
comments: true
---

# We're in this together.

The ROC is a *collective* activity, and this means that contributing to it should be easy and desirable. The bedrock of the infrastructure are those computational resources which deliver services to user and technical communities, and contributing to the maintenance, improvement and development of these is part of the social contract that is entered into when joining the ROC.

Contributions can come in many forms - merely  *talking* about the ROC on the internet is a positive contribution (even if it is positively criticised). However, apart from actually joining the ROC as a site and contributing physical resources, the most concrete contribution that there can probably be is **code**.

> AAROC <i class="fa fa-heart-o"> <i class="fa fa-github">

As regular readers know, we have kind of a love affair with [Github](https://github.com), where one of our most important repos lives[^NoClones]. [DevOps](https://github.com/DevOps). It contains the code necessary to orchestrate a wide array of services, using [Ansible](http://www.ansible.com) playbooks and [Puppet](http://www.puppetlabs.com).

# Teaching ourselves to fish

These are DevOps tools to take *models* of services, along with *site-specific variables* and orchestrates them into functional services at sites. This method allows those *developing* services to do so in a site-independent way, meaning that the work is re-usable. We believe that may be a much better way of contributing knowledge transfer than running training workshops which try to teach all technologies and tools to all site administrators. This allows specialisation and creates a network of collaboration and dependency that goes beyond simply asking for help. To paraphrase the good old book:

> give an admin a working site and you feed his users for a day; teach them to orchestrate their site and you feed their users for a lifetime <br>
>  - _not the Bible_

... well, as long as the users are partaking of the feast that is !

# Gotta catch-em all !

One of the services which the Ansible playbooks can orchestrate is the Shibboleth Identity Provider + LDAP backend for authenticating users in identity federations to web-based services - particularly science gateways. User identity in these federations[^edugain] are provided by institutes, which sometimes have their own identity providers in the federation. However, it is often the case that either no federation exists or that there is no standards-compliant[^SAML] identity provider. Rather than exclude users falling into this case from the usage of our science gateways, a set of "catch-all" identity providers, in the [Catch-All Federation](http://gridp.garr.it). These are a set of identity providers deployed using our fantastic [Ansible playbooks](https://github.com/AAROC/DevOps/wiki/idp-ldap-playbook) which can whip you up a set of services necessary to identify "homeless"[^homeless] users and allow them to join the science gateway. We have instances all over Africa and the Middle East[^map]. Users can choose these catch-all identity providers in the NREN closest to them - which is usually at a national level, so provides pretty good coverage - and use the form to sign up. A screenshot of the one in [Tanzania](http://idp.ternet.or.tz) is below.

<figure>
<img src="{{ site_url }}/images/ternet-idp.png" href="https://idp.ternet.or.tz"/>
<caption>The registration page for the TERNET Catch-All Identity Provider in Tanzania</caption>
</figure>

You'll notice that there is a field for users to state which organisation they are from.

## Case study - contributing organisations

The organisation field is a pretty big deal - we want to provide access to the *right* kinds of people, not just anybody. Identity provider adminsitrators have to make a quick identity check on the requestor[^trustlevel] to see whether their request is valid, and this includes having a valid organisation.

Of course, since this is a catch-all service, it is expected that there will be users from *new* institutes that are not contained within the initial template of organisations that the repository and playbooks provide. This template has been collected over the years, and - coming to the crux of this particular biscuit - we would like to be able to **accrue new institutes into a single database**. The question then is  - what is the procedure for providing new institutes to the
repository ?

> Hint : it does not start with "send an email"

The short answer is : ***send a pull request***. The long answer is below.

## Step-by-step pull request for  new organisations.

[Follow this procedure to create a new pull request for the organisations you want to add.](https://github.com/AAROC/DevOps/wiki/idp-ldap-playbook)

  1. Fork the repo to your own account
  1. Add your repo to the git remotes on your side : `git remote add personal https://github.com/username/DevOps`
  1. Edit the file `Ansible/roles/ldap/files/etc/openldap/slap.d/orgs.ldif`
  1. Commit the file and push it to your personal repo : `git commit Ansible/roles/ldap/files/etc/openldap/slap.d/orgs.ldif -m "New organisations" ; git push personal master`
  1. Go to your repo on github and open a pull request (the green button that looks like a recycle).
     1. Select @AAROC/DevOps as ***base fork*** and your repo as the ***head fork***
     1. Send pull requests to the `dev` branch of @AAROC/DevOps
     1. You need to do this _across repos_
     1. you should see only one file changed (the file you've just created)

We'll then discuss the new additions and hopefully add them.

So, let's keep adding flavour to the pot and get a whole bunch of work done in the meantime  :smile:


# References and Footnotes

[^NoClones]: Ok, not counting the many clones and forks of the repo ! Let's say, this is the "official" repo.
[^edugain]: Of these federations, [edugain](http://www.geant.net/service/eduGAIN/Pages/home.aspx) is probably the largest *inter-federation*
[^SAML]: The standard in this case is the [SAML](https://www.oasis-open.org/standards#samlv2.0) - the Security Assertion Markup Language
[^homeless]: So-called "homeless" users are those which belong to an institute which does not provide an identity which the federation can consume, or which are truly without a home institute in the academic sense, but more like "citizen" researchers.
[^map]: Hm. We should probably make a map of these at some point...
[^trustlevevl]: While this is not the same as a true identity verification, such as is done with the issuance of personal certificates, it does provide a minimal level of trust.
