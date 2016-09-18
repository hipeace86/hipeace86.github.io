---
layout: post
title:  "ffmpeg将视频转码为m3u8并加水印"
date:   2016-09-18 14:08:49
categories: CentOS
tags: 折腾
---

之前记录过一个ffmpeg配置的，这次说说ffmpeg转m3u8


先看下面的命令
{% highlight bash %}
ffmpeg -i 1.mp4 -i logo.png \
-filter_complex "[1:v]scale=140:130[s];[0:v][s]overlay=0:main_h-overlay_h" \
-c:v libx264 -c:a aac -strict -2\
-hls_list_size 0 \
-t 1:30 -hls_time 10 -f hls c/c.m3u8
{% endhighlight %}

各参数解析：

* -i 1.mp4 :要转码的视频
* -i logo.png: 要添加的水印图片名称（注意路径)
* -filter_complex: 使用复杂滤镜添加水印，后面参数中scale为调整的水印大小,overlay为水印位置(本例为左下角)
* -c:v libx264....: 指定视频、音频的转码格式
* -hls_list_size 0:保存所有ts列表到m3u8文件(默认只保留最新的五个)
* -hls_time 10: 默认每个ts分片文件长度，默认为2秒
* -t :转码结束位置(用来做视频切割很有用)
* -f hls: 指定为hls格式，导到到一个文件即可

另外可用

* -hls_segment_filename:指定分片文件名格式
* -ss: 指定视频转码开始位置


附上两个m3u8文件内容

{% highlight bash %}
#EXTM3U
#EXT-X-VERSION:3
#EXT-X-TARGETDURATION:16
#EXT-X-MEDIA-SEQUENCE:0
#EXTINF:14.199633,
lj000.ts
#EXTINF:5.040000,
lj001.ts
#EXTINF:8.480000,
lj002.ts
#EXTINF:9.440000,
lj003.ts
#EXTINF:10.000000,
lj004.ts
#EXTINF:10.000000,
lj005.ts
#EXTINF:8.120000,
lj006.ts
#EXT-X-ENDLIST
{% endhighlight %}

自适流播放列表

{% highlight bash %}
#EXTM3U
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1677946,RESOLUTION=1280x720
lj1280x720.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=707099,RESOLUTION=640x360
lj640x360.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=357103,RESOLUTION=320x180
lj320x180.m3u8
{% endhighlight %}

另： 加水印也可以使用如下参数替换

-vf "movie=logo.png [watermark]; [in][watermark] overlay=10:20 [out]"


还要注意参数顺序，刚开始把-filter_complex加到了后面结果报错了，
调整到前面后就没有问题；在找资料时也发现有人说做截图时由于参数位置可导致最终效率
