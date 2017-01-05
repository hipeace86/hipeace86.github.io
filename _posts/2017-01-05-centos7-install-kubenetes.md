---
layout: post
title:  centos7下安装kubenetes
date:   2017-01-05 23:37:28
categories: Docker
tags: Docker
---


# 0x01 准备工作

* 关闭selinux `//` 添加软件源 `//`安装软件

{%highlight bash%}

sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://yum.kubernetes.io/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
setenforce 0
yum install -y docker kubelet kubeadm kubectl kubernetes-cni
systemctl enable docker && systemctl start docker
systemctl enable kubelet && systemctl start kubelet

{% endhighlight %}
# 0x02 初始化master节点
{%highlight shell%}
kubeadm init
#会有类似如下输出
<master/tokens> generated token: "3e7558.c05114b4bf698a2b"
<master/pki> created keys and certificates in "/etc/kubernetes/pki"
<util/kubeconfig> created "/etc/kubernetes/kubelet.conf"
<util/kubeconfig> created "/etc/kubernetes/admin.conf"
<master/apiclient> created API client configuration
<master/apiclient> created API client, waiting for the control plane to become ready
<master/apiclient> all control plane components are healthy after 167.608164 seconds
<master/apiclient> waiting for at least one node to register and become ready
{% endhighlight %}
# 0x03 添加node
{%highlight shell%}
kubeadm join --token=<token> <master-ip>
{% endhighlight %}
此处token为上面一步初始化时输出的值，master-ip为主节点IP


# 0x04 注意


* 直接yum安装还是很简单的，要注意关闭下selinux
* 注意防火墙规则
