---
layout: post
title:  "初试vue框架"
date:   2016-06-29 00:20:49
categories: 折腾
tags: 折腾
---

# 0x00
{% highlight bash%}
npm install vue vue-cli -g
vue init webpack my-project
cd my-project
npm install
npm run env
{% endhighlight %}

# 0x01

{% highlight bash%}
npm install vue-router
{% endhighlight %}

# 0x02

{% highlight javascript %}
import Vue from 'vue'
import App from './App'

/* eslint-disable no-new */
Vue.use(VueRouter)
import VueRouter from 'vue-router'
var router = new VueRouter()

router.map({
  '/foo': {
    component: App
  }
})

router.start(App, '#app')

{%endhighlight%}

# 0x03

{% highlight html%}
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>my-project</title>
  </head>
  <body>
    <div id="app"></div>
        <!-- built files will be auto injected -->
  </body>
</html>

{% endhighlight %}
