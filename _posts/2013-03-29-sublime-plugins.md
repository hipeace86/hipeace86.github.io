---
layout: post
title: 常用sublime插件  
date:   2013-03-29 09:23:06
categories: Editor
tags: 折腾
---


最近工作用的机器出了问题，只能用一根内存条了，还要开上虚拟机 做开发时使用netbeans 或者是eclipse真就悲剧了
内存不足啊


看到sublime这个东西试用了一下，不得不说它是一个很好用的编辑器，强大的插件支持，数量居多的快捷键，主要是内存占用少，就它了
记录几个我所用的插件


插件的安装推荐先装上package control
在编辑器中按下ctrl+` 在 console窗口输入

{% highlight python %}

import urllib2,os;pf='Package Control.sublime-package';ipp=sublime.installed_packages_path();os.makedirs(ipp) if not os.path.exists(ipp) else None;open(os.path.join(ipp,pf),'wb').write(urllib2.urlopen('http://sublime.wbond.net/'+pf.replace(' ','%20')).read())

{% endhighlight %}


回车 重启sublime
列下我所安装的插件 (ctrl+shift+p输入list package回车)

{% highlight  shell%}

Indent Guides
jquery sinppets pack
jsformat
markdown preview
sftp
tag
tagwrapper
zen coding
theme soda
sidebarenhancements

{% endhighlight %}
