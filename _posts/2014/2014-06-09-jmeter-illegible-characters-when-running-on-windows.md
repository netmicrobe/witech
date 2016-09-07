---
layout: post
title: jmeter：在windows上运行乱码
description: 
categories: [cm, jmeter]
tags: [cm, jmeter]
---

修改 ./bin/jmeter.bat ，在java命令执行的地方加入编码参数：-Dfile.encoding=UTF8

例如：

%JM_START% %JM_LAUNCH% %ARGS% %JVM_ARGS% -Dfile.encoding=UTF8 -jar "%JMETER_BIN%ApacheJMeter.jar" %JMETER_CMD_LINE_ARGS%





