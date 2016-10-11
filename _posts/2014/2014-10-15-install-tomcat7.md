---
layout: post
title: 安装并启动tomcat7
categories: [cm, tomcat]
tags: [cm, tomcat]
---

Tomcat 7.x的版本直接去 <http://tomcat.apache.org/download-70.cgi> 下载tar包，
解压，运行bin/startup.sh即可。
启动后，访问 localhost:8080 可以看到tomcat默认首页。
从网络上如果无法访问，检查下是否防火墙挡住，是的话配置下iptables。