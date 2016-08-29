---
layout: post
title: Android：EditText,TextView的限制条件设置
description: 
categories: [android, dev]
tags: [android]
---

android:lines   在屏幕上显示几行，默认为1，所以所有EditText看起来就好像只能输入一行。

android:maxLines   待研究。。

## android EditText 限制整数输入

{% highlight xml %}
<EditText android:id="@+id/text_times"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" 
    android:inputType="number|phone"
    android:maxLength="4"
    android:digits="1234567890"
    android:text="1"
    />
{% endhighlight %}

inputType 设置为number，就已经可以限定输入框只接受数字输入，但是弹出的软键盘还是全键盘。

所以同时设置inputType=phone，弹出拨号的键盘，其中只有数字键和其他一些拨号键，方便输入数字。



