---
layout: post
title: 用Wireshark给手机app抓包
categories: [ cm, network ]
tags: [ wifi, 截包, wireshark, capture ]
---

## 内容概述

本文介绍用Wireshark直接从手机上抓包的方法，无需tcpdump，无需手机root

## 抓包方法

### 在电脑端设置wifi热点，手机连接该热点

1. 电脑设置wifi热点，几种方法如下

    + windows系统快捷设置
    以win10为例。打开系统设置 -> 网络和Internet -> 移动热点，将开关打开，设置网络名称和密码即可
    例如下图，热点名称为caiyin
    ![](QQ截图20180112105601.png)

    + 360wifi
    打开360卫士 -> 功能大全 -> 全部工具，找到`免费wifi`，安装后即可输入网络名称和密码
    具体设置图文教程见<https://zhidao.baidu.com/question/426233962086817452.html>

    + 用命令设置
    详见 [here](#cmd-network)

2. 设置共享网络
打开控制面板 -> 网络和Internet -> 网络和共享中心 -> 更改适配器设置，右击WLAN -> 属性 -> 共享，将家庭网络连接设置为热点的虚拟网卡
例如下图，虚拟网卡为 本地连接*13，
![](QQ截图20180112115311.png)

3. 将手机用wifi连接到这个热点
若无法获取IP请参考 [ 手机连接wifi无法获取IP的解决方法 ](#phone-no-ip-in-wifi)

### 打开Wireshark，监控作为热点的接口

如下图，双击选择本地连接*13即可
![](QQ截图20180112134758.png)

### 手机连到电脑，点击开始

将手机用USB连到电脑上，点击![](QQ截图20180112135311.png)即可开始



## Trouble Shooting



<a name="cmd-network"></a>

### windows 开启热点失败

* 参考
  * <https://jingyan.baidu.com/article/335530da4f774019cb41c3eb.html>
  * <https://blog.csdn.net/huangbin_vip/article/details/41862609>

#### 可以尝试使用命令的方式，开启热点

1. “已管理员身份运行”命令行
    ~~~ bat
    C:\WINDOWS\system32>netsh wlan start hostednetwork mode=allow
    已启动承载网络。

    C:\WINDOWS\system32>netsh wlan set hostednetwork ssid=myssid key=123456789
    已成功更改承载网络的 SSID。
    已成功更改托管网络的用户密钥密码。

    C:\WINDOWS\system32>netsh wlan start hostednetwork mode=allow
    已启动承载网络。
    ~~~
    
    运行完成，打开 打开控制面板 -> 网络和Internet -> 网络和共享中心 -> 更改适配器设置，
    会出现一个“Microsoft Virtual WiFi Miniport Adapter”的无线网络连接，例如“无线网络连接 *4”

    ![](create-virtual-network.png)
    
2. 设置网络共享
    1. 打开控制面板 -> 网络和Internet -> 网络和共享中心 -> 更改适配器设置
    2. 右键“以太网”，进入属性，“共享” tab页
        1. 勾选 “允许其他网络用户通过此计算机的Internet连接来连接”
        2. “请选一个专用网络连接” 中，选择刚建立的虚拟无线网卡。

3. 用手机连接刚开启对虚拟无线网卡就好了


#### 关闭热点

~~~
C:\WINDOWS\system32>netsh wlan stop hostednetwork
已停止承载网络。
~~~



<a name="phone-no-ip-in-wifi"></a>

### 手机连接wifi无法获取IP

#### 现象

手机连接wifi、热点时，可能出现`无法获取IP`、长时间提示“`正在获取ip`”，本篇用于解决该问题

问题现象：名称为caiyin的网络一直提示“正在获取IP”

<img src="无法获取IP.png"  height="30%" width="30%">

#### 解决步骤

1. 在手机上开启静态IP
    开启方法：点击该网络的详情图标，选择静态IP并开启
    ![](静态IP.png)

2. 查找IP、网关等信息
    查找方法：打开cmd命令窗口，输入`ipconfig`即可查看
    ![](查找IP等信息.png)

3. 将IP等信息填入手机
    在静态IP开启页面填写步骤2的查找结果，其中IP地址需修改最后一位

4. 重启WLAN，连接到wifi或热点





