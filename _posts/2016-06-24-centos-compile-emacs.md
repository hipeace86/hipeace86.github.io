---
layout: post
title:  "centos编译安装emacs"
date:   2016-06-24 11:56:49
categories: CentOS Emacs
tags: Emacs
---

emacs 神器不多说了，如果直接yum安装的版本较老，很多高手的配置都不适用

唯有自己编译一个最新的来用

{% highlight bash%}
yum install libX11-devel libjpeg-turbo-devel libpng-devel libtiff-devel libXpm-devel giflib-devel openjpeg-devel gtk2-devel ncurses-devel m17n-lib-devel texinfo texlive texinfo-tex texlive-dvips texlive-metapost automake gcc -y
wget http://ftp.gnu.org/gnu/emacs/emacs-24.5.tar.gz
tar zxvf emacs-24.5.tar.gz
cd emacs-24.5
./configure --prefix=/usr/local --with-x-toolkit=gtk
make
make install
{% endhighlight %}

安装完成,下面来配置一下，拉取我fork的大神[bbatsov]的配置[prelude]

{% highlight bash%}
git clone https://github.com/hipeace86/prelude.git ~/.emacs.d
{% endhighlight %}

完成后运行emacs，首次运行会下载很多插件等，时间会很长。。。。

[bbatsov]: https://github.com/bbatsov
[prelude]: https://github.com/hipeace86/prelude
