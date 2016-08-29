---
layout: post
title: Android 技术专题系列之二 －－ telephony
description: 
categories: [android, dev]
tags: [android, telephony, sms]
---

摘自：<http://www.360doc.com/content/10/0526/13/1526449_29599306.shtml>

## 第一部分 c代码

Android源码中，hardware/ril目录中包含着Android的telephony底层源码。这个目录下包含着三个子目录，下面是对三个子目录的具体分析。

### 目录hardware/ril/include分析：                                               

只有一个头文件ril.h包含在此目录下。ril.h中定义了76个如下类型的宏：RIL_REQUEST_XXX ，...

这些宏代表着客户进程可以向Android telephony发送的命令，包括SIM卡相关的功能，打电话，发短信，网络信号查询等。好像没有操作地址本的功能？

                                                                                       
### 目录hardware/ril/libril分析。

本目录下代码负责与客户进程进行交互。在接收客户进程命令后，调用相应函数进行处理，然后将命令响应结果传回客户进程。在收到来自网络端的事件后，也传给客户进程。

文件ril_commands.h：列出了telephony可以接收的命令；每个命令对应的处理函数；以及命令响应的处理函数。

文件ril_unsol_commands.h：列出了telephony可以接收的事件类型；对每个事件的处理函数；以及WAKE Type???

文件ril_event.h/cpp：处理与事件源(端口，modem等）相关的功能。ril_event_loop监视所有注册的事件源，当某事件源有数据到来时，相应事件源的回调函数被触发（firePending -> ev->func())

文件ril.cpp：

RIL_register函数：打开监听端口，接收来自客户进程的命令请求 （s_fdListen = android_get_control_socket(SOCKET_NAME_RIL);），当与某客户进程连接建立时，调用listenCallback函数；创建一单独线程监视并处理所有事件源 （通过ril_event_loop)

listenCallback函数：当与客户进程连接建立时，此函数被调用。此函数接着调用processCommandsCallback处理来自客户进程的命令请求

processCommandsCallback函数：具体处理来自客户进程的命令请求。对每一个命令，ril_commands.h中都规定了对应的命 令处理函数（dispatchXXX），processCommandsCallback会调用这个命令处理函数进行处理。

dispatch系列函数：此函数接收来自客户进程的命令己相应参数，并调用onRequest进行处理。

RIL_onUnsolicitedResponse函数：将来自网络端的事件封装（通过调用responseXXX）后传给客户进程。

RIL_onRequestComplete函数：将命令的最终响应结构封装（通过调用responseXXX）后传给客户进程。

response系列函数：对每一个命令，都规定了一个对应的response函数来处理命令的最终响应；对每一个网络端的事件，也规定了一个对应的 response函数来处理此事件。response函数可被onUnsolicitedResponse或者onRequestComplete调用。

### 目录hardware/ril/reference-ril分析。本目录下代码主要负责与modem进行交互。

文件reference-ril.c：此文件核心是两个函数：onRequest和onUnsolicited

onRequest 函数：在这个函数里，对每一个RIL_REQUEST_XXX请求，都转化成相应的AT command，发送给modem，然后睡眠等待。当收到此AT command的最终响应后，线程被唤醒，将响应传给客户进程（RIL_onRequestComplete -> sendResponse）。

onUnsolicited函数：这个函数处理modem从网络端收到的各种事件，如网络信号变化，拨入的电话，收到短信等。然后将时间传给客户进程 （RIL_onUnsolicitedResponse -> sendResponse）

文件atchannel.c：负责向modem读写数据。其中，写数据(主要是AT command)功能运行在主线程中，读数据功能运行在一个单独的读线程中。

函数at_send_command_full_nolock：运行在主线程里面。将一个AT command命令写入modem后进入睡眠状态（使用 pthread_cond_wait或类似函数），直到modem读线程将其唤醒。唤醒后此函数获得了AT command的最终响应并返回。

函数readerLoop运行在一个单独的读线程里面，负责从modem中读取数据。读到的数据可分为三种类型：网络端传入的事件；modem对当前AT command的部分响应；modem对当前AT command的全部响应。对第三种类型的数据（AT command的全部响应），读线程唤醒（pthread_cond_signal）睡眠状态的主线程。

## Java代码

Android中，telephony相关的java代码主要在下列目录中：

1. frameworks/base/telephony/java/android/telephony
2. frameworks/base/telephony/java/com/android/internal/telephony
3. frameworks/base/services/java/com/android/server/TelephonyRegistry.java
4. packages/apps/Phone

其中，目录1中的代码提供Android telephony的公开接口，任何具有权限的第三方应用都可使用，如接口类TelephonyManager。
目录2/3中的代码提供一系列内部接口，目前第三方应用还不能使用。当前似乎只有packages/apps/Phone能够使用
目录4是一个特殊应用，或者理解为一个平台内部进程。其他应用通过intent方式调用这个进程的服务。

