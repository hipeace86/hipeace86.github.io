---
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

