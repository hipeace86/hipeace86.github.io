---
layout: post
title:  "CentOS6 编译安装pypy"
date:   2016-12-05 15:31:49
categories: Python pypy
tags: pypy Python
---

据说pypy性能要比python高很多，刚好手上的项目目前存在很大性能问题，就体验一下pypy看看

记录下安装过程

下载源码，安装依赖包
{% highlight bash %}
wget https://bitbucket.org/pypy/pypy/downloads/pypy2-v5.6.0-src.tar.bz2
yum install gcc make libffi-devel pkgconfig zlib-devel bzip2-devel \
lib-sqlite3-devel ncurses-devel expat-devel openssl-devel tk-devel \
gdbm-devel \
xz-devel  # For lzma on PyPy3.
{% endhighlight %}
解压源码包，开始编译
{% highlight bash %}
tar jxvf pypy2-v5.6.0-src.tar.bz2
cd pypy2-v5.6.0-src/pypy/goal
python2.7 ../../rpython/bin/rpython -Ojit targetpypystandalone
{% endhighlight %}
机器还没有安装pypy就只能用python来跑了，不过这个就是慢 [官方文档]  有说明


漫长等待后出现如下内容，则会在当前的编译目录生成一个pypy－c的文件
{% highlight bash %}

[Timer] Timings:
[Timer] annotate                       ---  467.9 s
[Timer] rtype_lltype                   ---  991.9 s
[Timer] pyjitpl_lltype                 --- 1546.3 s
[Timer] backendopt_lltype              ---  344.0 s
[Timer] stackcheckinsertion_lltype     ---  718.3 s
[Timer] database_c                     ---  580.3 s
[Timer] source_c                       ---  410.2 s
[Timer] compile_c                      ---  595.9 s
[Timer] build_cffi_imports             ---    5.2 s
[Timer] ===========================================
[Timer] Total:                         --- 5660.0 s

{% endhighlight %}

运行则能看到如下信息则编译完成
{% highlight bash %}
./pypy-c
Python 2.7.12 (aff251e543859ce4508159dd9f1a82a2f553de00, Dec 05 2016, 05:05:33)
[PyPy 5.6.0 with GCC 4.4.7 20120313 (Red Hat 4.4.7-17)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
{% endhighlight %}


[官方文档]: http://doc.pypy.org/en/latest/build.html