TelephonyManager主要使用两个服务来访问telephony功能：

1. ITelephony， 提供与telephony 进行操作，交互的接口，在packages/apps/Phone中由PhoneInterfaceManager.java实现。
2. ITelephonyRegistry, 提供登记telephony事件的接口。由frameworks/base/services/java/com/android/server/TelephonyRegistry.java实现。

interface CommandsInterface 描述了对电话的所有操作接口，如命令， 查询状态，以及电话事件监听等

class BaseCommands是CommandsInterface的直接派生类，实现了电话事件的处理(发送message给对应的handler)。

而class RIL又派生自BaseCommands。RIL负责实际实现CommandsInterface中的接口方法。RIL通过Socket和rild守护进 程进行通讯。对于每一个命令接口方法，如acceptCall，或者状态查询，将它转换成对应的RIL_REQUEST_XXX，发送给rild。线程 RILReceiver监听socket,当有数据上报时，读取该数据并处理。读取的数据有两种，

1. 电话事件，RIL_UNSOL_xxx, RIL读取相应数据后，发送message给对应的handler （详见函数processUnsolicited）
2. 命令的异步响应。(详见函数processSolicited)

interface Phone描述了对电话的所有操作接口。 PhoneBase直接从Phone 派生而来。而另外两个类，CDMAPhone和GSMPhone，又从PhoneBase派生而来，分别代表对CDMA 和GSM的操作。

PhoneProxy也从Phone直接派生而来。当当前不需要区分具体是CDMA Phone还是GSM Phone时，可使用PhoneProxy。

抽象类Call代表一个call，有两个派生类CdmaCall和GsmCall。

interface PhoneNotifier定义电话事件的通知方法

DefaultPhoneNotifier从PhoneNotifier派生而来。在其方法实现中，通过调用service ITelephonyRegistry来发布电话事件。

service ITelephonyRegistey由frameworks/base/services/java/com/android/server /TelephonyRegistry.java实现。这个类通过广播intent，从而触发对应的broadcast receiver。

在PhoneApp创建时，

{% highlight java %}
   sPhoneNotifier = new DefaultPhoneNotifier();
   ...
   sCommandsInterface = new RIL(context, networkMode, cdmaSubscription);
{% endhighlight %}

然后根据当前phone是cdma还是gsm,创建对应的phone，如

   sProxyPhone = new PhoneProxy(new GSMPhone(context,
                            sCommandsInterface, sPhoneNotifier));




下面我们来研究一个电话打出去的流程。

1. TwelveKeyDialer.java, onKeyUp()
2. TwelveKeyDialer.java, placeCall()
3. OutgoingCallBroadcaster.java, onCreate()
    sendOrderedBroadcast(broadcastIntent, PERMISSION,
                new OutgoingCallReceiver(), null, Activity.RESULT_OK, number, null);
4. OutgoingCallBroadcaster.java, OutgoingCallReceiver
    doReceive -> context.startActivity(newIntent);
5. InCallScreen.java, onCreate/onNewIntent
6. InCallScreen.java, placeCall
7. PhoneUtils.java, placeCall
8. GSMPhone.java, dial
9. GsmCallTracker.java, dial
10. RIL.java, dial
      RILRequest rr = RILRequest.obtain(RIL_REQUEST_DIAL, result);
      ...
      send(rr);

下面来研究一个incoming call的流程：

1. 创建GsmPhone时，mCT = new GsmCallTracker(this);
2. 创建GsmCallTracker时:
    cm.registerForCallStateChanged(this, EVENT_CALL_STATE_CHANGE, null); -->    
    mCallStateRegistrants.add(r); 
3. RIL中的RILReceiver线程首先读取从rild中传来的数据：processResponse -> processUnsolicited
4. 对应于incoming call,RIL收到RIL_UNSOL_RESPONSE_CALL_STATE_CHANGED 消息，触发mCallStateRegistrants中的所有记录。
5. GsmCallTracker处理EVENT_CALL_STATE_CHANGE，调用pollCallsWhenSafe
6. 函数pllCallsWhenSafe 处理：
     lastRelevantPoll = obtainMessage(EVENT_POLL_CALLS_RESULT);
     cm.getCurrentCalls(lastRelevantPoll);
7. RIL::getCurrentCalls
    RILRequest rr = RILRequest.obtain(RIL_REQUEST_GET_CURRENT_CALLS, result);
    ...
    send(rr);
8. 接着RIL调用processSolicited处理RIL_REQUEST_GET_CURRENT_CALLS的返回结果
9. GsmCallTracker的handleMessage被触发，处理事件EVENT_POLL_CALLS_RESULT,调用函数  
    handlePollCalls
10. handlPollCalls 调用
    phone.notifyNewRingingConnection(newRinging);

11. PhoneApp中创建CallNotifier
12. CallNotifier注册：
    registerForNewRingingConnection -> mNewRingingConnectionRegistrants.addUnique(h, what, obj);


