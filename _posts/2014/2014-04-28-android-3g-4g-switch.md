---
layout: post
title: Android 3G 4G 切换检查
description: 
categories: [android, dev]
tags: [android]
---

### app启动

{% highlight java %}
// 注册phone state listener
TelephonyManager tm = (TelephonyManager)getSystemService(Context.TELEPHONY_SERVICE);
tm.listen(pslistener, PhoneStateListener.LISTEN_DATA_ACTIVITY | PhoneStateListener. LISTEN_DATA_CONNECTION_STATE );
{% endhighlight %}


### app退出

{% highlight java %}
// 取消注册
TelephonyManager tm = (TelephonyManager)getSystemService(Context.TELEPHONY_SERVICE);
tm.listen(pslistener, PhoneStateListener.LISTEN_NONE );

EgamePhoneStateListener.java
public class EgamePhoneStateListener extends android.telephony.PhoneStateListener {

  String lastToast = "";
  @Override
  public void onDataConnectionStateChanged(int state, int networkType) {
    super.onDataConnectionStateChanged(state, networkType);
    if (state == TelephonyManager.DATA_CONNECTED && networkType == 13) {
      toast("已进入4G网络");
    } else {
      toast("已离开4G网络");
    }
  }
  
  public void toast(String tstr) {
    if( tstr != null && !lastToast.equals(tstr) && Egame4gApplication.instance != null ) {
      lastToast = tstr;
      ToastUtils.showToast(Egame4gApplication.instance, lastToast);
    }
  }
  
}
{% endhighlight %}