---
layout: post
title: Android：receiver 处理完毕，关闭自己进程
description: 
categories: [android, dev]
tags: [android]
---

默认receiver处理完毕后，即使process中没有component，process也会驻留在内存中，指导系统资源不够。

receiver处理完毕后，可以用Process.killProcess自己关闭自己进程。

{% highlight java %}
public void onReceive(Context context, Intent intent) {
    String action = intent.getAction();
    Log.d(TAG, intent.toString());
    Toast.makeText(context, action, Toast.LENGTH_SHORT).show();
    
    //杀死进程
    System.exit(0);
    // // killProcess 和 System.exit 两种方法都能让系统删除进程
    // android.os.Process.killProcess( android.os.Process.myPid() );
}

{% endhighlight %}


但是这还是有问题：要先判断下，当前Process只剩这个receiver才能关闭。不然就无视前端的Activity或者Service了。





