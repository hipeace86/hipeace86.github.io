---
layout: post
title:  CentOS 编译安装python2.7
date:   2013-04-16 21:47:06
categories: CentOS Python
tags: Python
---

安装过程

{% highlight bash %}
yum groupinstall "Development tools"
yum install zlib-devel libxml2-devel libxslt-devel openssl openssl-devel sqlite-devel
wget http://www.python.org/ftp/python/2.7.3/Python-2.7.3.tgz
tar xf Python-2.7.3.tgz
cd Python-2.7.3
./configure --prefix=/usr/local
make && make altinstall
{% endhighlight%}

多个版本的python共存，建议使用virtualenv来管理项目，指定使用哪个版本的python
