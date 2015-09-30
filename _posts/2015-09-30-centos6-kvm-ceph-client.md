---
layout: post
title: CentOS6中kvm与ceph集成之添加rbd模块
date:   2015-09-30 09:20:06
categories: 虚拟化
tags: 虚拟化
---


# 添加elrepo源用于安装新的kernel

{% highlight bash %}
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-6-6.el6.elrepo.noarch.rpm

yum --enablerepo=elrepo-kernel install kernel-ml # will install 3.11.latest,stable, mainline
# or
yum --enablerepo=elrepo-kernel install kernel-lt # will install 3.0.latest, long term supported

{% endhighlight %}

# 安装有rbd支持的kvm软件包

{% highlight bash %}
wget http://ceph.com/packages/ceph-extras/rpm/rhel6/x86_64/qemu-kvm-0.12.1.2-2.355.el6.2.cuttlefish.x86_64.rpm
wget http://ceph.com/packages/ceph-extras/rpm/rhel6/x86_64/qemu-img-0.12.1.2-2.355.el6.2.cuttlefish.x86_64.rpm
wget http://ceph.com/packages/ceph-extras/rpm/rhel6/x86_64/qemu-kvm-tools-0.12.1.2-2.355.el6.2.cuttlefish.x86_64.rpm

rpm -e --nodeps qemu-img
rpm -e --nodeps qemu-kvm
rpm -e --nodeps qemu-kvm-tools
rpm -Uvh qemu-*
{% endhighlight %}

# 安装ceph

{% highlight bash%}
rpm --import 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc'
rpm -Uvh http://ceph.com/rpm-dumpling/el6/noarch/ceph-release-1-0.el6.noarch.rpm
yum install ceph
{% endhighlight %}
