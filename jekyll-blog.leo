<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: http://leoeditor.com/leo_toc.html -->
<?xml-stylesheet ekr_test?>
<leo_file xmlns:leo="http://leoeditor.com/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="office.20150529181219.1" a="E"><vh>jekyll-blog.leo</vh>
<v t="office.20150529181219.2" a="E"><vh>_posts</vh>
<v t="office.20150529181219.3"><vh>@nosent 2015-03-08-welcome-to-jekyll.markdown</vh></v>
<v t="Tech.20150529220531.2" a="E"><vh>2015</vh>
<v t="Tech.20150529220531.3"><vh>@nosent  2015-05-29-install-openstack-on-ubuntu.md</vh></v>
</v>
<v t="Tech.20150529220531.10" a="E"><vh>2014</vh>
<v t="Tech.20150529220531.12"><vh>@nosent 2014-08-21-backbone-first-programing.md</vh></v>
<v t="Tech.20150529220531.11"><vh>@nosent 2014-07-08-virtualbox-install-openstack.md</vh></v>
<v t="Tech.20150529220531.13"><vh>@nosent 2014-07-07-Intelligent-Router-With-openwrt-and-openvpn.md</vh></v>
</v>
<v t="office.20150529181219.4" a="E"><vh>2011</vh>
<v t="office.20150529181219.5"><vh>@nosent 2011-02-23-first-python-programe.md</vh></v>
</v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="Tech.20150529220531.10">@others</t>
<t tx="Tech.20150529220531.11">---
layout: post
title:  "virtualbox单网卡安装OpenStack"
date:   2015-03-08 22:21:49
categories: OpenStack
tags: 虚拟化
---


# 修改源


{% highlight bash %}

rpm -Uvh  http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh  http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm 
yum install -y http://rdo.fedorapeople.org/openstack-havana/rdo-release-havana.rpm
yum update -y


{% endhighlight %}


# 编辑 /etc/selinux/config 文件

{% highlight bash %}

SELINUX=disabled

{% endhighlight %}
此处应该重启服务器

{% highlight bash %}

yum install -y openstack-packstack python-netaddr
packstack --allinone --provision-all-in-one-ovs-bridge=n


{% endhighlight %}

看起来还是很简单的，不过安装过程中会出现各种的错误，基本上都是源地址下载太慢超时造成的
这种情况就只能多试几次，或者是科学上网解决了

如果出现问题可以使用


{% highlight bash %}

packstack --answer-file /root/packstack-answers-**.txt #将＊＊替换为实际的名称

{% endhighlight %}

来继续安装
</t>
<t tx="Tech.20150529220531.12">---
layout: post
title:  "初试Backbone.Js"
date:   2014-08-21 22:21:49
categories: javascript
tags: 折腾
---


开发需求，打算使用backbone来做一个手机端的网页，后续还会做一个web应用，也会有更多的交互处理
就研究了下backbone这个东东

后来发现要按需加载，随后又玩了下requirejs,以发现npm这个好东西，接着发现了bower包。。。
这下不可收拾，使用bower搭建了一个requirejs、backbone、underscore、zepto的环境
又使用r.js来压缩；做了个基本的结构放到了 [Bitbucket]上

使用很简单，下载该版本库，如果安装好了bower，在下载的文件夹中执行下 bower install 即可

后来在使用过程中又加入了text库，用来加载模板，在r.js压缩后 能把模板、所有js文件压缩到一个文件中

减少了网页请求，增强了用户交互 很不错的选择



[Bitbucket]: https://bitbucket.org/hipeace86/bonesite</t>
<t tx="Tech.20150529220531.13">---
layout: post
title:  "openwrt+openvpn打造智能路由"
date:   2015-03-08 22:21:49
categories: 路由 openvpn
tags: 折腾
---


有关vpn的我写了几次了，包括pptp和[openvpn]上网的设置
不过前段时间看到一朋友折腾[tp-link703n]的路由，做成智能路由的,我也折腾了一把

主要是懒得折腾每个设备上的配置，现在家里网络设备有笔记本一台，苹果手机两部；而我的小本上还装了两个系统，linux下的好说，直接安装软件设置，而windows下试了几次都没能成功，只得放弃。废话不多说，入正题。

* 准备工作
703n路由器一台、U盘一个、网线一根、安装了openvpn服务器的主机一台（这个我上篇有提到）
* 给路由器刷上openwrt
这个网上有很多教程的，也很方便操作，并且好象我刷完后就带有了luci界面的，这个就不多废话了
* 路由器开启ssh
{% highlight bash %}
telnet 192.168.1.1 #连接路由
password           #修改密码
{% endhighlight%}
* 开启无线
{% highlight bash %}
vim /etc/config/wireless
{% endhighlight%}
注释掉option disabled 1一行，并设置Wifi的加密方式和密码：

