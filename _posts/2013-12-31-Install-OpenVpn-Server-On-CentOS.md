---
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





















