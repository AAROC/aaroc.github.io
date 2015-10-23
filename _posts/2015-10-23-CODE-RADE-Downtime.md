---
layout: post
title:  'CODE-RADE Downtime'
description: 'The road to downtime is paved with good intentions'
headline: 'We done goofed.'
category: blog
tags: [blog, CODE-RADE, sitrep, downtime, goof, doh!]
image:
  feature: he__s_dead_jim_by_pepper_fox.jpg
  attribution: "Image courtesy of Deviant Art http://orig00.deviantart.net/0872/f/2009/167/7/e/he__s_dead_jim_by_pepper_fox.jpg"
comments: false
mathjax: false
discourse: true
---

# We killed Jenkins

We didn't mean to. Actually, we were just about to publish [Foundation Release 1](). The plan was to make the release, upgrade Jenkins and move on... _in that order_. Of course, thinking that everything would be fine if we just upgraded Jenkins and _then_ published the release, we went ahead and upgraded to [1.625](http://updates.jenkins-ci.org/1.625/latest/jenkins.war) and then ... bad things happened.

<figure>
<img src="{{ site_url }}/images/oops-jenkins.png"></img>
<figcaption>Let's just say things went pear-shaped</figcaption>
</figure>

# What went wrong

So, actually the service _is_ up and running, but several - almost all - of our jobs were removed from the Jenkins configuration :scream:. This is pretty horrific, we'd spent months adding these jobs and painstakingly ensuring that their dependencies were correctly encoded... However, checking the config directory, we noticed that all of the job configs[^Configs] were still there. They just weren't being accepted by Jenkins.

----

So, what went wrong ?

----


The first log entry we encountered was :

```java
    WARNING: Failed to scout com.tikal.jenkins.plugins.multijob.MultiJobBuildSelector
java.lang.InstantiationException: java.lang.NoClassDefFoundError: hudson/plugins/copyartifact/BuildSelector
```

