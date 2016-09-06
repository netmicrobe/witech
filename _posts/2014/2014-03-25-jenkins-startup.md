---
layout: post
title: jenkins 启动
description: 
categories: [cm, jenkins]
tags: [cm, jenkins]
---

```
java -jar jenkins.war
```

默认使用自带的轻量级的servlet engine启动，默认端口8080
（engine可能是Winstone或jetty）

使用war直接启动，配置文件存在$HOME/.jenkins/

自定义启动端口

```
java -jar jenkins.war --httpPort=8081
```
