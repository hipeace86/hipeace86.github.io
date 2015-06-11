---
layout: post
title:  centos6单节点安装mesosphere
date:   2015-06-11 13:25:18
categories: mesosphere
tags: 折腾
---


* 添加源

    
{% highlight bash %}
rpm -Uvh http://repos.mesosphere.io/el/6/noarch/RPMS/mesosphere-el-repo-6-2.noarch.rpm
{% endhighlight %}

* 安装软件

    
{% highlight bash %}
yum -y install mesos marathon
{% endhighlight %}

* 如果没有安装zookeeper，则执行如下命令

{% highlight bash %}
rpm -Uvh http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
yum -y install zookeeper
zookeeper-server-initialize --myid=1
{% endhighlight %}

* 启动服务

{% highlight bash %}
zookeeper-server start

service mesos-master start
service mesos-slave start
service marathon start

{% endhighlight %}
