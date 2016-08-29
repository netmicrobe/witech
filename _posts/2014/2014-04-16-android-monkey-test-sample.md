---
layout: post
title: Android：Monkey Testing
description: 
categories: [android, dev]
tags: [android]
---

示例

{% highlight shell %}
monkey -s 3843211230 -p com.egame --monitor-native-crashes --ignore-security-exceptions --kill-process-after-error --pct-trackball 0 --pct-nav 0 --pct-anyevent 10 --pct-appswitch 2 -v -v --throttle 500 600000
{% endhighlight %}

### start logcat first

{% highlight shell %}
adb logcat 2>&1 | tee monkey.6.0.4.0604.main.log
{% endhighlight %}

### start monkey

{% highlight shell %}
adb shell "monkey -s 3843211230 -p com.egame --monitor-native-crashes --ignore-security-exceptions --kill-process-after-error --pct-trackball 0 --pct-nav 0 --pct-anyevent 10 --pct-appswitch 2 -v -v --throttle 200 600000" 2>&1 | tee monkey.6.0.4.0604.txt
{% endhighlight %}
 