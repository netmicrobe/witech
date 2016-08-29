---
layout: post
title: Android textview 中的link 不能点击
description: 
categories: [android, dev]
tags: [android]
---

textview 中的link，看起来是链接，但是点击了就是不会跳转。

要给TextView加个LinkMovementMethod

{% highlight java %}
textView.setText(Html.fromHtml("<a href=\"http://www.google.com\">This is a link</a>"));
textView.setMovementMethod(LinkMovementMethod.getInstance());
{% endhighlight %}