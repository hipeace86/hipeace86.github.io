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
<v t="Tech.20150529220531.2" a="E"><vh>2015</vh>
<v t="office.20150611132001.4"><vh>@nosent _2015-06-11-export-openstack-with-ceph-rbd-file-into-file.md</vh></v>
<v t="office.20150611132001.2"><vh>@nosent 2015-06-11-mesosphere-single-node-install-centos6.md</vh></v>
<v t="Tech.20150529220531.3"><vh>@nosent  2015-05-29-install-openstack-on-ubuntu.md</vh></v>
</v>
<v t="Tech.20150529220531.10" a="E"><vh>2014</vh>
<v t="Tech.20150529220531.11"><vh>@nosent 2014-10-20-virtualbox-install-openstack.md</vh></v>
<v t="Tech.20150529220531.12"><vh>@nosent 2014-08-21-backbone-first-programing.md</vh></v>
<v t="Tech.20150529220531.13"><vh>@nosent 2014-07-07-Intelligent-Router-With-openwrt-and-openvpn.md</vh></v>
</v>
<v t="Tech.20150610215432.2" a="E"><vh>2013</vh>
<v t="Tech.20150610215432.3"><vh>@nosent 2013-12-31-Install-OpenVpn-Server-On-CentOS.md</vh></v>
<v t="Tech.20150610215432.4"><vh>@nosent 2013-09-18-openresty-install-luarocks.md</vh></v>
<v t="Tech.20150610215432.5"><vh>@nosent 2013-09-12-variable-in-tornado-template-file.md</vh></v>
<v t="Tech.20150610215432.6"><vh>@nosent 2013-08-14-install-latest-chrome-on-centos.md</vh></v>
<v t="Tech.20150611213700.2"><vh>@nosent 2013-08-07-debug-mysql-procedures-or-function-with-vistualstudio.md</vh></v>
<v t="Tech.20150611213700.3"><vh>@nosent 2013-04-19-mercurial-dotencode-not-supported.md</vh></v>
<v t="Tech.20150611213700.4"><vh>@nosent 2013-04-17-CentOS-Install-Nvidia-Driver.md</vh></v>
<v t="Tech.20150611213700.5"><vh>@nosent 2013-04-16-CentOS-Compile-Install-Python27.md</vh></v>
<v t="Tech.20150702225641.3"><vh>@nosent 2013-04-02-php-compile-on-little-memory-vps.md</vh></v>
<v t="Tech.20150702225641.4"><vh>@nosent 2013-03-29-sublime-plugins.md</vh></v>
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
date:   2014-10-20 22:21:49
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

