---
layout: post
title: Updating CODE-RADE Build Containers
description: 'A log of updating from v1 to v2'
headline: 'A :tomato: by :tomato: commentary'
modified:
category: blog
tags: [Docker, Ansible, Quay, Update, automation]
image:
  feature: chris-barbalis-229388.jpg
  attribution: <a style="background-color:black;color:white;text-decoration:none;padding:4px 6px;font-family:-apple-system, BlinkMacSystemFont, &quot;San Francisco&quot;, &quot;Helvetica Neue&quot;, Helvetica, Ubuntu, Roboto, Noto, &quot;Segoe UI&quot;, Arial, sans-serif;font-size:12px;font-weight:bold;line-height:1.2;display:inline-block;border-radius:3px;" href="https://unsplash.com/@cbarbalis?utm_medium=referral&amp;utm_campaign=photographer-credit&amp;utm_content=creditBadge" target="_blank" rel="noopener noreferrer" title="Download free do whatever you want high-resolution photos from Chris Barbalis"><span style="display:inline-block;padding:2px 3px;"><svg xmlns="http://www.w3.org/2000/svg" style="height:12px;width:auto;position:relative;vertical-align:middle;top:-1px;fill:white;" viewBox="0 0 32 32"><title>unsplash-logo</title><path d="M20.8 18.1c0 2.7-2.2 4.8-4.8 4.8s-4.8-2.1-4.8-4.8c0-2.7 2.2-4.8 4.8-4.8 2.7.1 4.8 2.2 4.8 4.8zm11.2-7.4v14.9c0 2.3-1.9 4.3-4.3 4.3h-23.4c-2.4 0-4.3-1.9-4.3-4.3v-15c0-2.3 1.9-4.3 4.3-4.3h3.7l.8-2.3c.4-1.1 1.7-2 2.9-2h8.6c1.2 0 2.5.9 2.9 2l.8 2.4h3.7c2.4 0 4.3 1.9 4.3 4.3zm-8.6 7.5c0-4.1-3.3-7.5-7.5-7.5-4.1 0-7.5 3.4-7.5 7.5s3.3 7.5 7.5 7.5c4.2-.1 7.5-3.4 7.5-7.5z"></path></svg></span><span style="display:inline-block;padding:2px 3px;">Chris Barbalis</span></a>
comments:
mathjax:
discourse: true
---

Another in a series of "state-of-development-consciousness" blog posts. In this one, we try to update the AnsibleContainer project for the CODE-RADE build containers. 

# :tomato: 1

> Now playing
> **"Backlash", by Black Joe Lewis and the Honeybears**

  * Create a new branch of the repo
  * Clean out `container.yml` to contain just one of the services.
  * Pull base containers from quay.io
  * **There seems to be a change in the way the data volumes are handled**

The data volumes needed are to provide persistence across builds and sites for build products, modulefiles, setup files, _etc_. 
This was previously done using `volumes_from` directives in the services, and data-volume containers were created from the smallest possible base (alpine). 
Now, we have the pure data container pattern, so we need to create the volume itself, not the container with the data volume. 
On my laptop there are several data volumes, but the `ansile_CODE-RADE-xyz` data volumes are basically empty : 

{% highlight shell %}
8.0K	ansible_CODE-RADE-cvmfs_1
8.0K	ansible_CODE-RADE-modules_1
8.0K	ansible_CODE-RADE-repo_1
8.0K	ansible_CODE-RADE-soft_1
8.0K	ansible_CODE-RADE-src_1
{% endhighlight %}

  * In the spirit of cleaning out everything - nuke ALL the data volumes  ! (bonus side-effect - cleaned out **20GB**)
  * Started [first build attempt](#attempt-1)

# :tomato: 2

> **"Return to the 37th", by El Michaels Affair**
  
  * Read the [Docker volume documentation for v2](https://docs.docker.com/compose/compose-file/compose-file-v2/#volume-configuration-reference)
  * Declare top-level directive `volume` with just the name and driver.
  * Tried [second attempt](#attempt-2) - missing dependencies in the virtualenv, installed them. CEntOS6 base image not giving any :heart:, so moved to CEntOS7 for now.

# :tomato: 3

> **"Eastbound", the Budos Band**

  * CEntOS7 image is built and can run. 
  * SSH Host Key has changed. No damn good  ! We need to change the tasks in the [role](https://galaxy.ansible.com/AAROC/CODE-RADE-container/)... time to get back to dev.

# :tomato: 4

> **"Crush" by Lettuce**

  * Remove the ssh host key generation task from the role
  * Pre-generate ssh keys for RSA, DSA and ECDSA keys
  * Add tasks to copy these to the SSH directory of the endpoint

# :tomato: 5

> **Complete Mythology", by Syl Johnson**

  * We can't add the private keys to the repo in clear text, so we need to encrypt them with vault. Check the Ansible documentation to see if vault is supported... seems to be.
  * move to a new branch (`static-host-keys`)
  * Before we go full-hog encrypting all the things, let's see if this update will pass a molecule test... (there goes the :tomato: - these builds take a while)
  * Builds are passing (CEntOS7 at least) - let's see if we can encrypt them and test the role with molecule - `ansible-vault encrypt files/etc/ssh/<key-file>`

# :tomato: 6

> **"Nude & Rude", by Iggy Pop**

  * How do we tell molecule about the vault password now ? [Here's how](https://github.com/metacloud/molecule/issues/1061) - TL;DR: `provisioner.options`
  * Well... neither the Ansible Container documentation for vault nor the molecule documentation for vault is working. Tried the vault password in a file, but neither the environment variable `ANSIBLE_VAULT_PASSWORD_FILE` nor `--vault-password-file`  flag seem to work.
  * I guess I can test the image build locally and push to the registry so that we can see if Jenkins is happier.

## Build attempts 

### Attempt 1

**`Container.yml`**

{% highlight yaml %}

services:
  centos6:
    from: "quay.io/aaroc/ansible-ready-centos6:latest"
    privileged: true
    volumes:
      - ansible_CODE_RADE-src_1:/data/src
    roles:
      - AAROC.CODE-RADE-container
    ports:
        - "5000:5200"
    command: ["/usr/sbin/sshd", "-D","-p","5200"]
    
volumes:
  ansible_CODE-RADE-src_1:
   docker:
    - /data/src

{% endhighlight %}

This gave error : 

`ERROR	The container.yml file is invalid: ['/data/src'] is not of type 'object'`

### Attempt 2 

Hit [this issue](https://github.com/ansible/ansible-container/issues/692). 

CEntOS6 image not working.
This is also referenced in <i class="fa fa-github"></i> [an issue](https://github.com/AAROC/CODE-RADE-container/issues/5) opened by Jenkins during a previous build.


# Summary

Vault with Ansible Container is not working for me. Doing things properly, 

  * I need to encrypt the private keys so that 
  * I can commit them somewhat safely to the repo so that 
  * Ansible Galaxy can find the role so that
  * Ansible Container can use the role

I can circumvent that for the moment by using `--roles-path` and not requring anything to be pushed to the repo. That would be cheating.