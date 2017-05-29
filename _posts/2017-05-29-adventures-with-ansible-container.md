---
layout: post
title: 'Adventures with Ansible Container'
description: 'Or rather, misadventures'
headline: 'Incredible how much time is wasted trying to save time'
category: blog
tags: [FutureGateway, API, DevOps, Docker, Ansible, AnsibleContainer]
image:
  feature:
  attribution:
comments: false
mathjax: false
discourse: true
---
# TL;DR - I can't get AnsibleContainer to build a FutureGateway stack. Maybe documenting my descent into insanity will help me get out of it.

Every now and again, has the feeling of just being stuck. There seems to be no trodden path leading to the point in which one finds oneself, no direction in or out - one has the distinct impression of waking up from something like a dream and realising that one has no idea how one arrived.

"Was I drunk ? ", "Was there some kind of party ? ", "Who won ? "... although futile, one chases the tumbleweed of thoughts in the hope of finding out where to make the next step.

Well, at that point, any step is the right step ! So, here goes[^SorryReader]...

# Get me out of here

I've been working on this damn problem for over a year now, and it seems utterly ridiculous that I can't bring it to a conclusion. "What problem ?", I hear you ask (or is that the hallucinations talking ?).

## 1 :tomato:

  1. Started this blog post
  2. Deleted all dist packages of ansible-container
  3. Deleted all docker images and containers
  2. Re-installed ansible-container with pip (now gives 0.9.1)
  3. Ran `ansible-container build` - got the errors below (root not in passwd file)
  4. Fixed that by pulling down the image first.

Next ? re-run the build part and identify the next error.

