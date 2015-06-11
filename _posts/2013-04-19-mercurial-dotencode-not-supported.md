---
layout: post
title:  "Centos mercurial abort: requirement 'dotencode' not supported!错误解决办法"
date:   2013-04-19 12:33:06
categories: mercurial hg
tags: 折腾
---

换上centos安装mercurial后在同步项目时出现了abort: requirement ‘dotencode’ not supported! 错误
查询原来是版本过底访问高版本创建的仓库所造成的

没有最新的mercurial源 只能编译安装了

下载源码 http://mercurial.selenic.com/release/mercurial-2.5.4.tar.gz

安装python-devel python-docutils
进入解压后的目录
{% highlight  bash%}
make all
make install
{% endhighlight%}

hg 已安装成功

默认安装到了/usr/local/bin下面
普通用户不能访问 local下创建一个软连 

{%highlight bash %}
ln -s /usr/local/bin/hg /usr/bin/
{% endhighlight %}
