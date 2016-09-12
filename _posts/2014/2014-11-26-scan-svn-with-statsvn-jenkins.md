---
layout: post
title: 如何使用Statsvn和Jenkins定期扫描代码
description: 
categories: [cm, subversion]
tags: [cm, subversion, QA, code-statistic]
---

## Statsvn简介

官网：http://www.statsvn.org/

参考：http://wiki.statsvn.org/User%20Manual.ashx

代码地址：svn co http://svn.code.sf.net/p/statsvn/code/trunk
 
优点： 开源，Java跨平台，能够生成直观的统计图表

缺点： 扫描能力较弱，空行和注释不能区分统计
 
### 如何使用Statsvn

步骤[1]    svn log --xml生成xml格式的log文件

步骤[2]    运行statsvn.jar，程序根据第一步生成的log文件，来生成统计结果文件。结果文件由格式良好的html文件和统计图表图片文件组成）。
 
简单的例子：

```
svn log -v --xml > logfile.log
java -jar statsvn-0.7.0/statsvn.jar D:/open_source/statSVN/statsvn-code/logfile.log D:/open_source/statSVN/statsvn-code/
```
 
## 使用Statsvn和Jenkins定期扫描代码

### 方案的思路：

1、  jenkins将需要的代码checkout出来
2、  jenkins调用statsvn的封装脚本，脚本扫描代码并生成结果文件
3、  httpserver指向结果文件的地址
 
### 方案实例
 
#### jenkins checkout 代码
 
和jenkins配置svn checkout代码基本一样，除非不是将svn库所有代码都扫描，目标代码散落在库中，这里的例子就是这样。
 
如下图，要先配置父目录结构，再以保持目录结构的方式，一部分一部分的checkout模块代码。

![](/images/cm/svn/statsvn/checkout_by_jenkins.png)

 
#### statsvn的封装脚本
 
脚本的代码在gerrit上的statsvn项目中，各文件的说明如下：

![](/images/cm/svn/statsvn/statsvn_dir_structure.png)

将所有脚本上传到jenkins服务器上，例如，/opt/statsvn
 
#### jenkins中设置job

* 设置执行脚本

在jenkins中设置checkout完代码后，执行对应的statsvn封装脚本。

Build > Execute Shell

填写：/opt/statsvn/gen_androidclient.sh

 
* 设置定期扫描

下例设置表示每周一到周五，凌晨1点，扫描下。

Build Trigger > Build Periodically > 填写；0 1 * * 1-5
 
* 设置出错邮件提醒

Post-build Actions > Editable Email Notification

1. Project Recipient List: your-email-address@your-corp.com
2. Project Reply-To List: $DEFAULT_REPLYTO
3. Content Type: Default Content Type
4. Default Subject: $DEFAULT_SUBJECT
5. Default Content: $DEFAULT_CONTENT


 
#### httpserver指向结果文件的地址
 
参照statsvn封装脚本，结果文件将会放在/opt/statsvn/result对应的项目目录中。

将result目录设置为http-server的虚拟站点即可。

 
##$ 对已有项目更新svn路径
 
调整2个地方：

1. jenkins job中svn checkout代码的地方
2. statsvn封装脚本中include参数的地方


## 疑难问题

### 生成图表中，中文为乱码
 
linux上安装下中文字体就好了。
 
在系统上安装下对应的中文字体。

linux的字体从如下地址下载后，拷贝到 /usr/share/fonts/  ，如果还没效果执行下 fc-cache -v -f
 
linux的中文字体  http://pan.baidu.com/s/1bncZuJt

