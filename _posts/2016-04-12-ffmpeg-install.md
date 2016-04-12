---
layout: post
title:  "centos编译安装ffmpeg"
date:   2016-04-11 14:05:49
categories: CentOS
tags: 折腾
---

ffmpeg的好用之处就不说啦，记录下一次安装记录，测试过在centos6／7下面都没有问题


[yasm]、[lame]、[libvpx]软件包需要科学上网才行，在此我做了一个镜像，放到了七牛上面


{% highlight bash %}

yum install autoconf automake gcc gcc-c++ git libtool make nasm pkgconfig zlib-devel -y

mkdir ~/src

cd ~/src
curl -O http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar xzvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure
make
make install
make distclean
. ~/.bash_profile

cd ~/src
git clone --depth 1 git://git.videolan.org/x264
cd x264
./configure --enable-static
make
make install
make distclean

cd ~/src
git clone --depth 1 git://github.com/mstorsjo/fdk-aac.git
cd fdk-aac
autoreconf -fiv
./configure --disable-shared
make
make install
make distclean

cd ~/src
curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --disable-shared --enable-nasm
make
make install
make distclean

cd ~/src
curl -O http://downloads.xiph.org/releases/opus/opus-1.1.2.tar.gz
tar xzvf opus-1.1.2.tar.gz
cd opus-1.1.2
./configure --disable-shared
make
make install
make distclean

cd ~/src
curl -O http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz
tar xzvf libogg-1.3.2.tar.gz
cd libogg-1.3.2
./configure --prefix=/usr/local/libogg --disable-shared
make
make install
make distclean

cd ~/src
curl -O http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.tar.gz
tar xzvf libvorbis-1.3.5.tar.gz
cd libvorbis-1.3.5
./configure --with-ogg="/usr/local/libogg" --disable-shared
make
make install
make distclean

cd ~/src
git clone https://chromium.googlesource.com/webm/libvpx
cd libvpx
./configure --disable-examples
make
make install
make clean

cd ~/src
curl -O http://downloads.xiph.org/releases/theora/libtheora-1.1.1.zip
unzip libtheora-1.1.1.zip
cd libtheora-1.1.1
./configure --prefix="/usr/local/libtheora" --with-ogg="/usr/local/libogg" --disable-examples --disable-shared --disable-sdltest --disable-vorbistest
make
make install
make distclean

yum -y install freetype-devel speex-devel

cd ~/src
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
cd ffmpeg
PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"
export PKG_CONFIG_PATH
./configure --extra-cflags="-l/usr/local/include" --extra-ldflags="-L/usr/local/lib" --enable-gpl --enable-nonfree --enable-libfdk_aac --enable-libmp3lame --enable-libopus --enable-libvpx --enable-libx264 --enable-libfreetype --enable-libspeex --enable-pthreads --enable-cross-compile --cc=gcc --target-os=linux --arch=x86_64
make
make install
make distclean

{% endhighlight %}


[yasm]: http://7xjbml.com1.z0.glb.clouddn.com/ffmpeg/src/yasm-1.3.0.tar.gz
[lame]: http://7xjbml.com1.z0.glb.clouddn.com/ffmpeg/src/lame-3.99.5.tar.gz
[libvpx]: http://7xjbml.com1.z0.glb.clouddn.com/ffmpeg/src/libvpx.tar.gz
