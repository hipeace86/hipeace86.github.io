---
layout: post
title:  nginx日志切割脚本
date:   2015-11-17 13:50:06
categories: Python
tags: Python
---

之前的日志切割是用shell来写的，不过只是针对一个主站的日志，现在想把所有日志做一处理。

写起shell来真是太麻烦了，随写了如下脚本，留个记录！


{% highlight python%}
# -*- coding: utf-8 -*-
#!/usr/bin/env python
# author:hipeace86
# nginx 日志切割脚本
# www.a.com.log  www.a.com-YesterDay(%Y-%m-%d).log

import os
import datetime

LogPath = "/data/logs/nginx" #日志所在目录
BakDir = "/data/logs/nginx/bak" #要备份到的目录
YesterDay = (datetime.datetime.now()+datetime.timedelta(days=-1)).strftime("%Y-%m-%d")
if os.path.exists(BakDir):
    pass
else:
    os.mkdir(BakDir)

for root,dirs,files in os.walk(LogPath):
    for f in files:
        filename,ext = os.path.splitext(f)
        os.rename("{0}{1}".format(root,f),"{0}{1}-{2}{3}".format(root,filename,YesterDay,ext))

os.system("kill -USR1 'cat /usr/local/openresty/nginx/logs/nginx.pid'")
time.sleep(5)
os.system('find {0} -type f -name "*.log" -mtime +7 -exec rm -rf {} \;'.foramt(BakDir))

{% endhighlight %}

只需要改下日志路径，加入到crontab里计划执行就好了
