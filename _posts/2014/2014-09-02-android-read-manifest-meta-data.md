---
layout: post
title: android：获取AndroidManifest.xml中的meta-data配置
description: 
categories: [android, dev]
tags: [android]
---

在AndroidManifest.xml里边定义：

{% highlight xml %}
<application ...>
    <meta-data
        android:name="UMENG_APPKEY"
        android:value="533bcf3956240b72ae0501a5" />
    ...
</application>
{% endhighlight %}

在程序中读取：

{% highlight java %}
Bundle metas = context.getPackageManager().getApplicationInfo(
                        context.getPackageName(), PackageManager.GET_META_DATA).metaData;
String appkey = metas.get("UMENG_APPKEY");
{% endhighlight %}


