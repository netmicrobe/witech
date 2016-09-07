---
layout: post
title: jmeter ：Webservice (SOAP) Request
description: 
categories: [cm, jmeter]
tags: [cm, jmeter, webservice]
---


从jmeter 2.10 开始 Webservice (SOAP) Request Sampler 被 隐藏了。

Webservice (SOAP) Request has been removed by default from GUI as Element is deprecated. (Use HTTP Request with Body Data , see also the Template Building a SOAP Webservice Test Plan ), if you need to show it, see property not_in_menu in jmeter.properties


在bin/jmeter.properties 设置下not_in_menu 就可以再显示出来：

从not_in_menu中删除org.apache.jmeter.protocol.http.control.gui.WebServiceSamplerGui


参考：

http://qnalist.com/questions/4624136/query-how-to-test-web-services-in-jmeter-2-10

http://jmeter.apache.org/changes_history.html