![MG_1950-300x224.jpg](http://7xjbml.com1.z0.glb.clouddn.com/IMG_1950-300x224.jpg)

        
        
        
        
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
<t tx="Tech.20150610215432.2">@others</t>
<t tx="Tech.20150610215432.3">---
layout: post
title:  "用Centos打造自己的openvpn服务器"
date:   2013-12-31 09:43:49
categories: 路由 openvpn
tags: 折腾
---


之前写过一个建立pptp服务器的文章，这次也是没有办法，新拉的铁通的光纤把vpn给封了 pptp无法连接
网上搜索了下，发现openvpn还是可以用的
就又折腾了一把

准备工作：centos 服务器一台（最好境外的，比如我现在用的这个vps）
第一步，先给服务器添加扩展源


{% highlight bash %}

wget http://dl.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm


{% endhighlight %}


我服务器还是centos 5的32位版本，其它版本就自己搜索下载
第二步，安装


{% highlight bash %}
rpm -Uvh epel-release-5-4.noarch.rpm
yum install -y openvpn
{% endhighlight %}


第三步，配置

{% highlight bash %}
cp /usr/share/doc/openvpn-2.3.2/sample/sample-config-files/server.conf /etc/openvpn/
cd /etc/openvpn
vi server.conf
{% endhighlight %}

把server.conf中的以下几行做下修改
{% highlight bash %}
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
user nobody
group nobody
{% endhighlight %}

除dns那两个需要改成自己的以外，其它只要把前面的分号去掉即可

第四步，生成keys
{% highlight bash %}
cd /tmp
wget https://github.com/downloads/OpenVPN/easy-rsa/easy-rsa-2.2.0_master.tar.gz
tar zxvf easy-rsa-2.2.0_master.tar.gz
mv /tmp/easy-rsa-2.2.0_master/easy-rsa/2.0 /etc/openvpn/easy-rsa
cd /etc/openvpn/easy-rsa
{% endhighlight %}


vars文件中的以下配置可做下修改

{% highlight bash %}
export KEY_COUNTRY="US"
export KEY_PROVINCE="NY"
export KEY_CITY="New York"
export KEY_ORG="Organization Name"
export KEY_EMAIL="administrator@example.com"
export KEY_CN=vpn.example.com
export KEY_NAME=server
export KEY_OU=server
{% endhighlight %}

生成根证书

{% highlight bash %}
source ./vars
./clean-all
./build-ca
{% endhighlight %}

生成服务端证书

{% highlight bash %}
./build-key-server server
{% endhighlight %}


生成时注意，最后两步要输入Y再回车

生成 Diffie Hellman 证书


{% highlight bash %}
./build-dh
{% endhighlight %}

把生成的证书文件拷贝到/etc/openvpn目录下


{% highlight bash %}
cp keys/{ca.crt,ca.key,server.crt,server.key,dh1024.pem} /etc/openvpn/
{% endhighlight %}


第五步，系统配置


{% highlight bash %}
vi /etc/sysctl.conf
net.ipv4.ip_forward = 1 #把此处设置为1 保存
{% endhighlight %}

iptables防火墙 配置


{% highlight bash %}
/etc/init.d/iptables stop #关闭防火墙
vi /etc/sysconfig/iptables #编辑防火墙规则文件，之前需配置了防火墙关闭时自动保存
 
#在*filter规则下加入
-A INPUT -p udp -m udp --dport 1194 -j ACCEPT
-A FORWARD -d 10.8.0.0/24 -j ACCEPT
-A FORWARD -s 10.8.0.0/24 -j ACCEPT
#在*net规则下加入
-A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
#此处如果多个网卡的，eth0需指定外网网卡的设备
 
/etc/init.d/iptables start   #启动防火墙
sysctl -p  #让之前设置的ip_forward生效
{% endhighlight %}


第六步，启动openvpn服务;并设置为开机启动


{% highlight bash %}
service openvpn start
chkconfig openvpn on
{% endhighlight %}


第七步，生成客户端证书


{% highlight bash %}
cd /etc/openvpn/easy-rsa
./build-key client
{% endhighlight %}

生成时注意，最后两步要输入Y再回车

拿着keys文件夹下的ca.crt,client.crt,clent.key用客户端就能连接了，只帖一个客户端的配置文件，不做详细说明了


{% highlight bash %}
client
remote #your remote ip
ca ca.crt
cert client.crt
key client.key
dev tun
proto udp
nobind
auth-nocache
script-security 2
persist-key
persist-tun
user openvpn
group openvpn
comp-lzo
verb 3
{% endhighlight %}


#注意指定远程ip和证书路径





















</t>
<t tx="Tech.20150610215432.4">---
layout: post
title:  "openresty 安装luarocks"
date:   2013-09-18 11:43:49
categories: OpenResty Lua
tags: 折腾 Lua
---


luarocks是一个lua包的管理工具，就像python下的pip
首页要下载源码

{% highlight bash %}
wget http://luarocks.org/releases/luarocks-2.X.X.tar.gz
{% endhighlight %}


[源码可在此下载]

{% highlight bash %}
tar -xzvf luarocks-2.X.X.tar.gz
cd luarocks-2.X.X/
 
./configure --prefix=/usr/local/openresty/luajit \
    --with-lua=/usr/local/openresty/luajit/ \
    --lua-suffix=jit \
    --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.0
make
sudo make install
{% endhighlight %}

这里我这里把它装到了openresty的目录下

使用luarocks安装扩展包

{% highlight bash %}
/usr/local/openresty/luajit/bin/luarocks install lapis
{% endhighlight %}

[Lapis] is a framework for building web applications using MoonScript (or Lua) that runs inside of a customized version of Nginx called OpenResty.



[源码可在此下载]: http://luarocks.org/releases/
[Lapis]:http://leafo.net/lapis/
</t>
<t tx="Tech.20150610215432.5">---
layout: post
title:  tornado模板中include文件名中包含变量
date:   2013-09-12 11:43:49
categories: Python Tornado
tags: Python
---


遇到了这一问题，在模板中要包含文件，不过文件名是需要变的 按开始的写法

{% highlight python %}

    {% raw %}
    {% include 'ext/node{{id}}.html' %}
   {% endraw %}
{% endhighlight %}



结果运行时报错， ext/node{{id}}.html 文件没有找到

[google group] 里找到了对应的方案
使用


{% highlight python %}

{% raw %}
{% module Template('ext/node'+id+".html") %}
{% endraw %}

{% endhighlight %}


替代
不过要注意，在使用module Template时，如果模板中使用到了变量，此处调用时也要把变量传进去 例如


{% highlight python %}

{% raw %}
    {% module Template('ext/node'+id+".html",id=id) %}


{% endraw %}

{% endhighlight %}



[google group]: https://groups.google.com/forum/#!topic/python-tornado/JQFs3Z6JTXw

</t>
<t tx="Tech.20150610215432.6">---
layout: post
title:  centos下安装最新的google-chrome浏览器
date:   2013-08-14 09:35:09
categories: CentOS Chrome
tags: 折腾
---


 最新的google-chrome浏览器默认不在centos6.X中支持了
不过对于拥有更新强迫症的人来说真是一个大问题
网上找到一教程 [原地址]
很简单的就做完处理了


* 创建 /etc/yum.repos.d/google-chrome.repo 文件 并加入 如下内容

{% highlight bash %}

[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub

{% endhighlight %}

* 执行下列命令

{% highlight bash %}

wget http://chrome.richardlloyd.org.uk/install_chrome.sh
chmod u+x install_chrome.sh
./install_chrome.sh

{% endhighlight %}

直接就安装了，不过要注意下载文件时使用了appspot的内容，大家懂的


[原地址]: http://www.tecmint.com/install-google-chrome-on-redhat-centos-fedora-linux/

</t>
<t tx="Tech.20150611213700.2">---
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
然后重启mysql 即可</t>
<t tx="Tech.20150611213700.3">---
layout: post
title:  "Centos mercurial abort: requirement 'dotencode' not supported!错误解决办法"
date:   2013-04-19 12:33:06
categories: mercurial hg
tags: 折腾
---

换上centos安装mercurial后在同步项目时出现了abort: requirement ‘dotencode’ not supported! 错误
查询原来是版本过底访问高版本创建的仓库所造成的

没有最新的mercurial源 只能编译安装了

下载源码 http://mercurial.selenic.com/release/mercurial-2.5.4.tar.gz

安装python-devel python-docutils
进入解压后的目录
{% highlight  bash%}
make all
make install
{% endhighlight%}

hg 已安装成功

默认安装到了/usr/local/bin下面
普通用户不能访问 local下创建一个软连 

{%highlight bash %}
ln -s /usr/local/bin/hg /usr/bin/
{% endhighlight %}</t>
<t tx="Tech.20150611213700.4">---
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

ok啦 驱动安装成功</t>
<t tx="Tech.20150611213700.5">---
layout: post
title:  CentOS 编译安装python2.7
date:   2013-04-16 21:47:06
categories: CentOS Python
tags: Python
---

安装过程

{% highlight bash %}
yum groupinstall "Development tools"
yum install zlib-devel
yum install libxml2-devel libxslt-devel
wget http://www.python.org/ftp/python/2.7.3/Python-2.7.3.tgz
tar xf Python-2.7.3.tgz 
cd Python-2.7.3
./configure --prefix=/usr/local
make &amp;&amp; make altinstall
{% endhighlight%}

多个版本的python共存，建议使用virtualenv来管理项目，指定使用哪个版本的python</t>
<t tx="Tech.20150702225641.3">---
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

</t>
<t tx="Tech.20150702225641.4">---
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

{% endhighlight %}</t>
<t tx="office.20150529181219.1"></t>
<t tx="office.20150529181219.2">@path _posts
@language rest</t>
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
<t tx="office.20150611132001.2">---
layout: post
title:  centos6单节点安装mesosphere
date:   2015-06-11 13:25:18
categories: mesosphere
tags: 折腾
---


* 添加源

    
{% highlight bash %}
rpm -Uvh http://repos.mesosphere.io/el/6/noarch/RPMS/mesosphere-el-repo-6-2.noarch.rpm
{% endhighlight %}

* 安装软件

    
{% highlight bash %}
yum -y install mesos marathon
{% endhighlight %}

* 如果没有安装zookeeper，则执行如下命令

{% highlight bash %}
rpm -Uvh http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
yum -y install zookeeper
zookeeper-server-initialize --myid=1
{% endhighlight %}

* 启动服务

{% highlight bash %}
zookeeper-server start

service mesos-master start
service mesos-slave start
service marathon start

{% endhighlight %}
</t>
<t tx="office.20150611132001.4">---
layout: post
title:  将ceph中的openstack虚拟机导出为镜像
date:   2015-06-11 20:17:58
categories: openstack ceph
tags: 虚拟化
---

准备中</t>
</tnodes>
</leo_file>
