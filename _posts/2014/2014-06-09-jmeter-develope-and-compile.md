---
layout: post
title: 修改编译jmeter源码
description: 
categories: [cm, jmeter]
tags: [cm, jmeter]
---

如何编译源代码

第一次编译，运行 ant download_jars 下载依赖包。

直接在根目录下执行：
```
# ant
```

编译完成后，执行bin/jmeter.bat 可运行。

编译源代码后，如何发布
 
将编译好的 bin/ 和 lib/ extra/ 文件夹 覆盖当前的jmeter 版本。





