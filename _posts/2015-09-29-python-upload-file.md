---
layout: post
title:  "python上传文件代码片断"
date:   2015-09-29 11:47:49
categories: Python
tags: Python
---


#记一次文件上传

{% highlight python %}

from MultiPartForm import MultiPartForm
import urllib,urllib2,cookielib

form = MultiPartForm()
form.add_file('System', 'config.txt',
              fileHandle=open('telconfs/{0}.txt'.format(phone),'r'))
body = str(form)


request = urllib2.Request('{0}config.htm'.format(baseurl))
request.add_header('Content-type', form.get_content_type())
request.add_header('Content-length', len(body))
#request.add_header('Cookie','CUR_LANG=en; auth={0}'.format(nonce))
request.add_data(body)

result = urllib2.urlopen(request).read()


{% endhighlight %}
