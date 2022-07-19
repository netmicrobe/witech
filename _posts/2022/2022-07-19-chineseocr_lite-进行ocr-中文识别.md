---
layout: post
title: chineseocr_lite-进行ocr-中文识别，关联 
categories: [ cm, windows ]
tags: []
---

* 参考
  * [github.com - DayBreak-u/chineseocr_lite](https://github.com/DayBreak-u/chineseocr_lite)
  * [github.com - alisen39/TrWebOCR](https://github.com/alisen39/TrWebOCR)
  * [github.com - breezedeus/cnocr](https://github.com/breezedeus/cnocr)
  * [6 个优秀的开源 OCR 光学字符识别工具](https://www.oschina.net/news/40027/6-opensource-ocr-tools)
  * []()
  * []()


1. 加入 DayBreak-u/chineseocr_lite 的QQ群 185905924，群文件下载 `ocrserver64(win10).rar`
1. 解压 `ocrserver64(win10).rar`，双击启动 `ocrserver64.exe`
1. 按命令行提示，用浏览器访问 `http://127.0.0.1:8080/`
1. 目前只能一张一张的传图片进行ocr

* 执行`ocrserver64.exe`，报错：找不到 `VCOMP140.DLL`
    1. <https://docs.microsoft.com/en-us/archive/blogs/jagbal/where-can-i-download-the-old-visual-c-redistributables> 下载并安装 2015的DotNet框架 `vc_redist.x64.exe`

* 执行`ocrserver64.exe`，报错：找不到 `vcruntime140_1.dll`
    1. <https://link.zhihu.com/?target=https%3A//cn.dll-files.com/vcruntime140_1.dll.html> 下载 `vcruntime140_1.dll`
    1. 拷贝 `vcruntime140_1.dll` 到 `C:\Windows\System32`
    * 参考： 
        * <https://zhuanlan.zhihu.com/p/353260018>
        * <https://blog.csdn.net/littlehaes/article/details/104127787>
