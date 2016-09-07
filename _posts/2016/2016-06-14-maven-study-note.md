---
layout: post
title: maven 快速介绍
categories: [cm, maven]
tags: [cm, maven]
---

## 常用命令

### 快速创建基本工程

```
mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```

### 打包

mvn package

### 查看系统环境设置

mvn help:system

## 基本概念

* phase
* plugin/artifact
* goal

## lifecycles & phase

three built-in build lifecycles: default, clean and site.

参见：
http://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html


the default lifecycle comprises of the following phases :

* validate- validate the project is correct and all necessary information is available
* compile- compile the source code of the project
* test- test the compiled source code using a suitable unit testing framework. These tests should not require the code be packaged or deployed
* package- take the compiled code and package it in its distributable format, such as a JAR.
* verify- run any checks on results of integration tests to ensure quality criteria are met
* install- install the package into the local repository, for use as a dependency in other projects locally
* deploy- done in the build environment, copies the final package to the remote repository for sharing with other developers and projects.

## POM 语法

POM element <packaging> , default to jar, Some of the valid packaging values are jar, war, ear and pom.



## maven 配置


### Windows 上的配置文件位置

\<mvn-home\>/conf/settings.xml



### 设置本地库的位置

在 settings.xml 中 localRepository 标签

#### maven 本地库路径修改

默认路径是：${user.home}/.m2/settings.xml

所以Windows上本地库默认在C盘，本地库不断变大会导致C盘空间不足，所以要调整到别的地方。

在maven安装目录/conf/settings.xml中设置就可以了：

<localRepository>D:/maven/repository</localRepository>

也可以将settings.xml拷贝到${user.home}/.m2/下，修改这个settings.xml，这样就只影响当前用户。




### 设置 remote repository 镜像，国内连官方库很慢

在 settings.xml 中 mirrors 标签



