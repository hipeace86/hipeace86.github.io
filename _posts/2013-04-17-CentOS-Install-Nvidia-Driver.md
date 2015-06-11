---
layout: post
title:  CentOS安装NVIDIA显卡驱动
date:   2013-04-17 23:31:06
categories: CentOS
tags: 折腾
---

CentOS不像ubuntu那样省事，很多驱动ubuntu是自动安装的
刚换的机器装了CentOS结果显卡驱动安装不了，出现



`ERROR: You appear to be running an X server; please exit X before            
         installing.  For further details, please see the section INSTALLING   
         THE NVIDIA DRIVER in the README available on the Linux driver         
         download page at www.nvidia.com.`


错误 直接修改/etc/inittab下把5改成了3然后重启安装也一样有这个错误

后来找到解决办法，原来是与系统自带的2D驱动冲突
要做以下修改

{% highlight bash linenos%}
vi /etc/modprobe.d/blacklist.conf
#添加
blacklist nouveau
{% endhighlight %}


还有上面提到的/etc/inittab 中 id:5:initdefault: 修改为 id:3:initdefault:
重新制作启动镜像

{% highlight bash linenos%}
mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak
dracut -v /boot/initramfs-$(uname -r).img $(uname -r)
{% endhighlight %}


重启以root登陆
再次安装驱动则成功
将/etc/inittab中的3改成5 重启系统

ok啦 驱动安装成功
