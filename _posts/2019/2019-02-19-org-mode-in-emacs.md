---
layout: post
title: Emacs 中 org-mode 管理文档、工作记录
categories: [cm, emacs]
tags: [org-mode, LaTex]
---

* 参考： 
  * [Emacs AUCTeX and PDF Synchronization on Windows](https://www.barik.net/archive/2012/07/18/154432/)
  * [Writing LaTeX with Emacs on Windows](http://juanjose.garciaripoll.com/blog/latex-with-emacs-on-windows)
  * []()
  * []()
* Windows LaTex
  * [W32TeX](http://w32tex.org/)
  * [Miktex](https://miktex.org/)
  * [TexLive](http://www.tug.org/texlive/)




## recipes

### 导出为html

1. 安装 htmlize ：菜单 Options -- Manage Emacs Packages
2. `C-c C-e h`



### Windows 安装 TexLive

* 参考： [TeX Live for windows 安装及更新](https://blog.csdn.net/wanghuiict/article/details/51001902)

1. <http://www.tug.org/texlive/> 下载 install-tl-windows.exe 
    或者下载 `install-tl.zip` 后运行 `install-tl-windows.bat`
2. 全部安装太大了，2018有5G以上，在安装界面选择
    * 安装方案：custom selection of collections
    * "Installation collections"：Essential programs and files；LaTex fundamental packages；chinese；windows-only support programs
      大概500M+
    * Portable Setup选择了“是”
3. 选好设置，点击“安装 Tex Live”，程序自动下载并安装，要花些时间了。
4. 安装完成之后，设置Path环境变量加上tex live的二进制程序目录。这里是 `C:\texlive\2018\bin\win32`


#### 使用 tlmgr 安装 TeXworks

~~~
tlmgr install texworks

tlmgr info texworks
package:     texworks
category:    TLCore
shortdesc:   friendly cross-platform front end
longdesc:    See http://tug.org/texworks for information and downloads. TeX Live includes executables and support files only for Windows.
installed:   Yes
revision:    45650
sizes:       doc: 5k, bin: 42585k
relocatable: No
collection:  collection-texworks
~~~










