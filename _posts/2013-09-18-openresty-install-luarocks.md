---
layout: post
title:  "openresty 安装luarocks"
date:   2013-09-18 11:43:49
categories: OpenResty Lua
tags: 折腾 Lua
---


luarocks是一个lua包的管理工具，就像python下的pip
首页要下载源码

{% highlight bash %}
wget http://luarocks.org/releases/luarocks-2.X.X.tar.gz
{% endhighlight %}


[源码可在此下载]

{% highlight bash %}
tar -xzvf luarocks-2.X.X.tar.gz
cd luarocks-2.X.X/
 
./configure --prefix=/usr/local/openresty/luajit \
    --with-lua=/usr/local/openresty/luajit/ \
    --lua-suffix=jit \
    --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.0
make
sudo make install
{% endhighlight %}

这里我这里把它装到了openresty的目录下

使用luarocks安装扩展包

{% highlight bash %}
/usr/local/openresty/luajit/bin/luarocks install lapis
{% endhighlight %}

[Lapis] is a framework for building web applications using MoonScript (or Lua) that runs inside of a customized version of Nginx called OpenResty.



[源码可在此下载]: http://luarocks.org/releases/
[Lapis]:http://leafo.net/lapis/
