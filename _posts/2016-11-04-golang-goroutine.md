---
layout: post
title:  "控制goroutine总数"
date:   2016-11-04 15:31:49
categories: Go
tags: Golang
---


刚接触golang，被它的方便并发编程所吸引，于是在改写一个新的项目中决然选择了用GO；两周时间边学边写还算顺利


但在最后的测试过程中发现问题，

{% highlight bash %}
painc: runtime error: invalid memory address or nil pointer dereference
        painc: runtime error
        .....
goroutine 88670 [running]:
    .....
{% endhighlight %}

因为报错的地方是在执行一个数据库操作，开始只是以为是数据库连接数太小导致的。在多次修改连接数和数据库其它选项后问题依然存在


开始用于控制协程的代码如下：

{% highlight go %}

var wg sync.WaitGroup

for {
    wg.Add(1)
    doSomeThing()
    go func(wg *sync.WaitGroup) {
        wg.Done()
    } (&wg)
}
wg.Wait()
{% endhighlight %}

最后加入 `runtime.NumGoroutine()` 查看数量时发现最高可到40000左右的量，虽然不知道go程序中最高协程数量是多少，但这个量应该也不正常了


开始进入了误区，误以为使用 `runtime.GOMAXPROCS(runtime.NumCPU())` 可以控制最大协程数量，结果发现是不对的；后引入chan


有关chan的知识请大家自行搜索，使用带有缓冲的chan解决了该问题，修改后的代码如下

{% highlight go %}

var wg sync.WaitGroup
var ch ＝ make（chan bool，10）
for {
    wg.Add(1)
    ch <- true
    go func(chan *chan bool,wg *sync.WaitGroup) {
        doSomeThing()
        <- chan
        wg.Done()
    } (&ch,&wg)
}
wg.Wait()
{% endhighlight %}
