---
layout: post
title:  64位小内存机器php编译出现apprentice.lo 错误
date:   2013-04-02 23:19:06
categories: PHP
tags: 折腾
---

呵呵，感觉这个博客老是写些php的东西
与初衷不太一样，本来弄这个域名是想多记录python学习的
不过没有办法，目前还是做php居多 手上在写一个python的项目呢，基于tornado
以后有时间了会把写这个项目中遇到的问题做一个总结


先说说这个php的安装，以前也编译过几次，不过都是在至少8G以上的服务器上
而这次是买了个[阿里云主机](http://www.aliyun.com/cps/rebate?from_uid=8H7MkzZJ8S3Vw7FJ1pC+/4DdnhBD4gGL)
内存只有512M，跑些小东西是足够了


在编译php时遇到的这个错误，最后在[https://bugs.php.net/bug.php?id=48809](https://bugs.php.net/bug.php?id=48809)上查到了原因
原来是内存小导致的 解决办法很简单 编译选项加上 * –disable-fileinfo * 即可

