---
layout: post
title: Building VMs for CODE-RADE builds
description: 'In the beginning there were actual machines'
headline: "Why we're enabling VM build slaves again"
modified:
category: blog
tags: [cloud, Ansible, Update, automation]
image:
  feature: ricardo-gomez-angel-204573.jpg
  attribution: <a style="background-color:black;color:white;text-decoration:none;padding:4px 6px;font-family:-apple-system, BlinkMacSystemFont, &quot;San Francisco&quot;, &quot;Helvetica Neue&quot;, Helvetica, Ubuntu, Roboto, Noto, &quot;Segoe UI&quot;, Arial, sans-serif;font-size:12px;font-weight:bold;line-height:1.2;display:inline-block;border-radius:3px;" href="https://unsplash.com/@ripato?utm_medium=referral&amp;utm_campaign=photographer-credit&amp;utm_content=creditBadge" target="_blank" rel="noopener noreferrer" title="Download free do whatever you want high-resolution photos from Ricardo Gomez Angel"><span style="display:inline-block;padding:2px 3px;"><svg xmlns="http://www.w3.org/2000/svg" style="height:12px;width:auto;position:relative;vertical-align:middle;top:-1px;fill:white;" viewBox="0 0 32 32"><title>unsplash-logo</title><path d="M20.8 18.1c0 2.7-2.2 4.8-4.8 4.8s-4.8-2.1-4.8-4.8c0-2.7 2.2-4.8 4.8-4.8 2.7.1 4.8 2.2 4.8 4.8zm11.2-7.4v14.9c0 2.3-1.9 4.3-4.3 4.3h-23.4c-2.4 0-4.3-1.9-4.3-4.3v-15c0-2.3 1.9-4.3 4.3-4.3h3.7l.8-2.3c.4-1.1 1.7-2 2.9-2h8.6c1.2 0 2.5.9 2.9 2l.8 2.4h3.7c2.4 0 4.3 1.9 4.3 4.3zm-8.6 7.5c0-4.1-3.3-7.5-7.5-7.5-4.1 0-7.5 3.4-7.5 7.5s3.3 7.5 7.5 7.5c4.2-.1 7.5-3.4 7.5-7.5z"></path></svg></span><span style="display:inline-block;padding:2px 3px;">Ricardo Gomez Angel</span></a>
comments:
mathjax:
discourse: true
---

# In the beginning

