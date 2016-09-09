---
layout: post
title: git attributes 保持dos文件的crlf ， 下载到linux不被替换成lf
categories: [cm, git]
tags: [cm, git]
---

* 参考
  * <http://git-scm.com/docs/gitattributes>
  * <http://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes>

例子：csv文件保持 crlf ，方便 mysql load data 脚本导入数据

在csv所在目录下创建  .gitattributes 文件，添加：
*.csv eol=crlf

提交进版本库，下载linux上，git也会尊重设置的属性，不再将crlf修改为lf。