{% highlight bash %}
config wifi-device  radio0
    option type     mac80211
    option channel  11
    option hwmode   11ng
    option path 'platform/ar933x_wmac'
    option htmode   HT20
    list ht_capab   SHORT-GI-20
    list ht_capab   SHORT-GI-40
    list ht_capab   RX-STBC1
    list ht_capab   DSSS_CCK-40
    # REMOVE THIS LINE TO ENABLE WIFI:
    # option disabled 1
 
config wifi-iface
    option device   radio0
    option network  lan
    option mode     ap
    option ssid     OpenWrt
    option encryption psk2
    option key  'password' #个性成自己的密码
{% endhighlight%}
* 修改网络配置

{% highlight bash %}  
vim /etc/config/network
{% endhighlight%}  
    
注释掉option ifname ‘eth0′并增加WAN口设置，

{% highlight bash %}  
config interface 'loopback'
    option ifname 'lo'
    option proto 'static'
    option ipaddr '127.0.0.1'
    option netmask '255.0.0.0'
 
config globals 'globals'
    option ula_prefix 'fd48:f746:e8a5::/48'
 
config interface 'lan'
    # option ifname 'eth0'
    option type 'bridge'
    option proto 'static'
    option ipaddr '192.168.1.1'
    option netmask '255.255.255.0'
    option ip6assign '60'
 
config interface 'wan'
    option ifname 'eth0'
    option proto 'pppoe'
    option username 'ppoeusername'  #你的拨号网络帐号
    option password 'password'      #你的帐号密码
    option peerdns '0'              #此项为不从运营商处获取dns，避免dns污染
    option dns '8.8.8.8 8.8.4.4'
{% endhighlight%}
如果是自动获取的IP，只要将option proto 设置为’dhcp’即可，将拨号的两项注释，reboot重启路由已可连接网络正常上网了

* 准备U盘

一般路由器安装完openwrt后空间都所剩不多，所以要利用路由器上的USB来扩展一个U盘；U盘要分成三个区，可根据自己在U盘大小适当调整；我用的是一个4G的，分区大小大概如下
{% highlight bash%}
sdb1 2G ext4
sdb2 1G swap
sdb3 1G ext4
{% endhighlight%}
U盘准备完后可在路由上安装软件了

* 准备软件安装

{% highlight bash %}
opkg update
opkg install kmod-usb2 kmod-fs-ext4
opkg install kmod-usb-storage
opkg install block-mount
reboot
{% endhighlight %}
设置分区挂载
{% highlight bash %}
vim /etc/config/fstab
{% endhighlight %}
设置如下
{% highlight bash %}
config 'mount'
    option  target  /mnt/usb
    option  device  /dev/sdb1
    option  fstype  ext4
    option  enabled 1
 
config 'swap'
    option  device  /dev/sdb2
    option  enabled 1
 
config 'mount'
    option  target  /mnt/home
    option  device  /dev/sdb3
    option  fstype  ext4
    option  enabled 1
{% endhighlight %}    
重启路由，就能查看到分区已经挂载了

{% highlight bash %}
reboot
df -h

Filesystem                Size      Used Available Use% Mounted on
rootfs                    1.1M    652.0K    436.0K  60% /
/dev/root                 2.0M      2.0M         0 100% /rom
tmpfs                    14.3M    704.0K     13.6M   5% /tmp
tmpfs                   512.0K         0    512.0K   0% /dev
/dev/mtdblock3            1.1M    652.0K    436.0K  60% /overlay
overlayfs:/overlay        1.1M    652.0K    436.0K  60% /
/dev/sdb1                 1.9G     72.8M      1.7G   4% /mnt/usb
/dev/sdb3               844.3M     28.0M    774.1M   3% /mnt/home
{% endhighlight %}  
接着执行如下操作：

