---
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



[Bitbucket]: https://bitbucket.org/hipeace86/bonesite
