---
layout: post
title: 'Monitoring with prometheus'
description: 'A foray into monitoring the gridcloud with prometheus'
headline: 'prometheus'
modified:
category: blog
tags: [prometheus, monitoring]
image:
  feature: Prometheus.png
  attribution:
comments:
mathjax:
discourse: true
---

# Modernising regional monitoring.

Monitoring and alerting is a key part of keeping a distributed platform operational.
This has typically been done by generating a topology for a region using the [GOCDB](https://goc.egi.eu) and using [Nagios](https://www.nagios.org/) to monitor services at sites.
These monitors are linked to operating level agreements that define thresholds; if these thresholds of service state, availability, _etc_ are exceeded, an alert is issued, and site administrators are urged to take action.

This is all well and good, but it's time to experiment with a different monitoring service, [Prometheus](https://prometheus.io). 
This to scratch the following itches : 

  - have a closer view into the trends of site services
  - have some deeper tooling (in order to have better understanding of their behaviour)
  - just investigate new ways of doing things.

# Regional monitoring infrastructure

The regional services include everything that falls under the GOC region, _as well as_ the services _in_ the region which are _not_ in the GOC. 
These are perhaps out-of-project resources, services that are not yet at production level, or experimental services which are not in the EGI service catalogue.

It is the desire to have a monitoring infrastructure that discovers these services (via some as-yet unknown mechanism), includes them in the monitoring topology and collects metrics, eventually sending them to a dashboard. 
This requires some initial infrastructure:

  - **Deployment cloud**: We need somewhere to deploy the initial services to
  - **Monitoring service**: We'll use Prometheus for this and put a Prometheus server on the cloud
  - **Alerting service**: We need a service to issue alerts based on monitoring data; we'll use the Prometheus "AlertManager" for this
  - **Dashboard**: The metrics will be displayed on a Grafana dashboard.
  - **Instrumentation**: We need to _instrument_ the services so that we can collect monitoring data from them. This data is _host_-level as well as _application_-level data.

## Deployment Strategy

Starting from the bare cloud [^BareCloud], we adopt the pattern of  "Infrastructure as Code".
This means expressing the deployment strategy for our monitoring services as code, and deciding on an execution model to deploy them.
Deployment models could include tools such as [Terraform](terraform.io), or some [Ansible](http://www.ansible.com) or [Puppet](https://puppet.com/) code.

For our purposes, I will be assuming a set of Ansile roles used in playbooks  which express the desired state layer by layer, using the [Ansible OpenStack modules](https://www.ansible.com/openstack) to provision machines.
Of course, these roles need to be developed and tested, before being used in the playbooks, and the playbooks themselves need to be tested in the staging environment, in order to run functional tests on their results.
We will use a combination of [Molecule](molecule.readthedocs.io/), OpenStack[^TestingEnv], [Docker](http://docker.com/) and [Travis](https://travis-ci.com) to run the tests.

<figure>
<img src="{{ site.url }}/images/Deployment.svg" />
<figcaption>Workflow for continuous delivery of monitoring and alerting services.</figcaption>
</figure>

Typically the roles are tested independently with molecule, both locally, and by Travis on every push.
Once the roles are passing their own checks, they are combined into the deployment playbook, which both provisions the servers and configures them.
These playbooks will express different servers based on the environment they are given [^dev-prod-parity].
Once the machines are provisioned, the functional tests are run on the servers using [ServerSpec](serverspec.org) or [TestInfra](testinfra.readthedocs.io/en/latest/); these can be considered **integration** tests that supplement the **functional** tests run during dev by Molecule.
If the staging environment passes the tests, it is destroyed  (VMs in it are deleted), and the playbook is run with the prod environment, to update the service configuration.

### Roles

This will require a few roles and playbooks: 

  - **Prometheus**: _the prometheus server itself, as well as the alert maanger. Monitoring data will be sent to a grafana dashboard_
  - **Grafana**: _role to deploy grafana dashboard, to display the monitoring data_

The playbook would include these roles as follows:

{% highlight yaml %}
- name: Deploy Prometheus server
  hosts: monitors
  user: drillbot
  roles:
  - {role: prometheus-role, become: true}

- name: Deploy Grafana Dashboard
  hosts: dashboards
  user: drillbot
  roles:
  - {role: grafana, become: true}
{% endhighlight %}

Here we can see that the Prometheus role is applied to the set of machines in the  `monitors` group and the Grafana role is applied to a different set of machines in the `dashboards` group.
The main task in Grafana would be the configuration 

### Orchestration and context

The most important aspect of the Grafana task is the configuraiton of the server, which is kept in an [`ini` file](http://docs.grafana.org/installation/configuration/).
Grafana has 1st-class support for a [Prometheus data source](http://docs.grafana.org/features/datasources/prometheus/), but the admin has to _manually_ add the source once the installation is done according to the docs.
It seems to be possible[^GrafanaPrometheusTemplateRole], via the Grafana REST interface:

{% highlight yaml %}
{% raw %}
- name: GRAFANA | Import stats dashboard
  uri:
    url: "http://{{ ansible_nodename }}:{{ grafana_port }}/api/dashboards/db"
    method: POST
    HEADER_Accept: application/json
    HEADER_Content-Type: application/json
    force_basic_auth: yes
    user: "{{ grafana_admin_user }}"
    password: "{{ grafana_admin_password }}"
    body: "{{ lookup('template', 'templates/dashboards/prometheus_stats.json.j2')}}"
    body_format: json
    response: 200
{% endraw %}
{% endhighlight %}

This work is currently underway; see the [prometheus role](https://github.com/AAROC/prometheus-role) and [grafana role](https://github.com/AAROC/DevOps/tree/master/Ansible/roles/grafana)[^MaybeLater]

-----

# References and Footnotes

[^BareCloud]: We will be assuming an OpenStack private cloud, but you could probably do this with anything. It just changes the infrastructure provisioning side, probably.
[^TestingEnv]: The testing environment will be provisioned by Molecule on the OpenStack cloud itself, just with different variables. Tr&egrave;s [12factor](http://12factor.net)
[^dev-prod-parity]: This satisfies [factor X](https://12factor.net/dev-prod-parity), "Dev-Prod parity
[^GrafanaPrometheusTemplateRole]: See <i class="fa fa-github"></i> [idealista/grafana-role](https://github.com/idealista/grafana-role/).
[^MaybeLater]: This role is not in Galaxy yet, perhaps later we'll move it out of the main DevOps repo and into it's own Galaxy repo.