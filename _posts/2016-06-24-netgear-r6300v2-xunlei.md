---
layout: post
title:  "网件r6300v2配置迅雷的远程下载"
date:   2016-06-24 11:56:49
categories: 折腾
tags: 折腾
---

最近又入手一个netgear r6300v2的路由，当然是二手货，不过只要性能好不太关心外观

毕竟到手才268，京东上看了下卖699


卖家帮忙刷好了Merlin系统，这个我还没玩过，就没敢自己折腾了，还是刷好拿来用放心

看到迅雷离线的功能，虽然我也不怎么用它下载东西，不过拿来试试感觉不错

# 0x00


  * Merlin 系统直接装好的，不用做任何改动
  * web进入路由器在系统设置里把

        Enable JFFS custom scripts and configs

        Enable SSH

     都打开（我之前配置了SS所以JFFS本来就是打开的）
  * USB设备连上
  * 进入Software Center安装迅雷远程

系统默认就把软件安装到了USB设备上，也挂载好了

# 0x01

   * 准备一个ssh终端软件 xshell、putty、SecureCRT、Linux终端等都可以

   {% highlight bash%}
   ssh admin@192.168.1.1 #默认的路由器帐号和地址，输入自己的密码
   {% endhighlight %}
   * 进入到安装目录启动服务拿到激活码

   {% highlight bash%}
    /tmp/mnt/______U__/Merlin_software/xunlei# ./portal
    initing...
    try stopping xunlei service first...
    killall: ETMDaemon: no process killed
    killall: EmbedThunderManager: no process killed
    killall: vod_httpserver: no process killed
    setting xunlei runtime env...
    port: 9000 is usable.

    YOUR CONTROL PORT IS: 9000

    starting xunlei service...
    etm path: /tmp/mnt/______U__/Merlin_software/xunlei
    execv: /tmp/mnt/______U__/Merlin_software/xunlei/lib/ETMDaemon.

        getting xunlei service info...
    Connecting to 127.0.0.1:9000 (127.0.0.1:9000)
    the license is not passed now.

    try again...(has tried 1 time(s)).
    getting xunlei service info...
    Connecting to 127.0.0.1:9000 (127.0.0.1:9000)

    THE ACTIVE CODE IS: xxxxxx #这个就是激活码

    go to http://yuancheng.xunlei.com, bind your device with the active code.
    finished.
   {% endhighlight %}

   进入到迅雷远程页面进行设备绑定

   * 绑定完成后检查是否成功，先关闭服务

   {% highlight bash%}
    /tmp/mnt/______U__/Merlin_software/xunlei# ./portal -s
    initing...
    service is stopped.
   {% endhighlight %}

   * 再次启动用力将会显示已经绑定的用户名

   {% highlight bash%}
    /tmp/mnt/______U__/Merlin_software/xunlei# ./portal
    initing...
    try stopping xunlei service first...
    killall: ETMDaemon: no process killed
    killall: EmbedThunderManager: no process killed
    killall: vod_httpserver: no process killed
    setting xunlei runtime env...
    port: 9000 is usable.

    YOUR CONTROL PORT IS: 9000

    starting xunlei service...
    etm path: /tmp/mnt/______U__/Merlin_software/xunlei
    execv: /tmp/mnt/______U__/Merlin_software/xunlei/lib/ETMDaemon.

    getting xunlei service info...
    Connecting to 127.0.0.1:9000 (127.0.0.1:9000)

    THIS DEVICE HAS BOUND TO USER: XXX. #你的迅雷昵称

    finished.
   {% endhighlight %}

# 0x02

* 在远程页面添加任务，去路由器上的USB设备检查吧  默认会下载到 */tmp/mnt/______U__/TDDOWNLOAD* 目录下
* 还可以把它进行samba共享，或者是ftp
