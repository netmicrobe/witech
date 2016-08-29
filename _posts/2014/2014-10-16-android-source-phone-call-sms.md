---
layout: post
title: Android 源码分析：打电话和发短信
description: 
categories: [android, dev]
tags: [android, sms]
---


摘自：
<http://dev.10086.cn/cmdn/wiki/index.php?edition-view-2400-1.html>

## ITelephony接口和ISms接口以及AIDL

   在我们的Android 应用中，当需要实现电话拨号时，我们需要进行如下调用
   
   {% highlight java %}
   ITelephony phone = (ITelephony)ITelephony.Stub.asInterface(ServiceManager.getService("phone"))
   phone.dial("10086");
   {% endhighlight %}
   
   对于短信 应用，我们需要的是调用SmsManager，代码如下
   
   {% highlight java %}
   SmsManager manager = SmsManager.getDefault();
   manager.sendTextMessage("10086",null,"hi,this is sms",null,null);
   {% endhighlight %}
   
   这里,SmsManager对ISms做了一层包装，实质上是通过调用
   
   {% highlight java %}
   ISms simISms = ISms.Stub.asInterface(ServiceManager.getService("isms"));
   simISms.sendRawPdu....
   {% endhighlight %}
   
   可以看到，应用都是采用AIDL来实现IPC的跨进程调度。
   
   对于AIDL应用，调用进程方存在的是一个实现接口的Pro xy对象，通过Proxy对象与被调用进程中的Stub对象进行通讯来实现IPC的跨进程调度，所以，在被调用进程一端必定有一个ITelephony.Stub类以及ISms.Stub类的实现


## PhoneInterfaceManager和SimSmsInterfaceManager

   ITelephony.Stub 的实现类为com.android.phone.PhoneInterfaceManager
   ISms.Stub的实现类为com.android.internal.telephony.gsm.SimSmsInterfaceManager
   从这两个类的构造器的调用代码里可以很清楚的看到进行了Service的注册工作
   
   {% highlight java %}
   ServiceManager.addService("phone",this);
   ServiceManager.addService("isms",this);
   {% endhighlight %}

## PhoneApp,InCallScreen,PhoneUtils及其他相关类

   从SimSmsInteferManager的相关方法实现中可以看到，具体就是调用GSMPhone的SmsDispatcher实例来进行相关操作的。
   
   从PhoneInterfaceManager会维持一个Phone对象的引用，当拨号应用时，PhoneInterfaceManager会将构造好的Intent传递给PhoneApp应用，该Intent的className指定则为InCallScreen,从中我们可以看到 InCallScreen具体是通过PhoneUtils调用Phone的相关方法来实现。
   
   PhoneInterfaceManager怎么获取到对应的Phone对象，然后又怎么将Phone对象传递到InCallScreen中呢？
   具体这里涉及到了PhoneApp这个类，从这个类维护了一个 PhoneInterfaceManager的引用(phoneMgr)以及一个Phone引用（phone)，
   从该类的onCreate方法中我们可以清楚的看到，PhoneApp通过PhoneFactory获取了一个Phone实例，并通过该实例实现了PhoneInterfaceManager对象。
   
   因此，我们现在只需要关注PhoneFactory具体提供的是一个什么样的Phone实例了。
   另外，PhoneApp类还提供了一个静态方法getInstance供InCallScreen调用，InCallScreen正是通过调用该方法获得PhoneApp实例从而获得对应的Phone实例的。
   
   接下来，我们通过查看PhoneFactory的方法可以看到，Phone对象对应的就是一个GSMPhone实例。

## GSMPhone与RIL

   从GSM的构造器可以看出，他依赖一个CommandInterface接口实例，通过PhoneFactory的makeDefaultPhones方法，我们可以看到，根据系统 环境变量ro.radio.noril来判断是否需要采用RIL框架实现，如果该参数不为空，则采用Simultedcommands（主要是为了测试需要提供的模拟实现）.否则，采用RIL。
   
   通过Google 才知道，RIL其实是智能手机 上实现AP与BP之间通信的一种设计思想，具体大家可以参见这篇文章http://www.eetchina.com/ARTICLES/2006OCT/PDF/CPCOL_2006OCT26_EMB_TA_170.PDF?SOURCES=DOWNLOAD 
   
   在RIL.java 中我们很惊喜的看到，RIL对对消息的处理是将消息通过LocalSocket发送到以rild为名称的有名端口。这个有名Socket的创建在ril.cpp代码中。
   
   s_fdListen = android_get_control_socket(SOCKET _NAME_RIL)
   
   原来Android通话和发短信的应用是JAVA与C++代码之间透过Socket连接来传输消息来实现的。

## 关于C代码与硬件之间的交互

   这部分工作其实就是C代码通过串口发送AT指令来拨号，收发短信。今天有点累了，具体的实现下次我再分析。