At the start of CODE-RADE we had the idea to build executable applications in dedicated environments, and then ship them.
The platform which built Foundation Release 1 consisted of a single Jenkins server, with two virtual machines attached as build slaves, with a few executor (build slots) each. 
These were statically-provisioned machines with the relevant operating system on them[^OSes]. 
We used the most common executor method for builds, the [ssh build slave](https://wiki.jenkins.io/display/JENKINS/SSH+Slaves+plugin), and this worked very well for an initial demonstration.
It was easy to see what the slaves were doing, and there were actual machines to log into and debug if there were any issues.
Of course, there were issues. 
Many, many issues.
This piqued our interest in investigating more dynamic resource provisioning, and eventually for Foundation Release 2 we implemented a Docker backend for running the builds in containers (more about that [later](#docker-to-the-rescue)), but for now, let's go over the issues with running builds in statically-provisioned build servers.

# Issues with static build slaves

Let's start with a simple list of problems with building software in a statically-provisioned, shared server : 

  1. **Mutability** - each build environment is subject to change, either due to actions taken during the build, or by unwanted or unlogged human activity. Build failures could be "magically" circumvented by taking manual action on the build slave, and the strict link between code and build pipeline is lost.
  1. **Availability** - with static build slaves we have a fixed upper limit of resources available. Even if there is spare capacity in principle at the site, we cannot use it, because the slaves are not provisioned based on the demand. This results in particularly long wait-times for example when we run a burn-down, and wasted  cycles when there are no builds under way.
  1. **Nukability** :boom: (aka *Infrastructure as Code*) - rebuilding the platform after catastrophic events is impossible if parts of it are not expressed as code. This happened, _e.g._ during a Jenkins upgrade and we were forced to rebuild the platform from scratch, the thing that took a while to reproduce was the build slaves. 
  1. **Portability** and **Reproducibility** - another aspect of the reproducibility problem we alluded to in the previous point was that the details of the build systems were hidden behind an opaque manual process. We had no way to _prove_ that our builds were conducted in a specific environment, and there was no way for others to reproduce our work. Since CODE-RADE purports to be an Open Science enabler, this was an unfortunate situation which we needed to address.

There were several other more technical issues related to maintaining these build slaves - ensuring that they were properly networked, protected, had adequate build space, that the mounts were properly set up, users had correct permissions _etc_. It was a situation that really had to be addressed, which we did in Foundation Release 2, where we moved to builds in Docker containers.

We describe how this was done below, and how it addressed the issues discussed above. 


# Docker to the rescue

To his credit, my man @fanie-riekert originally proposed a "Docker solution" way back in 2013. I wasn't convinced, because I am an ignorant luddite, but we mentioned this in the first few talks 

<div class="text-center">
<iframe src="//www.slideshare.net/slideshow/embed_code/key/fe1nPxcNzMlcBx?startSlide=49" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/brucellino/jenkins-43354970" title="Continuous Integration and Delivery of Research Applications" target="_blank">Continuous Integration and Delivery of Research Applications</a> </strong> from <strong><a href="//www.slideshare.net/brucellino" target="_blank">Bruce Becker</a></strong> </div>
</div>

At that stage, the idea was that we could _ship_ artefacts with Docker easier, but we soon came to appreciate the fact that we could _build_ them with Docker too.
First, we had to solve two challenges : 

  1. Get Jenkins to provision containers and run builds in them
  1. Craft the containers in such a way that we could address the issues mentioned above.

After much grunting and cursing, we arrived at a solution. This consisted of installing the relevant plugins[^JenkinsDockerPlugins] on the Jenkins server, and creating an Ansible role for provisioning the build containers[^CODE-RADE-build-containers].
This allowed us to start from a single repository of code and reliably build, test and deliver the build environment itself, contained in these images[^quay_images].

There was much celebration and many build errors were slain, and yea, we shipped a lot of applications. But a darkness fell over the mirth, as something went wrong with the Docker installation on the build host.

## Docker  issues

It's very difficult to say what went wrong, but at some point Jenkins had a hard time attaching to the containers it provisioned. 
At first, I thought it was  due to the ssh connection not trusting the ssh host keys on the provisioned container[^SSH_connection], but that was eventually excluded as a cause. It seems that the issue lies with the networking configuration of docker on the host.
While these will eventually be solved, perhaps by taking the nuclear option again, we had previously started several discussions on scaling out the build capacity of CODE-RADE horizontally across sites[^HorizontalScaling].

# Best of all worlds ? 

Now, the picture  we have painted is  perhaps something of a false dichotomy: why should we _choose_ between Docker builds and VM builds ? What if we could build in _both_ Docker _and_ Virtual Machines, appropriately provisioned in exactly the same environment, against the relevant endpoints ? 

After several discussions with @bazinski about building at the CHPC, we tried to scale out builds by attaching a new Docker cloud there. This was eventually aborted, since we didn't consider the need for the containers to call back to the Jenkins master over the network (which required a public IP address for the container, if it was provisioned off-site). However, we also had the option of a _bunch_ of other platforms : [OpenStack](https://plugins.jenkins.io/openstack-cloud), [Azure](https://plugins.jenkins.io/azure-slave-plugin), [Kubernetes](https://plugins.jenkins.io/kubernetes), [Mesos](https://plugins.jenkins.io/mesos) and many more.

It just so happened that we had access to an OpenStack endpoint to plug into ! If only we had a way to build VMs with _exactly_ the same environment as the Docker images...

## CODE-RADE builds on OpenStack

Turns out this is not just feasible, but pretty easy because we are not barbarians and we designed this :poop: right ! We just need to apply the same role we used in the case of the containers to the vm, and have some way of expressing the actual build as code. Turns out there's an app for that - [Packer](http://packer.io/). 
We alluded to the use of Packer in a [previous post]({% post_url 2018-01-17-CD-run-everywhere %}), where it was used to build CODE-RADE client VMs. The templates for these are in the <a href="https://githu.com/AAROC/DevOps"><i class="fa fa-github"></i> DevOps repo</a>, which is also where we'll be adding the new templates for the build images. We'll need to update  the role a bit, and include a playbook for using it in the builds, but this shouldn't be too hard. 

So, watch this space for more builds in more places than you can shake a pointy stick at. Also, if you have an OpenStack endpoint and would like to donate some build capacity to the project, get in touch.

-----


# References and Footnotes

[^OSes]: Foundation Release 1 had only CEntOS6 and Ubuntu 14.04 build slaves.
[^JenkinsDockerPlugins]: We use the [Docker plugin](https://plugins.jenkins.io/docker-plugin) to provision containers. The problem with the [Docker Slaves plugin](https://plugins.jenkins.io/docker-slaves) and [CloudBees Docker Custom Environment](https://plugins.jenkins.io/docker-custom-build-environment) plugins was that they didn't allow parametrisation of the build environment into several operating system images. 
[^CODE-RADE-build-containers]: Bruce Becker. (2017, July 14). AAROC/CODE-RADE-container: CODE-RADE Build Container - Java8 (Version v0.0.2-fr3). Zenodo. http://doi.org/10.5281/zenodo.827311
[^quay_images]: The images are easily distributed through a container image registry. In our case, we use an [organisation on quay](https://quay.io/aaroc)
[^SSH_connection]: There are a few ways that Jenkins can connect to the containers that it provisions - JNLP, direct attachment or SSH. We chose SSH, and implemented this in the container role, as described in [this post]({% post_url 2018-01-29-CODE-RADE-Build-Containers-update %})
[^HorizontalScaling]: See ["Delivering CODE-RADE environments"]( {% post_url 2018-01-17-CD-run-everywhere %})