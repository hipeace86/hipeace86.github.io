---
layout: post
title:  "Mysql5.7密码过期问题分析"
date:   2017-01-06 08:59:49
categories: Mysql
tags: 折腾
---

一大早就碰到了这个坑，线上一个系统登陆报错

{% highlight bash %}
 Your password has expired. To log in you must change it using a client that supports expired passwords.
{% endhighlight %}
由于没有暴出mysql的  `ERROR 1862 (HY000)` 错误头，我以为是业务系统中加入了密码规则，就开始了一路折腾

# 0x01 看业务系统源码

系统是php来写的，还好本人之前也做过php的开发看这个代码完全没有问题（站点为thinkphp编写）

* 查看web配置，找到站点目录
* 找到对应controller文件看处理逻辑
* 找到对应utils包看登陆判断

然而没有发现有密码策略问题，就想着是不是还有其它代码做了处理没有找到。想着先去看看数据库查查数据表中有没有相关字段。

接下来用管理工具连接mysql，发现了问题所在，客户端连接时也报了相同的错误。由此判定错误是由于mysql帐号过期导致

# 0x02 解决方法

既然当前帐号无法登陆了，就想着去服务器上用root用户登陆，结果同样悲剧了。无法登陆就不能修改密码，先想办法登陆到数据库

* 修改数据库不验证帐号

修改/etc/my.cnf配置，并重启mysql
{% highlight bash %}
[mysqld]
skip-grant-tables
{% endhighlight %}

* 修改帐号不过期

{% highlight bash %}
> update user set password_expired='N' where user='root';
> flush privileges;
> quit
{% endhighlight %}

去掉my.cnf里的配置，重启mysql，再次登陆就没有问题了

# 0x03 总结

* 一定要多看changelog,上次有个数据表大小写的问题的坑就已经掉进去过一次了
* 软件升级记录要做好记录，就像这次如果我不知道系统跑的是5.7的sql估计也不会这么快定位到