## 2 :tomato:

  1. Ensure  that we are using a debian-based conductor
  2. Run the build again (encounter "unreachable/authentication" problem below)
  3. Found out where to include the `MySQL-python` package to allow the [`mysql_db`](http://docs.ansible.com/ansible/mysql_db_module.html) module - `/usr/local/lib/python2.7/dist-packages/container/docker/templates/conductor-dockerfile.j2`, so that's good !

## 3 :tomato:

  1. ~~Change user in the db role~~
  2. Check out `ansible-container` from git again.
  3. When I change the base image of  the `db` service from `mysql` to the same as  the conductor image, this problem disappears
  4. ok, playbook seems to work ok, but only using CEntOS as base image

Oh yeah that makes perfect sense... Except no it frikkin doesn't ! What's the point of having to have a homogenous cluster of base images ? I'm getting too old for this :poop:

## 4 :tomato:

  1. ~~Try to make the mysql server on CEntOS~~ Terrible idea -  way too  much work already done by others.
  2. Found `centos/mysql-56-centos7` - let's try that
  3. Use it on the command line with `docker run -d -e MYSQL_ROOT_PASSWORD=password -e MYSQL_USER=user -e MYSQL_PASSWORD=pass -e MYSQL_DATABASE=fgapiserver centos/mysql-57-centos7` - that seems to create the db.
  4. Nope, that doesn't seem to get the db started :
              "msg": "unable to find /var/lib/mysql/.my.cnf. Exception message: (2002, \"Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock' (2)\")"
  5. Aaaand, nowhere is the frikkin Dockerfile documented  for [this image](https://hub.docker.com/r/centos/mysql-57-centos7/)


<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">current mood : &quot;raining icepicks...&quot;</p>&mdash; bruce becker (@brusisceddu) <a href="https://twitter.com/brusisceddu/status/869159616424296449">May 29, 2017</a></blockquote><script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>



## 5 :tomato:


  1. Ok, wait docker inspect has my back[^DockerInspectOutput] - but adding the entrypoint doesn't actually give me a working db to access.
  2. At this point... I'm pretty much losing hope that AnsibleContainer can do this. Let's go read the example again.
  3. Ok, [wordpress example](https://github.com/ansible/ansible-container-examples/blob/master/wordpress) (which is pre-0.9.1 however) says basically "start `mysqld_safe` in the background and tune `db` according to normal Ansible procedure."

  <blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">current mood &#39;tightrope walking in two ton shoes...&#39;</p>&mdash; bruce becker (@brusisceddu) <a href="https://twitter.com/brusisceddu/status/869169484464091138">May 29, 2017</a></blockquote>
  <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Maybe it's time to go back to the "Ansible playbook against docker endpoint" strategy. Sigh, it feels like a defeat at this point...

# What am I even building  ?

Look, call me unreasonable, but it seems reasonable to me to be able to define a topology and configuration a-la [12 factor](http://12factor.net), and then have AnsibleContainer whip me up the images. The idea of "take this base application image (mysql, apache, java) and apply the following configuration to them respectively" just doesn't seem to be really that practical. I've spent the last 3 days hacking away at this, and I'm no closer than when I started.

So I'm going to switch tack and try the old-school way.

# Notes

  * I kept getting the error on building the db container :

{% highlight python %}
        Building service...	project=AnsibleContainer service=db
        Traceback (most recent call last):
          File "/usr/bin/conductor", line 11, in <module>
            load_entry_point('ansible-container', 'console_scripts', 'conductor')()
          File "/_ansible/container/__init__.py", line 19, in __wrapped__
            return fn(*args, **kwargs)
          File "/_ansible/container/cli.py", line 360, in conductor_commandline
            **params)
          File "/_ansible/container/__init__.py", line 19, in __wrapped__
            return fn(*args, **kwargs)
          File "/_ansible/container/core.py", line 711, in conductorcmd_build
            container_id = engine.run_container(cur_image_id, service_name, **run_kwargs)
          File "/_ansible/container/docker/engine.py", line 82, in __wrapped__
            return fn(self, *args, **kwargs)
          File "/_ansible/container/__init__.py", line 19, in __wrapped__
            return fn(*args, **kwargs)
          File "/_ansible/container/docker/engine.py", line 196, in run_container
            **run_kwargs
          File "/usr/lib/python2.7/site-packages/docker/models/containers.py", line 700, in run
            container.start()
          File "/usr/lib/python2.7/site-packages/docker/models/containers.py", line 333, in start
            return self.client.api.start(self.id, **kwargs)
          File "/usr/lib/python2.7/site-packages/docker/utils/decorators.py", line 21, in wrapped
            return f(self, resource_id, *args, **kwargs)
          File "/usr/lib/python2.7/site-packages/docker/api/container.py", line 1070, in start
            self._raise_for_status(res)
          File "/usr/lib/python2.7/site-packages/docker/api/client.py", line 216, in _raise_for_status
            raise create_api_error_from_http_exception(e)
          File "/usr/lib/python2.7/site-packages/docker/errors.py", line 31, in create_api_error_from_http_exception
            raise cls(e, response=response, explanation=explanation)
        docker.errors.APIError: 500 Server Error: Internal Server Error ("linux spec user: unable to find user root: no matching entries in passwd file")
        Conductor terminated. Cleaning up.	command_rc=1 conductor_id=06061592e5d81258ce2e11a29d9b251b9f4fb5040955ff0bff1b80f06b856472 save_container=False
{% endhighlight %}

  * Now, I get an error with authentication issues ?

{% highlight  shell %}
          {"changed": false,
          "msg": "Authentication or permission failure. In some cases, you may have been able to authenticate and did not have permissions on the remote directory. Consider changing the remote temp path in ansible.cfg to a path rooted in \"/tmp\". Failed command was: ( umask 77 && mkdir -p \"` echo ~/.ansible/tmp/ansible-tmp-1496051043.32-155874901509998 `\" && echo ansible-tmp-1496051043.32-155874901509998=\"` echo ~/.ansible/tmp/ansible-tmp-1496051043.32-155874901509998 `\" ), exited with result 1",
          "unreachable": true}
{% endhighlight %}

# Summary of issues encountered

| Description | Error | Diagnosis |
|:-------------------|:---------|:-----------------|
|root user not in image | `docker.errors.APIError: 500 Server Error: Internal Server Error ("linux spec user: unable to find user root: no matching entries in passwd file")`  | base image was missing and didn't get pulled down |
| Authentication or permission  error | `Authentication or permission failure. In some cases, you may have been able to authenticate and did not have permissions on the remote directory. Consider changing the remote temp path in ansible.cfg to a path rooted in \"/tmp\".` |  ~~Seems to have been fixed in `[#236](https://github.com/ansible/ansible-container/pull/236/commits/aee073b9763097b1b57cf425ec94314746046456)`, but not in 0.9.1~~ Seems not present in CEntOS base images (Same as conductor) |

# Footnotes and References

[^SorryReader]: Note to the reader - this is purely an attempt to keep some semblance of writing skills. It's probably going to be quite painful to read, since it's not intended for you.
[^DockerInspectOutput]: HT [this docker forum thread](https://forums.docker.com/t/how-can-i-view-the-dockerfile-in-an-image/5687/3) :
{% highlight json %}
        "Cmd": [
            "run-mysqld"
        ],
        "ArgsEscaped": true,
        "Image": "sha256:fd6ae9ba11bb2c2f7d4196b6c3f7e786a7b1343bb76fd6d8a132ba207c66901a",
        "Volumes": {
            "/var/lib/mysql/data": {}
        },
        "WorkingDir": "",
        "Entrypoint": [
            "container-entrypoint"
        ]
  {% endhighlight %}
