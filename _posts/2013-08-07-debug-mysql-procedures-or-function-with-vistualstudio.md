---
layout: post
title:  visual studio 调试mysql的存储过程、函数
date:   2013-08-07 11:31:06
categories: Mysql
tags: 折腾
---


不管写什么程序都少不了调试
mysql的存储过程调试还真是有些麻烦，平常使用的管理工具sqlyog也支持调试功能
后来找到了使用visual studio调试的方法，也不写具体的使用方法和截图了，具体的请看

http://dev.mysql.com/doc/refman/5.0/en/connector-net-visual-studio-debugger.html

说下使用过程出现的一个问题；服务端是在centos上；按上面方法调试时出现了 

table server side debugger.debug scope doesn’t exist 错误

原来是服务端没有设置表名区分大小写造成的
只要在my.cnf的mysqld区间加入

{% highlight mysql %}
lower_case_table_names=1
{% endhighlight %}
然后重启mysql 即可