{% highlight bash %}
mkdir /tmp/root
mount -o bind / /tmp/root
cp /tmp/root/* /mnt/usb -a
umount /tmp/root
rm -r /tmp/root  
{% endhighlight %}  

接着在opkg.conf配置中增加dest usb /mnt/usb，之后就可以将我们需要的OpenVPN安装到USB中了：
{% highlight bash %}  
vim /etc/opkg.conf
    
opkg update
opkg --dest usb install openvpn
ln -s /mnt/usb/usr/lib/libssl.so.1.0.0 /usr/lib/
ln -s /mnt/usb/usr/lib/libcrypto.so.1.0.0 /usr/lib/
ln -s /mnt/usb/usr/lib/liblzo2.so.2 /usr/lib/
ln -s /mnt/usb/usr/sbin/openvpn /usr/sbin/
{% endhighlight %}  
* 安装后配置
{% highlight bash %}  
ln -s /mnt/usb/lib/modules/3.10.4/tun.ko /lib/modules/3.10.4/
ln -s /mnt/usb/etc/modules.d/30-tun /etc/modules
ln -s /mnt/usb/etc/modules.d/30-tun /etc/modules.d/
modinfo tun
#此上为避免找不到tun模块
/etc/init.d/firewall stop
/etc/init.d/firewall disable
iptables -L -n --line-number
iptables -t nat -vnL POSTROUTING --line-number
#此上为关闭防火墙，并查看默认转发规则            
{% endhighlight %}
可以看到此时默认是没有任何转发规则的，因此此时连接到路由器的设备是无法上网的，配置路由每次上电重启时候自动加载tun模块并加入转发规则：
{% highlight bash %} 
vim /etc/rc.local
{% endhighlight %}
修改内容如下：
{% highlight bash %}
insmod tun
iptables -I FORWARD -o tun0 -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -j MASQUERADE
iptables-save
 
exit 0
{% endhighlight %}
* 正题，配置vpn客户端
我是在/mnt/usb/data/openvpn下建立了703n.ovpn的配置文件，这个路径可随自己意愿来设置；拿出[上次文章]中生成的ca.crt，client.crt,client.key三个文件也放到此文件夹下
修改703n.ovpn内容如下

{% highlight bash %}   
client
remote #remoteIP 1194 #修改成自己的服务器IP
dev tun
comp-lzo
ca /mnt/usb/data/openvpn/ca.crt
cert /mnt/usb/data/openvpn/client.crt
key /mnt/usb/data/openvpn/client.key
 
route-delay 2
route-method exe
max-routes 3888
redirect-gateway def1
verb 0      #据说如此设置就不会生成日志了，为了节省空间我也这么个性了
 
#此下三行为智能规则中添加，下文将提到
#script-security 2
#up vpnup.sh  
#down vpndown.sh


openvpn –config ./703n.ovpn
{% endhighlight %} 
到此为止，就可以连接vpn上网了，不过并不能智能转发

* 终极目标ChnRoutes
下载ChnRoutes并执行
{% highlight bash %} 
python chnroutes.py -p android
{% endhighlight%} 
会生成两个文件vpnup.sh和vpndown.sh，将这两个文件头部的alias删除;并上传到路由器中，和703n.ovpn同一目录；将703n.ovpn最后三行的注释去掉；在电脑上tracert下百度和twitter吧
* 最后一步，openvpn开机自启动

编辑/etc/rc.local
在exit0之前添加
{% highlight bash %} 
/usr/sbin/openvpn --cd /mnt/usb/data/openvpn --config 703n.ovpn --daemon
{% endhighlight %} 
至此已完全完成了智能路由的改造工作，再也不用在每个设置上配置东西了，连上wifi就能直接使用！

目前为此，我的这个小路由开机一周，openvpn一直能使用的，还是很稳定的

来张小图

![MG_1950-300x224.jpg](http://7xjbml.com1.z0.glb.clouddn.com/MG_1950-300x224.jpg)

        
        
        
        
[tp-link703n]: http://www.benben.cc/blog/?p=395
[上次文章]: </t>
<t tx="Tech.20150529220531.2">@others</t>
<t tx="Tech.20150529220531.3">---
layout: post
title:  "Ubuntu上安装OpenStack"
date:   2015-03-08 22:21:49
categories: OpenStack
tags: 虚拟化
---


准备工作</t>
<t tx="office.20150529181219.1"></t>
<t tx="office.20150529181219.2">@path _posts
@language rest</t>
<t tx="office.20150529181219.3">---
layout: post
title:  "Welcome to Jekyll!"
date:   2015-03-08 22:21:49
categories: Jekyll Update
tags: Jekyll Update
---
You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

To add new posts, simply add a file in the `_posts` directory that follows the convention `YYYY-MM-DD-name-of-post.ext` and includes the necessary front matter. Take a look at the source for this post to get an idea about how it works.

Jekyll also offers powerful support for code snippets:

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=&gt; prints 'Hi, Tom' to STDOUT.
{% endhighlight %}

Check out the [Jekyll docs][jekyll] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll’s dedicated Help repository][jekyll-help].

[jekyll]:      http://jekyllrb.com
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-help]: https://github.com/jekyll/jekyll-help
</t>
<t tx="office.20150529181219.4">@others</t>
<t tx="office.20150529181219.5">---
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

{% endhighlight %}</t>
</tnodes>
</leo_file>
