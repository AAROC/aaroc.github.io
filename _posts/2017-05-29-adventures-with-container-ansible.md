---
layout: post
title: 'Adventures with Containers and Ansible'
description: 'Or rather, misadventures'
headline: 'Incredible how much time is wasted trying to save time (part 2)'
category: blog
tags: [FutureGateway, API, DevOps, Docker, Ansible, Container]
image:
  feature:
  attribution:
comments: false
mathjax: false
discourse: true
---

After giving  up on Ansible Container for now, I'm going to take another swing at FutureGateway orchestration, this time putting Ansible on the outside of the containers.

The previous strategy was to express all of the services as containers in a topology similar to Docker-Compose first, and then configure each of the containers with a special Ansible conductor container. This proved just too much for me to grasp at the present time - there's a dissonance between my way of thinking and the "right" way to do things with Ansible Container.

Also, I'm running out of Soundgarden to keep me going...

Sooo, I'm going to try do things the "older-school" way, by writing a playbook which will apply roles to containers, usig the docker connection, and avoiding Ansible Container entirely.


## 1 :tomato:

  1. Start this post
  2. Start the playbook in the `fgSetup/ansible` directory
  3. had to get the `docker-py` pip re-installed

## 2 :tomato:

  1. It's time to switch to a little Nirvana. Dead old rockers are all that is going to get me through this day...
  2. It's not  clear how to get a docker container started - do I use the  [`docker_container` module](https://docs.ansible.com/ansible/docker_container_module.html#examples) or the [`docker-py` inventory](https://docs.ansible.com/ansible/guide_docker.html#dynamic-inventory-script) ? Probably the module, since the dynamic inventory only shows things which have already been created.
  3. Ok, I can create the containers quite nicely but now I need to refresh the inventory so that we can apply roles to host groups...
  4. We don't  need an actual user on the db host now, we can change `user:` to `mysql_user:`

  <blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">current mood : &quot;Don&#39;t expect me to cry&quot;</p>&mdash; bruce becker (@brusisceddu) <a href="https://twitter.com/brusisceddu/status/869206327326855173">May 29, 2017</a></blockquote>
  <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


## 3 :tomato:

  1. Problem creating the mysqldb user - can't seem to pass the module parameters accurately
  2. At this point, :coffee: was in need - let it be known that coffee was had.
  3. Actually, it's getting pretty hard to concentrate, tbh. Hang in there, it's 17:00 and only a few hours of hacking left.
  4. wait... wait... no way...

{% highlight bash %}
  PLAY [Create containers] *******************************************************************************************************************************************************

  TASK [Gathering Facts] *********************************************************************************************************************************************************
   [WARNING]: Removed restricted key from module data: ansible_docker_gwbridge

  ok: [localhost]

  TASK [create the db container] *************************************************************************************************************************************************
  ok: [localhost]

  TASK [wait_for_connection] *****************************************************************************************************************************************************
  ok: [localhost]

  TASK [Create the APIserver container] ******************************************************************************************************************************************
  ok: [localhost]

  PLAY [Get them to the python !] ************************************************************************************************************************************************

  TASK [raw] *********************************************************************************************************************************************************************
  changed: [fg_db]

  PLAY [template the db] *********************************************************************************************************************************************************

  TASK [Gathering Facts] *********************************************************************************************************************************************************
  ok: [fg_db]

  TASK [AAROC.fg-db : Ensure mysql prereqs present] ******************************************************************************************************************************
  ok: [fg_db] => (item=ca-certificates)
  ok: [fg_db] => (item=openssl)
  ok: [fg_db] => (item=pwgen)
  ok: [fg_db] => (item=perl)

  TASK [AAROC.fg-db : ensure python db package] **********************************************************************************************************************************
  changed: [fg_db]

  TASK [AAROC.fg-db : Ensure FG user present] ************************************************************************************************************************************
  ok: [fg_db]

  TASK [AAROC.fg-db : Template sql] **********************************************************************************************************************************************
  ok: [fg_db]

  TASK [AAROC.fg-db : DBinst0 | Database creation check] *************************************************************************************************************************
  ok: [fg_db]

  TASK [AAROC.fg-db : DBinst1 | Database creation and installation] **************************************************************************************************************
  skipping: [fg_db]

  PLAY RECAP *********************************************************************************************************************************************************************
  fg_db                      : ok=7    changed=2    unreachable=0    failed=0   
  localhost                  : ok=4    changed=0    unreachable=0    failed=0   
{% endhighlight %}

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">current mood : ANSIBLE_COW_SELECTION=random</p>&mdash; bruce becker (@brusisceddu) <a href="https://twitter.com/brusisceddu/status/869211831277162497">May 29, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>  
