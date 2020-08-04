---
layout: post
title: WebRTC
categories: [dev, streaming]
tags: [webrtc]
---

* 参考： 
  * [WebRTC实时音视频技术基础：基本架构和协议栈](http://yunxin.163.com/blog/52im-18/)
  * [WebRTC有前途吗？ - 又拍云的回答 - 知乎](https://www.zhihu.com/question/22301898/answer/207430200)
  * [实时音视频互动：基于 WebRTC 技术的实战解析](https://www.upyun.com/tech/article/197/1.html?utm_source=zhihu&utm_medium=referral&utm_campaign=207430200&utm_term=webrtc)
  * []()
  * []()
  * []()
  * []()
  * []()


## 什么是 WebRTC

2010年5月，Google 花费6820万美元收购拥有编解码、回声消除等技术的 GIPS 公司。
之后谷歌开源了 GIPS 的技术，与相关机构 IETF 和 W3C 制定行业标准，组成了现有的 WebRTC 项目。

WebRTC 全称 Web Real-Time Communication。它并不是单一的协议， 包含了媒体、加密、传输层等在内的多个协议标准以及一套基于 JavaScript 的 API。通过简单易用的 JavaScript API ，在不安装任何插件的情况下，让浏览器拥有了 P2P音视频和数据分享的能力。

同时WebRTC 并不是一个孤立的协议，它拥有灵活的信令，可以便捷的对接现有的SIP 和电话网络的系统。


## WebRTC 的核心组件

* 音视频引擎：OPUS、VP8 / VP9、H264
* 传输层协议：底层传输协议为 UDP
* 媒体协议：SRTP / SRTCP
* 数据协议：DTLS / SCTPP2P 
* 内网穿透：STUN / TURN / ICE / Trickle ICE
* 信令与 SDP 协商：HTTP / WebSocket / SIP、 Offer Answer 模型


* webrtc内部结构

![](webrtc内部结构.jpg)


* webrtc协议栈

![](webrtc协议栈.jpg)

![](webrtc-stack.png)


## 真正实用的基于P2P的WebRTC架构

WebRTC使用P2P媒体流，音频、视频和数据的连接直接通过浏览器实现。

但是，浏览器却隐藏在 `NAT`（网络地址翻译）和防火墙的后面，这增加了建立P2P媒体会话的难度。

这些流程和协议，如`ICE`或`Trickle ICE`，`STUN`和`TURN`，在建立P2P媒体流都是必不可少的。


![](stun-nat-traversal.png)


* 如何使用STUN协议建立一个P2P RTC媒体（如上图所示），简化版的ICE流程如下：

1. 两个浏览器通过自己的公网IP地址，使用`STUN`协议信息和`STUN`服务器建立联系；
2. 两个浏览器通过SDP提供/应答机制，使用呼叫控制信令消息交换它们已发现的公共IP地址（ICE候选）；
3. 两个浏览器执行连接检查（ICE冲孔），确保P2P可以连接；
4. 建立连接后，RTC媒体会话和媒体交换就可以实现了。
5. 但是，假如在一个高度限制的NAT或防火墙，这种直接的路径将无法建立，只能到达`TURN`服务器。结果是媒体通过TURN服务器分程传递（如下图所示）。

![](media-via-trun-server.png)












































































