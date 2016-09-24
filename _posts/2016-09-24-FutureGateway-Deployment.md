---
layout: post
title: 'Future Gateway API Deployment'
description: ''
headline:
category: blog
tags: [FutureGateway, API, DevOps, Docker]
image:
  feature:
  attribution:
comments: false
mathjax: false
discourse: true
---

# Future Gateway - always an appropriate name.

[FutureGateway](https://github.com/FutureGateway) is a project to develop an API and related services which will allow web applications to interact with back-end distributed infrastructure of almost any kind. Its design principles are to provide a platform-agnostic bridge between front-end (web) interfaces and back-end interfaces. It adopts the philosophy of using open standards when it comes to implementation choices as far as possible, and thus relies on the [SAGA]() standard - specifically the [jSAGA](http://software.in2p3.fr/jsaga/latest-release/index.html) implementation for interacting with grid, cloud and HPC sites. For different cloud stacks, the gateway uses [OCCI](http://occi-wg.org/)

The reliance on standards means that the front-end developer needs to implement far less functionality, and has access to far more potential resources, as  compared to having to implement native functionality for each different kind of backend - different grid, cloud, HPC stacks.

Future Gateway - aside from being the most future-proof name possible for such a project, is part of the [Indigo Datacloud](https://www.indigo-datacloud.eu/) project, which is working on a full stack PaaS for scientific cloud computing. Of course, we're not aiming for that scale, but we want to provide an easy means for deploying and orchestrating the services necessary for a FutureGateway.

# FutureGateway components

The FutureGateway stack consists essentially of three components :

  1. REST API[^CurrentAPI]
  1. event and job tracking database
  1. SAGA interpretation library

One might think that it would be easy to create independent containers for each of these services and spin them up as needed - however that would be just slightly too simplistic: it would only solve the issue of deployment. In fact containers have been or will soon be created to _contain_ the services necessary to put up a functional science gateway, but the creation of the images is only a minor aspect of the problem.

## The problem of orchestration.

The problems faced here are those of _orchestration_ and _configuration_. While the container running the tracking database is simply a mysql container[^MysqlContainer], which can be easily configured - the **variables** needed for configuration _also_ need to be passed to the API Server in order for it to understand how to connect and write to the relevant tables. The need to share these variables across services makes an orchestration engine which can _also do configuration management_ very attractive. Docker does orchestration nicely, but is not so great (or rather, does not encourage or enforce) good configuration management habits. However, DevOps is your friend here, since you can express variables associated to concepts such as groups or roles[^Ansible]. Solving this problem will mean creating the base images necessary to start off with, and then applying the correct configuration when they are instantiated.

One issue remains - where to write persistent data. It is widely recommended that the SQL databases are written _outside_ of the running container - either on the host filesystem, or on docker volumes. The  [best practice](http://stackoverflow.com/questions/18496940/how-to-deal-with-persistent-storage-e-g-databases-in-docker) is recommended to use a _data only_ container to manage the data for databases[^DockerDocs]:

> If you have some persistent data that you want to share between containers, or want to use from non-persistent containers, it’s best to create a named Data Volume Container, and then to mount the data from it.

These data containers do nothing more than expose the volumes for other containers to mount and therefore write to, and provide us with a means to have _portable deployment_ and orchestration.

## Orchestration in plain English

The following steps are required to get the stack up :

  1. :whale: **Create base Docker images prior to deployment**:
      * **API DB**: The [official mysql server](https://hub.docker.com/_/mysql/) image
      * **Data  Container**: the empty container which holds the sql data (the mysql image will be used)
      * **API Server**: Base OS image with the flask application installed.
      * **SAGA Tomcat Server**: The official [tomcat](https://hub.docker.com/_/tomcat/) image
  1. :arrow_down: Pull the containers:
      * [docker-image](http://docs.ansible.com/ansible/docker_image_module.html) module will pull down the relevant images
  1. :arrow_forward: Start the containers
      * Ansible will be used to start the containers (using [docker-container](http://docs.ansible.com/ansible/docker_container_module.html))
      * Ansible roles are used to configure the containers.

Variables from the _group_ are applied across containers as needed, and need not be redundantly defined in several places. In this way, a single playbook and a few roles can be easily distributed to wherever you want to deploy the science gateway, ensuring portability of both the configuration and the data.

----

### Footnotes and References

[^CurrentAPI]: The API is currently implemented as a python flask application. The SAGA libraries are written in java, and need to  be included in a tomcat application, which means that the SAGA and REST applications are separated. Future developments will re-implement the API as a Java application, and have the SAGA libraries internally contained, reducing the need from 3 components to two.
[^MysqlContainer]: In fact we have just used the official [MySQL container on Docker Hub](https://hub.docker.com/r/mysql/mysql-server/).
[^Ansible]: Roles are an Ansible-specific concept - any Puppetmasters out there want to let us know what the equivalent for Puppet is ?
[^DockerDocs]: Quoted from the [definitive guide](https://docs.docker.com/engine/tutorials/dockervolumes/#/creating-and-mounting-a-data-volume-container) on managing data in docker containers.
