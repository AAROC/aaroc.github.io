---
layout: post
title: 'Transient Access to Persistent data for CI'
description: ''
headline: ''
modified:
category: blog
tags: [CODE-RADE, Environments, Docker, Jenkins, Ansible, Continuous Delivery]
image:
  feature: "mario-calvo-345.jpg"
  attribution: | 
                <a style="background-color:black;color:white;text-decoration:none;padding:4px 6px;font-family:-apple-system, BlinkMacSystemFont, &quot;San Francisco&quot;, &quot;Helvetica Neue&quot;, Helvetica, Ubuntu, Roboto, Noto, &quot;Segoe UI&quot;, Arial, sans-serif;font-size:12px;font-weight:bold;line-height:1.2;display:inline-block;border-radius:3px;" href="https://unsplash.com/@mariocalvo?utm_medium=referral&amp;utm_campaign=photographer-credit&amp;utm_content=creditBadge" target="_blank" rel="noopener noreferrer" title="Download free do whatever you want high-resolution photos from Mario Calvo"><span style="display:inline-block;padding:2px 3px;"><svg xmlns="http://www.w3.org/2000/svg" style="height:12px;width:auto;position:relative;vertical-align:middle;top:-1px;fill:white;" viewBox="0 0 32 32"><title>unsplash-logo</title><path d="M20.8 18.1c0 2.7-2.2 4.8-4.8 4.8s-4.8-2.1-4.8-4.8c0-2.7 2.2-4.8 4.8-4.8 2.7.1 4.8 2.2 4.8 4.8zm11.2-7.4v14.9c0 2.3-1.9 4.3-4.3 4.3h-23.4c-2.4 0-4.3-1.9-4.3-4.3v-15c0-2.3 1.9-4.3 4.3-4.3h3.7l.8-2.3c.4-1.1 1.7-2 2.9-2h8.6c1.2 0 2.5.9 2.9 2l.8 2.4h3.7c2.4 0 4.3 1.9 4.3 4.3zm-8.6 7.5c0-4.1-3.3-7.5-7.5-7.5-4.1 0-7.5 3.4-7.5 7.5s3.3 7.5 7.5 7.5c4.2-.1 7.5-3.4 7.5-7.5z"></path></svg></span><span style="display:inline-block;padding:2px 3px;">Mario Calvo</span></a>
comments: false
mathjax: false
discourse: true
---

One of the main reasons we built CODE-RADE was to ensure that **only the good stuff** gets into the application repository.
We want site maintainers and administrators to rest safe in the fact that mounting this repository is reliable, which is why we put such a high premium on _testing_.

# The CODE-RADE pipeline

We tentatively compile things based on scripts in a repository, then test them in an ephemeral but reproducible environment.
This environment needs to be augmented by the products from previous builds, since CODE-RADE builds **atomically**.
We need a repository of the artifacts in this environment to be persisted since they must be available across builds - 
once one part of the repository has been thoroughly tested, we need to keep it as a building block for whatever comes downstream, so that we don't have to build the entire chain from scratch.

This is easy if you're on a single machine - just put things in a dedicated directory, and refer to that via an environment variable.
If you're working with containers, to provide a clean build environment, you can use the [data volume pattern](https://docs.docker.com/engine/admin/volumes/volumes/)[^DataContainers] - this also works great when you're building on a single site. Data in the CI build and test phase are persisted using data volumes, as shown in [Figure 1](#figure1)

<figure id="figure1">
<img src="{{ site_url}}/images/CODE-RADE-pipeline.svg">
<figcaption>
The CODE-RADE delivery pipeline, showing phases (vertical lanes) and artifacts (horizontal lanes).
</figcaption>
</figure>

However, what about the case where you want to build "in the cloud", or in geographically distributed places?
 
# Building in the cloud

The heart of CODE-RADE is the CVMFS repository, which acts as a content distribution network for the quality products we build.
_How_ these products get into that repository is not prescribed - we only make the qualitative constraint that they need to be tested.
Typically this testing is done by taking automated actions triggered by changes to a change-controlled repository.
The kind of  thing that does  this is typically referred to as a "continuous integration server", or CI- in our case, one of the most widely-used ones: [Jenkins](https://jenkins.io), but in principle any one would do.
This also means that in principle, our Jenkins server at [ci.sagrid.ac.za](https://ci.sagrid.ac.za) does not _by design_ have a monopoly on the right to push products into the CVMFS repository!
This could be done by any participating CI server, as long as there is some kind of co-ordination between them regarding who gets to build which job, and whether the tests are coherent.

We are reaching the limits of what a single build host can do, 
Previously, we would build artifacts and then tar them up into tarballs, which could be picked off the shelf, unpacked into the build environment and linked against - this could be one option. 

Another would be to re-use the CVMFS infrastructure and have a CI repository, which could be mounted just like in deployment.

Both of these should be used in subsequent releases of CODE-RADE infrastructure.


# References and Footnotes

[^CODE-RADE-Containers]: Bruce Becker. (2017, May 6). AAROC/CODE-RADE-build-containers: CODE-RADE Foundation Release 3 - Build Containers (Version v0.0.2-fr3). Zenodo. http://doi.org/10.5281/zenodo.572275
[^DataContainers]: Actually, we're using the now-deprecated "data container" pattern and we still need to move to this data-volume pattern. Docker is not for the slow, yo.