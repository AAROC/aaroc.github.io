---
layout: post
title: "VOMS server and Ansible role update"
description: ""
headline: ""
category: blog
tags: [voms, ops, AAROC, update]
comments: false
discourse: true
---

The [Virtual Organisation Membership Service](https://italiangrid.github.io/voms) is a service providing authorisation to use grid and cloud services. The VOMS releases signed proxies of users' personal certificates which can be used by the middleware stacks to authenticate to the various middelware services.

An error was detected on the [VOMS server](https://voms.sagrid.ac.za) hosting the `sagrid`, `sagrid.ac.za` and `stell.bio` VOs. Connections to the `voms-admin` and `voms` service were failing, and the web interface was also down. Upon investigation, it was found that there was a conflict between the old version if java installed (Java-1.6.0) and the Jetty environment needed by the VOMS applications.

We keep a VOMS playbook in the [DevOps](https://github.com/AAROC/DevOps/) repository, which uses the VOMS role, along with a few others (`bootstrap`, `common`, `certificates`). The playbook and role for the VOMS service were updated in order to reflect the current state of the configuration. Upon review of the code in the VOMS role, we found that several variables were kept at the service level instead of the site level, so these were moved to the `group_vars/passwords-{{ site-name }}.yml` file for the ROC. After being protected with Ansible Vault, these were also pushed back to the repo.

The service is again up and running and users should not experience any disruption. Please open a topic on the [forum](https://discourse.sci-gaia.eu) if problems are experienced.
