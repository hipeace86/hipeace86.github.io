---
layout: post
title:  升级centos上的node到最新版本
date:   2016-01-14 15:44:06
categories: NodeJs
tags: NodeJs
---

现在centos下面即使使用了epel的源，也不能把node更新到最新版本


最近几次的项目生成老是会出现各种错误，查了下是和node的版本有关系


找到一个安装node最新版本的方法，也不用自己去手动编译了，在这做下记录

{% highlight bash %}
npm cache clean -f
npm install -g n
n stable
node -v
{% endhighlight %}

好了，重新试下吧，运行npm install的时候熟悉的进度条出现了
