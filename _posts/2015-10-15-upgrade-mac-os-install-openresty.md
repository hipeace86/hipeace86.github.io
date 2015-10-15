---
layout: post
title:  新更新的mac系统无法编译安装OpenResty
date:   2015-10-15 23:35:06
categories: OpenResty Lua
tags: 折腾 Lua
---

{%highlight python%}

/configure: error: SSL modules require the OpenSSL library.
You can either do not enable the modules, or install the OpenSSL library
into the system, or build the OpenSSL library statically from the source
with nginx by using --with-openssl=<path> option.

ERROR: failed to run command: sh ./configure
--prefix=/usr/local/openresty/nginx \...

{% endhighlight %}

# 坑的是这个openssl的依赖并不是使用已经安装的路径，而是源码


下载最新代码


    ftp://ftp.openssl.org/source/openssl-1.0.2d.tar.gz

    
    解压到bundler目录


声明下变量

{%highlight bash%}
export KERNEL_BITS=64
{%endhighlight%}

不然会出如下错误

{%highlight bash%}

ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
{%endhighlight%}

## 再次编译安装

{%highlight bash%}
./configure --with-cc-opt='-I/usr/local/Cellar/pcre/8.37/include/' \
       --with-ld-opt='-L/usr/local/Cellar/pcre/8.37/lib' \
       --with-openssl=bundle/openssl-1.0.2d -j2
make
make install
{%endhighlight%}

安装成功
