---
layout: post
title:  centos下安装最新的google-chrome浏览器
date:   2013-08-14 09:35:09
categories: CentOS Chrome
tags: 折腾
---


 最新的google-chrome浏览器默认不在centos6.X中支持了
不过对于拥有更新强迫症的人来说真是一个大问题
网上找到一教程 [原地址]
很简单的就做完处理了


* 创建 /etc/yum.repos.d/google-chrome.repo 文件 并加入 如下内容

{% highlight bash %}

[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub

{% endhighlight %}

* 执行下列命令

{% highlight bash %}

wget http://chrome.richardlloyd.org.uk/install_chrome.sh
chmod u+x install_chrome.sh
./install_chrome.sh

{% endhighlight %}

直接就安装了，不过要注意下载文件时使用了appspot的内容，大家懂的


[原地址]: http://www.tecmint.com/install-google-chrome-on-redhat-centos-fedora-linux/

