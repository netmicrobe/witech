---
layout: post
title: Android：activity结束时，删除进程，完全退出
description: 
categories: [android, dev]
tags: [android]
---


在onDestroy()中调用System.exit()

{% highlight java %}

@Override
public void onDestroy() {
    super.onDestroy();
    System.exit(0);
}

{% endhighlight %}

