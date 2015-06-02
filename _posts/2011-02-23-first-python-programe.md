---
layout: post
title:  "Python 处女作"
date:   2011-02-23 22:21:49
categories: Python
tags: Python
---

其实python我也是刚开始接触，完全自学，先发一个第一次因为要做一个大量图片处理的程序，在服务器上（ubuntu）写的一个脚本


{% highlight python %}
#file copy
# version 1.0
import hashlib
import os
import shutil

def movefile(path):
    L = os.listdir(path)
    for s in L:
        if os.path.isdir(path + '/' + s):
            movefile(path + '/' + s)
        else:
            a, b = os.path.splitext(s)
            dst = md5(a[0:2]) + '/' + md5(a[2:4]) + '/' + md5(a) + b
            copyfile(path + '/' + s, '/home/server/img/' + dst)

def md5(s):
    m = hashlib.md5()
    m.update(s)
    return m.hexdigest()

def copyfile(src, dst):
    d = os.path.dirname(dst)
    if os.path.exists(d):
        shutil.copyfile(src, dst)
        print "copy %s successful" % (src)
    else:
        os.makedirs(d)
        shutil.copyfile(src, dst)
        print "copy %s successful" % (src)

movefile('/home/server/20')

{% endhighlight %}
