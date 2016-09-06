---
layout: post
title: OpenKM搭建手册
description: 
categories: [cm, openkm]
tags: [cm, openkm]
author: diaoys
---

OpenKM全称是Open Knowledge Management,是一个DMS(文档管理系统)。本文介绍如何在linux下安装它。

* OpenKM官网: <http://www.openkm.com/en/>
* 在线文档: <http://wiki.openkm.com/index.php/Main_Page>


## 下载openkm

下载openkm(在OpenKM首页点击右上角的Download OpenKM,进入下载页面http://www.openkm.com/en/download-
english.html。在这个页面选择Only Download,会出现一系列的下载链接。找到OpenKM Community Version,下载相应的
操作系统的版本,我选择的是openkm-6.3.0-community-linux-x64-installer.run)

![](/images/cm/openkm/openkm_download.png)

## 安装openkm

1. 上传openkm-6.3.0-community-linux-x64-installer.run安装包到服务器上,如(/opt/CM)
2. chmod +x /opt/CM/openkm-6.3.0-community-linux-x64-installer.run //赋予安装包执行权限
3. ./openkm-6.3.0-community-linux-x64-installer.run //开始安装
4. 安装中,只需要输入“Y”一路下去就可以了,除了第三个界面中,需要输入安装路径,如(/opt/openkm-6.3.0-
community)

## 启动/停止openkm

1. vi /opt/openkm-6.3.0-community/tomcat/conf/server.xml //更新下tomcat端口号,如9999
2. /opt/openkm-6.3.0-community/tomcat/bin/startup.sh //启动openkm
3. 杀掉openkm进程
  ```
  kill -9 `netstat -tlnp|grep 9999|awk '{print $7}'|awk -F '/' '{print $1}'`
  ```
4. 进入openkm
  1. 访问地址:http://192.168.251.63:9999/OpenKM/frontend/index.jsp
  2. 访问的默认管理员帐号:okmAdmin/admin

## 汉化openkm

1. 下载汉化文件

(http://wiki.openkm.com/index.php/Language_Packs),找到并下载,如(Chinese simple File:OpenKM 6 zh-CN.sql)。完成下载后,上传到服务器上

2. 登录到OpenKM里,在页面右上角有四个Tabs,点击最后一个Administration,进入配置页面。如下图所示。

![](/images/cm/openkm/change_lang_to_cn.png)

3. 按照图中所示,添加汉化包。导入成功后,刷新一下页面,或者重新登录。在菜单中选择“工具”->“语言”->“simplified Chinese”即可


## 配置文件预览功能

需要安装swftools和openoffice

### swftools

1. 下载地址:http://www.swftools.org/download.html
2. 下载包swftools-0.9.1.tar.gz(如果是092的包,则后续文件预览时会报错)
3. 上传swftools-0.9.1.tar.gz到服务器上(/opt/CM)
4. tar -zxvf swftools-0.9.1.tar.gz
5. ./configure --prefix=/usr/swftools
6. make
7. make install
8. vim /etc/profile =》 "export PATH=$PATH:/usr/swftools/bin/" //配置环境变量



### openoffice

1. 下载地址:http://www.openoffice.org/zh-cn/download/
![](/images/cm/openkm/download_openoffice.png)
2. 上传Apache_OpenOffice_4.1.1_Linux_x86-64_install-rpm_zh-CN.tar.gz到服务器上(/opt/CM)
3. tar -zxvf Apache_OpenOffice_4.1.1_Linux_x86-64_install-rpm_zh-CN.tar.gz
4. cd /opt/CM/openoffice/RPMS
5. rpm -ivh *.rpm (安装所有的rpm包,否则报错)
6. cd desktop-integration
7. ./openoffice4.1.1-redhat-menus-4.1.1-9775.noarch.rpm //安装 OpenOffice 桌面控制台 desktop-integration【未测试本步骤不执行的后果】
8. 最后一步,千万不要按网上说的去启动openoffice,否则openkm预览文件时会一直报错


## 配置openkm的系统参数


1. 系统参数的配置入口
![](/images/cm/openkm/settings_ui.png)
2. 配置的参数如下
<table>
<tr>
<td>Property</td>
<td>Value</td>
</tr>
<tr>
<td>application.url</td>
<td>http://192.168.251.63:9999/OpenKM/index.jsp</td>
</tr>
<tr>
<td>system.imagemagick.convert</td>
<td>/usr/bin/convert</td>
</tr>
<tr>
<td>system.openoffice.path</td>
<td>/opt/openoffice4</td>
</tr>
<tr>
<td>system.openoffice.port</td>
<td>8100</td>
</tr>
<tr>
<td>system.swftools.pdf2swf</td>
<td>/usr/swftools/bin/pdf2swf -T 9 -f -t -G -s storeallcharacters ${fileIn} -o ${fileOut}</td>
</tr>
</table>






