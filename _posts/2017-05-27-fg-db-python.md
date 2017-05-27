---
layout: post
title: 'FutureGateway the DevOps way'
description: ''
headline: 'Stuck on the python mysql bindings'
category: blog
tags: [FutureGateway, API, DevOps, Docker]
image:
  feature:
  attribution:
comments: false
mathjax: false
discourse: true
---

I've hit a problem with the FutureGateway stack deployment code. The goal is to write the deployment in such a way as to make it deployable on a cloud-native platform, following 12-factor.  I'm using AnsibleContainer to do this.

The `container.yml` looks like this :

{% highlight yaml %}
version: "2"
settings:
  # We choose Jessie as  the Conductor base since that's what the mysqldb is using.
  conductor_base: debian:jessie

services:
  apiserver:
    from: centos:7
    roles:
      - AAROC.fgapi
    ports:
      - 8888:8888
    command: ['/bin/true']
    privileged: True

  db:
    from: mysql
    roles:
      - AAROC.fg-db
    ports:
      - 3306:3306
    environment:
      - MYSQL_ROOT_PASSWORD={{ mysql_root_password }}
      - MYSQL_USER={{ mysql_user }}
      - MYSQL_USER_PASSWORD={{ mysql_user_password }}
    command: ['mysqld']
    entrypoint: ['/entrypoint.sh']
    volumes:
      - $PWD:/var/lib/mysql
    privileged: True
  registries:
  quay:
    url: https://quay.io
    namespace: aaroc
{% endhighlight %}


The problem I'm facing right now is applying the `AAROC.fg-db` role to the db image :

{% highlight shell %}
TASK [AAROC.fg-db : DBinst0 | Database creation check] *************************
fatal: [db]: FAILED! => {"changed": false, "failed": true, "msg": "the python mysqldb module is required"}
{% endhighlight %}

The task `DBinst0` throws this error, which uses the [mysql_db](http://docs.ansible.com/ansible/mysql_db_module.html) Ansible module to import a database. The [notes](http://docs.ansible.com/ansible/mysql_db_module.html#notes) state that the `python-mysqldb` package has to be present on the managed node and indeed there's a prior task which performs this :

{% highlight yaml %}
- name: ensure python db package
  package:
    name: python-mysqldb
    state: present
    update_cache: true
{% endhighlight %}


So... it seems like it's the conductor container that doesn't have the package.  I need to find some way to ensure that the mysql python bindings are on the conductor container. Seems like a bit of a (huge) oversight to me, but hey, what do I know ?