Now, most of our jobs are [matrix jobs](https://wiki.jenkins-ci.org/display/JENKINS/Matrix+Project+Plugin) which allow us to test the various configurations of operating system, version number, compiler configuration, _etc_. The above error was the first hint that this was a _plugin_ issue and not an actual Jenkins issue.

Then, we started getting these :

```java
    SEVERE: Could not load actions from hudson.plugins.jswidgets.JsProjectActionFactory@6ca0e1b6 for hudson.matrix.MatrixProject@73ac157[hdf5-deploy]
```

followed by

```java
    Oct 23, 2015 2:41:58 PM jenkins.InitReactorRunner$1 onTaskFailed
    SEVERE: Failed Loading job hdf5-deploy
    java.lang.NullPointerException
```

As you can see that is for a specific job `hd5-deploy`, which was using the MatrixProject configuration. It's also using a bunch of Jenkins plugins which are how we configure these jobs to do the things we want them to do.

## Job triggers ?

In particular, the job build triggers are using the [Github](https://wiki.jenkins-ci.org/display/JENKINS/GITHUB+plugin) and [Github Pull Request](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+pull+request+builder+plugin) plugins.

The lowest-lying job in the dependency graph, [`gmp-deploy`](https://github.com/SouthAfricaDigitalScience/gmp-deploy) was also not loaded. This is _only_ triggered by Github events, and not other jobs[^HumanIntervention] and was throwing errors like this :


```java
  Oct 23, 2015 2:42:13 PM jenkins.InitReactorRunner$1 onTaskFailed
  SEVERE: Failed Loading job gmp-deploy
  java.lang.NullPointerException
  at hudson.matrix.MatrixProject.createTransientActions(MatrixProject.java:442)
  at hudson.model.AbstractProject.updateTransientActions(AbstractProject.java:748)
  at hudson.matrix.MatrixProject.updateTransientActions(MatrixProject.java:456)
  at hudson.model.AbstractProject.save(AbstractProject.java:304)
  at org.jenkinsci.plugins.ghprb.GhprbTrigger.save(GhprbTrigger.java:171)
  at org.jenkinsci.plugins.ghprb.GhprbTrigger.start(GhprbTrigger.java:186)
  at org.jenkinsci.plugins.ghprb.GhprbTrigger.start(GhprbTrigger.java:52)
  at hudson.model.AbstractProject.onLoad(AbstractProject.java:326)
  at hudson.matrix.MatrixProject.onLoad(MatrixProject.java:497)
  at hudson.model.Items.load(Items.java:322)
  at jenkins.model.Jenkins$17.run(Jenkins.java:2655)
	at org.jvnet.hudson.reactor.TaskGraphBuilder$TaskImpl.run(TaskGraphBuilder.java:169)

```

So, this points in the direction of the "GhprbTrigger" the trigger that says "build this job when a pull request is sent to the Github repo". There are some suggestions that these are known bugs, from the [Jenkins JIRA](https://issues.jenkins-ci.org/browse/JENKINS-28417),  but the solution that was suggested did not fix anything.

## Hints from the job configurations

The `gmp-deploy` job configuration looks like this :

```xml
    <?xml version='1.0' encoding='UTF-8'?>
    <matrix-project plugin="matrix-project@1.4.1">
    <actions/>
    <description></description>
    <logRotator class="hudson.tasks.LogRotator">
      <daysToKeep>30</daysToKeep>
      <numToKeep>100</numToKeep>
      <artifactDaysToKeep>60</artifactDaysToKeep>
      <artifactNumToKeep>30</artifactNumToKeep>
    </logRotator>
    <keepDependencies>false</keepDependencies>
    <properties>
      <com.sonyericsson.jenkins.plugins.bfa.model.ScannerJobProperty plugin="build-failure-analyzer@1.13.1">
        <doNotScan>false</doNotScan>
      </com.sonyericsson.jenkins.plugins.bfa.model.ScannerJobProperty>
      <com.coravy.hudson.plugins.github.GithubProjectProperty plugin="github@1.14.0">
        <projectUrl>https://github.com/SouthAfricaDigitalScience/gmp-deploy.git/</projectUrl>
      </com.coravy.hudson.plugins.github.GithubProjectProperty>
      <com.chikli.hudson.plugin.naginator.NaginatorOptOutProperty plugin="naginator@1.15">
        <optOut>false</optOut>
      </com.chikli.hudson.plugin.naginator.NaginatorOptOutProperty>
      <hudson.plugins.promoted__builds.JobPropertyImpl plugin="promoted-builds@2.23">
        <activeProcessNames>
          <string>human approved</string>
          <string>build passes on sl6</string>
          <string>build passes on u1404</string>
          <string>push artifacts</string>
        </activeProcessNames>
      </hudson.plugins.promoted__builds.JobPropertyImpl>
    </properties>
    <scm class="hudson.plugins.git.GitSCM" plugin="git@2.4.0">
      <configVersion>2</configVersion>
      <userRemoteConfigs>
        <hudson.plugins.git.UserRemoteConfig>
          <url>https://github.com/SouthAfricaDigitalScience/gmp-deploy</url>
          <credentialsId>you wish</credentialsId>
        </hudson.plugins.git.UserRemoteConfig>
      </userRemoteConfigs>
      <branches>
        <hudson.plugins.git.BranchSpec>
          <name>*/master</name>
        </hudson.plugins.git.BranchSpec>
      </branches>
      <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
        <submoduleCfg class="list"/>
      <extensions/>
    </scm>
    <triggers>
      <com.cloudbees.jenkins.GitHubPushTrigger plugin="github@1.14.0">
        <triggers>
          <com.cloudbees.jenkins.GitHubPushTrigger plugin="github@1.14.0">
            <spec></spec>
          </com.cloudbees.jenkins.GitHubPushTrigger>
          <org.jenkinsci.plugins.ghprb.GhprbTrigger plugin="ghprb@1.29.2">
            ... stuff ...
          </org.jenkinsci.plugins.ghprb.GhprbTrigger>
          <project>gmp-deploy</project>
          <__project class="matrix-project" reference="../../.."/>
          <gitHubAuthId>you wish</gitHubAuthId>
          <extensions>
            <org.jenkinsci.plugins.ghprb.extensions.status.GhprbSimpleStatus>
              <commitStatusContext></commitStatusContext>
              <triggeredStatus></triggeredStatus>
              <startedStatus></startedStatus>
              <statusUrl></statusUrl>
            </org.jenkinsci.plugins.ghprb.extensions.status.GhprbSimpleStatus>
          </extensions>
        </org.jenkinsci.plugins.ghprb.GhprbTrigger>
        </triggers>
    <concurrentBuild>false</concurrentBuild>
    <axes>
      <hudson.matrix.TextAxis>
        <name>VERSION</name>
        <values>
          <string>5.1.3</string>
        </values>
      </hudson.matrix.TextAxis>
      <hudson.matrix.LabelExpAxis>
        <name>SITE</name>
        <values>
          <string>generic</string>
        </values>
      </hudson.matrix.LabelExpAxis>
      <hudson.matrix.LabelExpAxis>
        <name>OS</name>
        <values>
          <string>sl6</string>
          <string>u1404</string>
        </values>
      </hudson.matrix.LabelExpAxis>
      <hudson.matrix.LabelExpAxis>
        <name>ARCH</name>
        <values>
          <string>x86_64</string>
        </values>
      </hudson.matrix.LabelExpAxis>
    </axes>
    <executionStrategy class="hudson.matrix.DefaultMatrixExecutionStrategyImpl">
      <runSequentially>false</runSequentially>
    </executionStrategy>
    </matrix-project>
```

<h2 style="post-title">If anyone is out there reading this and can spot the error, please help us out !</h2>

# We goofed - might as well publish a relase...

So - we goofed ! CODE-RADE won't be building anything for a few days, while we get this sorted out. The important thing is to learn some lessons :

  1. First publish a release, then upgrade your build server
  1. Upgrade jenkins and the plugins separately
  1. Upgrade plugins one by one
  1. Maintain a roll-back strategy in case of Bad Things like this.

<figure>
<img src="http://i.giphy.com/J1Pxgh8d7TOM0.gif"></img>
<figcaption>Oh well. It's still Friday though...</figcaption>
</figure>

So, we'll be publishing [Foundation Release 1](https://github.com/AAROC/CODE-RADE/milestones/Infrastructure%20foundation%20release%201) _as is_. Warts and all. What's in there will be in there, what's missing will come in [Foundation Release 2](https://github.com/AAROC/CODE-RADE/milestones/Infrastructure%20foundation%20release%202), scheduled for ***November 13 2015***. There should also be a first [Public Release](https://github.com/AAROC/CODE-RADE/milestones/CODE-RADE%20Public%20Release%201) on ***October 31 2015***.


# Then, Github died

Ok, so builds weren't triggered... we needed to fix this and fast ! But this morning, we got another surprise :

<figure>
<img src="{{ site_url }}/images/githubapidown-10-2015.png"></img>
<figcaption>The well-known step function. Decidedly sub-optimal.</figcaption>
</figure>



<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">We&#39;re experiencing issues delivering webhooks to a small number of hosts as we mitigate a DDoS attack.</p>&mdash; GitHub Status (@githubstatus) <a href="https://twitter.com/githubstatus/status/657537434889097216">October 23, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Sigh. Your pain is our pain @github

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">hang in there <a href="https://twitter.com/github">@github</a> - don&#39;t know what we&#39;d do without you ! <a href="https://t.co/zWrPquMWUl">https://t.co/zWrPquMWUl</a></p>&mdash; SAGrid (@TheSAGrid) <a href="https://twitter.com/TheSAGrid/status/657544622323990528">October 23, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


# Footnotes and References

[^Configs]: The job configurations are kept in xml format in `$JENKINSHOME/jobs`. These are kept in source control (actually a private Github Repository) - so it could not really have been such a huge disaster.
[^HumanIntervention]: Ok, sometimes we humans intervene and trigger jobs, but ***only if they've been very naughty !***
