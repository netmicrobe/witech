---
layout: post
title: Android：如果判断电信手机处于CDMA中
description: 
categories: [android, dev]
tags: [android]
---

{% highlight java %}
public boolean IsPhoneInCDMA() {

     TelephonyManager telm = (TelephonyManager)getSystemService(Context.TELEPHONY_SERVICE);
     if( telm.getPhoneType() == TelephonyManager.PHONE_TYPE_CDMA 
         && telm.getNetworkType() != TelephonyManager.NETWORK_TYPE_UNKNOWN ) {
         return true;
     }
     return false;
}

{% endhighlight %}