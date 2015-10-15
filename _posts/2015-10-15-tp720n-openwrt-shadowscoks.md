---
layout: post
title:  "tp-link720n安装shadowsocks+ChinaDNS"
date:   2015-10-15 18:26:49
categories: OpenWrt ShadowSocks
tags: 折腾
---


# 软件包安装


{% highlight bash%}

opkg update
opkg install ip ipset resolveip iptables-mod-tproxy resolveip libopenssl luci-i18n-base-zh-cn

reboot # 保险起见还是重启下较好
{% endhighlight %}

# 汉化包及软件包安装

{% highlight bash%}

wget https://github.com/shadowsocks/ChinaDNS/releases/download/1.3.2/ChinaDNS_1.3.2_ar71xx.ipk
wget http://openwrt-dist.sourceforge.net/releases/ar71xx/packages/shadowsocks-libev-spec_2.4.0-1_ar71xx.ipk
wget http://openwrt-dist.sourceforge.net/releases/luci/packages/luci-app-chinadns_1.3.6-1_all.ipk
wget http://openwrt-dist.sourceforge.net/releases/luci/packages/luci-app-shadowsocks-spec_1.3.6-1_all.ipk

opkg install ChinaDNS_1.3.2_ar71xx.ipk
opkg install shadowsocks-libev-spec_2.4.0-1_ar71xx.ipk
opkg install luci-app-chinadns_1.3.6-1_all.ipk #chinadns的web界面，不过我的安装没有生效。web上没有出现菜单，但不影响使用
opkg install luci-app-shadowsocks-spec_1.3.6-1_all.ipk


/etc/init.d/chinadns enable
/etc/init.d/shadowsocks enable
{% endhighlight%}

# 添加国内忽略列表


{% highlight bash %}
wget -O- 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /etc/ignore.list
{% endhighlight %}

# ss配置

    进入到web页面，在服务菜单下看到 ShadowScoks 子菜单


* 全局设置

    启用  配置上服务器端口密码等


* UDP中继

    不做设置 默认就好


* UDP 转发

    启用 使用默认配置即可



# wan口配置

{% highlight bash%}

config interface 'wan'
        option ifname 'eth0'
        option proto 'dhcp'
        option peerdns '0'
        option dns '8.8.8.8 8.8.4.4 114.114.114.114'
{% endhighlight%}

大功告成！
