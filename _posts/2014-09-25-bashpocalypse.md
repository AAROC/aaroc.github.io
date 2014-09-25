---
layout: post
title: Skirting the bashpocalypse
description: Skirting the bashpocalypse
headline: The bashpocalypse is upon us !
category: DevOps
tags: [AAROC, bashpocalypse, operations, csirt, security, updates, CVE-2014-6271]
image: 
  feature: 
comments: true 
---

# The \#bashpocalypse is upon us ! 

Holy wow - ***bash*** ? There's a security flaw in bash !? Wowzers, that affects probably every machine out there. We need to fix that, *stat*.

> DevOps to the rescue 

We quickly whipped up an [Ansible](http://www.ansibleworks.com) playbook to detect and fix the problem. It's in the [AAROC DevOps repo](https://github.com/AAROC/DevOps).


---

We use a simple script to test whether the vulnerability is present on a machine and then try to update from the default repos. Since this may not be available, if the test passes again (*ie* the machine is still vulnerable), we change the `yum` repo used for security updates to the default one of Scientific Linux.

    - hosts: all
      tasks: 
		- name: test bash
		  script: ./config/files/test-bashpocalypse.sh
		  register: result
		  ignore_errors: True

       - yum: name=bash state=latest
		 when: result.stdout | search("vulnerable")
         notify: check
   
	  - name: update the security repo if needed
	    lineinfile: dest=/etc/yum.repos.d/sl.repo regexp=^baseurl= line=baseurl=http://ftp.scientificlinux.org/linux/scientific/6x/x86_64/updates/security/
	    when: result.stdout | search("vulnerable")

	  - name: update bash after repo change
	    yum: name=bash state=latest
	    notify: check
	    when: result.stdout | search("vulnerable")
	  
	  handlers:
	  - name: check
	    script: ./config/files/test-bashpocalypse.sh
	    register: result
	    ignore_errors: True

----

In order to use this, simply 

  1. Check out Ansible if you don't have it yet 
     1. `git clone https://github.com/ansible/ansible.git`
     1.  `cd ansible/ansible`
     1. `sudo python setup.py install`
  1. Get our code:  `git clone https://github.com/AAROC/DevOps`
  1. Add or update your inventory in `AAROC/DevOps/Ansible/inventories`
  1. Run the playbook : `ansible-playbook -i <inventory> bashpocalypse_fix.yml`
  
You are now patched.

Feel free to contact `csirt-info@sanren.ac.za` for further support.
  
-----

# Updates

Times are SAST

  1. 10:00 25/09/2014 : Meraka, KENET, DIT sites patched
  1. 10:22 25/09/2014 : UCT updating local repo mirrors
  1. 11:24 25/09/2014 : University of Johannesburg patched
  1. 13:11 25/09/2014 : Magrid patched

# References
  
  1. http://seclists.org/oss-sec/2014/q3/649
  1. http://bashpocalypse.com
  1. https://access.redhat.com/security/cve/CVE-2014-6271
