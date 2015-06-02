---
layout: post
title:  "virtualbox单网卡安装OpenStack"
date:   2015-03-08 22:21:49
categories: OpenStack
tags: 虚拟化
---


# 修改源


{% highlight bash %}

rpm -Uvh  http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh  http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm 
yum install -y http://rdo.fedorapeople.org/openstack-havana/rdo-release-havana.rpm
yum update -y


{% endhighlight %}


# 编辑 /etc/selinux/config 文件

{% highlight bash %}

SELINUX=disabled

{% endhighlight %}
此处应该重启服务器

{% highlight bash %}

yum install -y openstack-packstack python-netaddr
packstack --allinone --provision-all-in-one-ovs-bridge=n


{% endhighlight %}

看起来还是很简单的，不过安装过程中会出现各种的错误，基本上都是源地址下载太慢超时造成的
这种情况就只能多试几次，或者是科学上网解决了

如果出现问题可以使用


{% highlight bash %}

packstack --answer-file /root/packstack-answers-**.txt #将＊＊替换为实际的名称

{% endhighlight %}

来继续安装
