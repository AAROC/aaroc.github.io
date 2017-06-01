---
layout: post
title: 'Sometimes to do things right, you have to do them wrong'
description: 'Ugly code that works  is worth an infinity '
headline: 'Incredible how much time is wasted trying to save time (part 3)'
category: blog
tags: [FutureGateway, API, DevOps, Docker, Ansible, Container]
image:
  feature:
  attribution:
comments: false
mathjax: false
discourse: true
---

After months of understanding in principle[^ContainedGateway], but not being able to follow through in practice, we may be getting to a point where deploying a dev environment for [FutureGateway](https://github.com/FutureGateway) is possible.

"Wait, what ? Wasn't there always [a set of scripts](https://github.com/indigo-dc/fgSetup) for installing the FutureGateway components ?", I hear you counter. To that _I_ counter with a roll of the eyes and a sigh.

<figure>
<img src="https://media.giphy.com/media/qmfpjpAT2fJRK/giphy.gif">
</figure>


# What's wrong with the setup scripts ?

  1. They are scripts
  2. I rest my case[^ShellScripts][^DevOpsBootcamp]

<figure>
<img src="https://valdhaus.co/writings/ansible-vs-shell-scripts/squirrel-sword.jpg">
<figcaption>Thanks to <a href="https://valdhaus.co/writings/ansible-vs-shell-scripts/">Valdhaus</a> for putting it more eloquently than I ever could</figcaption>
</figure>

Ok, in the interest of maintaining some form of objectivity, let's discuss for a second why the scripts in [the setup repo](https://github.com/indigo-dc/fgSetup) are inadequate for deploying a dev environment. The first point comes from consideration of _what a dev environment is_. When we ran our hackfests[^Hackfests], we had an event site[^HackfestSite] intended to help the participants prepare for the hack. This included a set of warmup exercises[^WarmUps] for them to do before coming - some of which included making calls against an existing set of the services. These were all deployed in the hackfest preparation CI environment [^HackfestPrep], which we wanted to consist of a set of services acting as a dev environment. The idea was that if participants could make their code pass tests in our dev environment, it  could probably work out in the real world.

To be honest, we never got around to having a _fully automated_ deployment of the dev environment, even though we did provide a set of services which could be tested against. This meant that we couldn't (and at the time of writing, we still can't) fully reproduce the entire environment of the [Open Science Platform](https://www.sci-gaia.eu/osp) - but we're working on it.
Reproducibility means achieving the same state even if other factors are changed, such as the operating environment. Herein lies the problem with the shell scripts produced for the FutureGateway deployment  - they only work in one environment. Futhermore, **they only work if you make a whole bunch of assumptions** about that environment.

Some improvement was made in making the _installation_ of the components more stable, by "porting"[^porting] the shell scripts to [Ansible playbooks](https://www.ansible.com)
<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">that feeling when someone says they&#39;ve ported their shell script to <a href="https://twitter.com/ansible">@ansible</a> playbook, but then you read it, it&#39;s just a bunch of &quot;command:&quot; <a href="https://t.co/58k5VDSrSd">pic.twitter.com/58k5VDSrSd</a></p>&mdash; bruce becker (@brusisceddu) <a href="https://twitter.com/brusisceddu/status/869950388216188928">May 31, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

The [Ansible playbooks](https://github.com/Indigo-dc/fgsetup/tree/master/ansible) could use a massive `command:` purge and a bit of a re-write, but at least they give a good starting point for writing a reproducible orchestration of a dev environment. The first attempt to do this was with [AnsibleContainer](https://docs.ansible.com/ansible-container)[^PreviousPost] - but that attempt provide somewhat premature. I moved on to writing a [playbook](https://github.com/AAROC/DevOps/tree/master/Ansible/fg.yml) which explicitly used the [`docker_container`](https://docs.ansible.com/docker_container_module.html) module. Now, this is **not** what we want, because we're still forcing the dev environment to explicitly be based on Docker, and we're assuming that we have access to the Docker endpoint - both of these are pretty big assumptions ! - but it's still a reduction in the scope of our assumptions, I think. Most of all, because it allows us to Docker images[^DockerImages]. Another major point is that we start from **existing well-tested images** and extend them with our specific configuraitons.

So, now we have :

  1. A playbook that creates three containers and uses the docker connection to configure them, applying three roles : `AAROC.fg-api`, `AAROC.fg-db`, `AAROC.fg-ge`
  2. The [`AAROC.fg-api`](https://github.com/AAROC/AAROC.fg-api) role starts from the [Apache](https://hub.docker.com/_/httpd/) image providing `httpd` and applies the WSGI Python module and the FutureGateway API (via the python flask script)
  3. The [`AAROC.fg-db`](https://github.com/AAROC/AAROC.fg-db) role starts from the [MySQL community](https://hub.docker.com/_/mysql/) image providing the mysql database, and imports several necesary databases and their schema[^DBconfigs]
  4. The [`AAROC.fg-ge`](https://github.com/AAROC/AAROC.fg-ge) role starts from the official [Tomcat](https://hub.docker.com/_/tomcat/) image and imports the various jars and applications necessary to provide the GridEngine SAGA and OCCI connectors.

The work is still ongoing, and some major refactoring has to be done in order to improve the grouping of variables, password protection, etc. Another important factor which was glossed over  initially was the data persistence and volume claims for database, but also the user data (input/output sandboxes, _e.g._). This will come in a later release.

What this does now though is provide a far better understanding of how to compose the services necessary for  the FutureGateway, in the Open Science Platform, making it easier  for science gateway developers to set up their development environments locally.

# References and Footnotes

[^Hackfests]: The [Sci-GaIA project](https://www.sci-gaia.eu) ran three e-Research Hackfests during the course of the project, in [Catania](http://www.sci-gaia.eu/summer-hackfest/), [Lagos](http://www.sci-gaia.eu/wacren-hackfest/) and [Addis](http://www.sci-gaia.eu/ethernet-hackfest/).
[^HackfestSite]: Bruce Becker. (2016, December 18). AAROC/hackfest-site: e-Research Hackfest Website : Lagos. Zenodo. http://doi.org/10.5281/zenodo.208217
[^WarmUps]: Bruce Becker, & Mario Torrisi. (2016, December 18). AAROC/hackfest-warmups: e-Research Hackfest Warmups : Lagos. Zenodo. http://doi.org/10.5281/zenodo.208218
[^HackfestPrep]: Bruce Becker, & Mario Torrisi. (2016, December 18). AAROC/e-Research-Hackfest-prep: e-Research Hackfest Preparation : Lagos. Zenodo. http://doi.org/10.5281/zenodo.208216
[^ShellScripts]: We make this point in the "[Setting the Stage](https://github.com/AAROC/AnsibleBootCamp/blob/master/slides/SettingTheStage.pdf)" part of the [DevOps Bootcamp](https://github.com/AAROC/AnsibleBootCamp/)
[^DevOpsBootcamp]: Bruce Becker, Chris Rohrer, & Marco Fargetta. (2017, January). AAROC/AnsibleBootCamp: Ansible BootCamp - Entebbe. Zenodo. http://doi.org/10.5281/zenodo.242394
[^PreviousPost]: See [the previous post]({{ site_url }}/blog/2017/05/29/adventures-with-ansible-container/)
[^DockerImages]: We've pushed the [aaroc/fg_api](https://quay.io/repository/aaroc/fg_api), [aaroc/fg_db](https://quay.io/repository/aaroc/fg_db) and [aaroc/fg_ge](https://quay.io/repository/aaroc/fg_ge) repositories for the API, user tracking and events database and grid engine with SAGA and OCCI plugins respectively.
[^porting]: A ~600 line all-in-one playbook consisting of  `shell:`s and `command:`s is a pretty good example of "you're doing it wrong."
[^DBconfigs]: We still need to properly configure the data volumes which will contain these databases, so that we can make them portable with Ansible Container later.
[^ContainedGateway]: I was so naive  I even wrote [this hilariously triumphant blog post](https://brucellino.github.io/blog/blog/2016/09/18/Contained-Gateway/) back in September last year.
