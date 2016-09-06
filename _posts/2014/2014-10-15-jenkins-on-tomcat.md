---
layout: post
title: 在tomcat中安装jenkins
description: 
categories: [cm, jenkins]
tags: [cm, jenkins, tomcat]
---

参考： <https://wiki.jenkins-ci.org/display/JENKINS/Tomcat>

1）将jenkins的war包拷贝或者解压到tomcat的webapps下

2）配置 JENKINS_HOME 环境变量

添加如下tomcat启动变量到context.xml中

```
<Context ...>
  <Environment name="JENKINS_HOME" value="/path/to/jenkins_home/" type="java.lang.String"/>
</Context>
```

3）配置语言兼容

在server.xml中为connector配置下utf8的uriencoding：

<Connector port="8080" URIEncoding="UTF-8"/>

4）重启tomcat，访问 localhost:8080/jenkins




