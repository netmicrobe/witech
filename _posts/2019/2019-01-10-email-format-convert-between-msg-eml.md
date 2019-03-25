---
layout: post
title: eml 和 msg 邮件格式互转
categories: [ cm, email ]
tags: [email, outlook, foxmail, thunderbird]
---


## 使用 MIME/MSG Mail Converter (free)

1. 在 <https://labs.rebex.net/mail-converter> 下载 `MailConverter.exe`
2. 命令行执行格式转换
    ~~~
    syntax: MailConverter.exe -tomime|-tomsg sourcepath targetpath

    Example: MailConverter.exe -tomsg C:\mail.eml C:\mail.msg
    Example: MailConverter.exe -tomime C:\mail.msg C:\mail.eml
    ~~~


### 文件结构

~~~
$ find RebexMailConverter/
RebexMailConverter/
RebexMailConverter/MailConverter.exe
RebexMailConverter/MailConverter.exe.config
RebexMailConverter/README.TXT
RebexMailConverter/to-eml.bat
RebexMailConverter/README_WI.TXT
~~~

### 封装脚本


* to-eml.bat

参考： <https://stackoverflow.com/a/9848832/3316529>

~~~ bat
@echo off

REM msg 转化为 eml
REM 拖动 一个或多个msg 文件到 to-eml.bat
REM 或，拖动 一个文件夹 到 to-eml.bat

cd /d %~dp0

if exist %~f1\NUL (
	echo drag a directory to me
	for %%a in (%~f1\*.msg) do (
	   MailConverter.exe -tomime "%%~fa" "%%~dpa%%~na.eml"
	)
) else (
	echo drag files to me
	for %%a in (%*) DO (
	  MailConverter.exe -tomime "%%~fa" "%%~dpa%%~na.eml"
	)
)


pause
~~~

版本二，转换结束，删除msg文件

~~~ bat
@echo off

REM msg 转化为 eml
REM 拖动 一个或多个msg 文件到 to-eml.bat
REM 或，拖动 一个文件夹 到 to-eml.bat

cd /d %~dp0

if exist %~f1\NUL (
	echo drag a directory to me
	for %%a in (%~f1\*.msg) do (
	   MailConverter.exe -tomime "%%~fa" "%%~dpa%%~na.eml"
	   DEL /Q /F "%%~fa"
	)
) else (
	echo drag files to me
	for %%a in (%*) DO (
	  MailConverter.exe -tomime "%%~fa" "%%~dpa%%~na.eml"
	   DEL /Q /F "%%~fa"
	)
)


pause
~~~



















