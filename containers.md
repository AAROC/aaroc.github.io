---
layout: page
permalink: /containers/
title: Our Containers
headline: Packaged just right
tags: [middleware, containers, docker, DevOps]
image:
  feature: container.png
---

<div class="col-md-6">

    <h1>Why we do containers </h1>

    <ol>
        <li>because they are awesome.</li>
        <li>because we can test them</li>
        <li>because you can easily use them</li>
        <li>because they are portable</li>
        <li>because they are contextualisable</li>
    </ol>

    Containers can't solve everything, but they go a long way to making life easier for those of us testing and developing service configurations. They provide a lightweight means to flexibly deploy services and endpoints for users, applications and infrastructure
    needs.

    <h2>AAROC on Docker Hub</h2> We maintain our containers in automated build repositories on Docker hub (see the <a href="https://hub.docker.com/u/aaroc/dashboard/">AAROC Docker hub Dashboard</a>). The docker repos are linked to Github repos.

</div>

<div class="col-md-6">

    <h2 class="post-header">Containers we maintain.</h2>

    <div>
        <!-- the nav bar with tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#base" aria-controls="base" role="tab" data-toggle="tab">Base</a></li>
            <li role="presentation"><a href="#grid" aria-controls="grid" role="tab" data-toggle="tab">Grid</a></li>
        </ul>


        <!-- the tab content -->
        <div class="tab-content">

            <div role="tabpanel" class="tab-pane" id="base">
              Here is a table of everything
                <table class="table table-responsive">
                    <thead>
                        <td class="text-left">Container</td>
                        <td class="text-center">Status</td>
                    </thead>
                    {% for container in site.data.containers %}
                    <tr>
                        <td class="text-left">{{ container.name }} <br>
                            <a href="{{ container.registry.url}}"><img src="{{ site_url }}/images/docker.svg"></a>
                            <a href="https://github.com/{{ container.repo }}"> <i class="fa fa-github"></i></a>
                        </td>
                        <td class="text-center">
                            <a href="{{ container.travis.job }}"><img src="{{ container.travis.badge }}" /></a>
                        </td>
                    </tr>
                    {% endfor %}
                </table>
            </div>
            <!-- tab panel -->
        </div>
        <!-- tab content -->

    </div>
    Interested in contributing ? <a href="http://discourse.sci-gaia.eu/">Discuss with us</a>

</div>
