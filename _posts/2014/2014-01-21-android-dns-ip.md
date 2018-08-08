---
layout: post
title: Android / Java 下如何获取域名的IP
description: 
categories: [dev, android]
tags: [java, android]
---

~~~ java
InetAddress address =InetAddress.getByName("www.example.com");
System.out.println(address.getHostAddress());
~~~

