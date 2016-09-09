---
layout: post
title: Gerrit 源码下载，编译，从Linux包安装
categories: [cm, git]
tags: [cm, git, gerrit]
---



参考：<https://gerrit.googlesource.com/gerrit/+/v2.12.2>


## 源代码

* Google Source
    * https://gerrit.googlesource.com/gerrit
    * git clone https://gerrit.googlesource.com/gerrit

* GitHub
    * https://github.com/gerrit-review/gerrit
    * https://github.com/gerrit-review/gerrit.git




## 编译

Install [Buck](https://buckbuild.com/setup/install.html) and run the following:

```
    git clone --recursive https://gerrit.googlesource.com/gerrit
    cd gerrit && buck build release
```




## 从二进制包安装

Install binary packages (Deb/Rpm)

The instruction how to configure GerritForge/BinTray repositories is here

On Debian/Ubuntu run:

    apt-get update & apt-get install gerrit=<version>-<release>

NOTE: release is a counter that starts with 1 and indicates the number of packages that have been released with the same version of the software.

On CentOS/RedHat run:

    yum clean all && yum install gerrit-<version>[-<release>]










