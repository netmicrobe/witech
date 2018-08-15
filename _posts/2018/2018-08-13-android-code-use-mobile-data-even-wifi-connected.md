---
layout: post
title: Android 上使用 android.net.ConnectivityManager + NetworkRequest.Builder 强制无线数据网络访问互联网，即使wlan处于正常连接状态
categories: [ dev, android ]
tags: [connection, wifi]
---


---
* 参考
  * [Android多网络环境（wifi,mobile）下强制在某个网络(mobile)访问服务端以及适配](https://blog.csdn.net/u010019468/article/details/72886859)
  * [Android HttpURLConnection with AsyncTask Tutorial](https://medium.com/@lewisjkl/android-httpurlconnection-with-asynctask-tutorial-7ce5bf0245cd)


---



## 如何使用 android.net.ConnectivityManager + NetworkRequest.Builder 强制网络访问制式

* 注意
  * 该方法访问数据网络时，有时间延时，有些 **慢** ，目测 10+ 秒
  * 不需要运行时请求权限，安装时提醒用户，app需要“修改系统设置”权限


### 添加权限

~~~ xml
<uses-permission android:name="android.permission.CHANGE_NETWORK_STATE"/>
~~~


### 代码

~~~ java
 @TargetApi(21)
    private void forceSendRequestByMobileData() {
        ConnectivityManager connectivityManager = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkRequest.Builder builder = new NetworkRequest.Builder();
        builder.addCapability(NET_CAPABILITY_INTERNET);
        //强制使用蜂窝数据网络-移动数据
        builder.addTransportType(TRANSPORT_CELLULAR);
        NetworkRequest build = builder.build();
        connectivityManager.requestNetwork(build, new ConnectivityManager.NetworkCallback() {
            @Override
            public void onAvailable(Network network) {
                super.onAvailable(network);
                try {
                    URL url = new URL("");
                    HttpURLConnection connection = (HttpURLConnection)network.openConnection(url);
                    /*******省略参数配置*******/
                    connection.connect();
                    /*******数据流处理*******/
                } catch (Exception e) {

                }

            }
        });
    }
~~~


### 测试情况

~~~
 * 测试通过机型
 *   * 小米8se               8.1 api27
 *   * Vivo Y85A            8.1 api27
 *   * 华为荣耀V10 BKL-AL20   8.0 api26
 *
 * 测试不通过
 *   * 小米4 Android 6.0.1 api23
~~~



































































