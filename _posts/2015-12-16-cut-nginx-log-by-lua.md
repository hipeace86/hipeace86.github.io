---
layout: post
title:  使用Lua脚本切割nginx日志
date:   2015-12-16 21:06:06
categories: lua
tags: lua
---


上次写的是一个用python+crontab来切割nginx日志的[脚本]

现在再加一个使用lua来切割日志，也不用kill或者reload


不过有一限制，nginx需要lua支持，或者直接安装[openresty];具体代码如下：

{% highlight lua%}
set $currentDate 'day';
access_by_lua '
    ngx.var.currentDate = os.date("%Y-%m-%d")
';
access_log /logs/app.access.$currentDate.log app_log;
{% endhighlight%}

利益于ngx.var可以和nginx配置中声明的变量能够共享！


[openresty]: http://openresty.org
[脚本]: /python/2015/11/17/ngx-cut-log.html
