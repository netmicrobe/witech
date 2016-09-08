---
layout: post
title: burpsuite proxy 截手机app数据包
categories: [cm, network, burpsuite]
tags: [cm, network, security, burpsuite]
---



## 配置方法一

手机和电脑处于同一无线局域网

### burpsuite proxy设置：

```
Proxy 》 Options 》Proxy Listeners
bind to port: [proxy-Listening-port] 接受手机连接的port
Bind to address: 选择 Specific address:[PC-WLAN-IP]
```

### 手机设置代理服务器地址和Port

Android手机在设置》Wlan》选中一个SSID长按》修改网络》显示高级选项。

Android4.0以上的才能设置代理服务器。

```
代理服务器地址 [PC-WLAN-IP]
Port：[proxy-Listening-port]
```

## 配置方法二

电脑运行Connectivity软件，将无线网卡作为一个热点。

电脑运行burpsuite，Proxy设置同配置方法一，Bind to address 可以设置为all interface。

手机设置代理服务器后，连接到电脑的热点，设置方法参考配置方法一。

### 截获数据包并修改

在Proxy中设置，Proxy 》 Options 》Intercept Client Request，

勾选“intercept request based on following rules”，并配置相关过滤规则。就能在Proxy 》 intercept 中看到截获的Request。

在Proxy中设置，Proxy 》 Options 》Intercept Server Response，

勾选“intercept response based on following rules”，并配置相关过滤规则。就能在Proxy 》 intercept 中看到截获的Response。

在Proxy 》 intercept 》 Raw中修改后，点击forward就可篡改网络数据包了。





