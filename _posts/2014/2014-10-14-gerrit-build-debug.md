---
layout: post
title: gerrit build, debug
categories: [cm, git]
tags: [cm, git, gerrit]
---

## Buck, the build system

 
since gerrit 2.8 , moving build system from maven to Buck.

主要原因是，Buck编译比Maven更快。
 
项目首页：<https://github.com/facebook/buck#readme>



### 安装

Buck当前只能编译安装，编译前需要装好ant和jdk7。

```
git clone https://github.com/facebook/buck.git
cd buck
ant
./bin/buck --help
sudo ln -s ${PWD}/bin/buck /usr/bin/buck
```

While there, you may also want to set up buckd:

```
sudo ln -s ${PWD}/bin/buckd /usr/bin/buckd
```
 
* 参考 <http://facebook.github.io/buck/setup/quick_start.html>
 
 
 
 
## 下载源码

 
git clone --recursive https://gerrit.googlesource.com/gerrit

加--recursive 是因为 plugins/ 目录下还有些 git-submodule 也需要下载。

根目录下的 .gitmodules里定义了相关的sub module
 
或者，到plugins/ 目录的各个plugin 文件夹下用git clone下载，下载地址在.gitmodules里。




## Maven编译

 
在2.7及以前的版本都可以用Maven编译。

mvn package

执行成功后将会在gerrit-war/target/ 下生成对应版本的war包。
 
* 参考： <https://review.openstack.org/Documentation/dev-readme.html>
 
