---
layout: post
title: 使用bat脚本备份mysql数据库
description: 
categories: [cm, mysql]
tags: [cm, mysql, backup, windows, bat, 7-zip]
---

wiphone 项目的例子：

```
@echo off

set var="%date:~,4%%date:~5,2%%date:~8,2%"
echo %var%

C:\server\xampp-win32-1.8.1-VC9\xampp\mysql\bin\mysqldump --extended-insert=false --hex-blob=true --opt -u wiphone --password=your-pass --port=3306 wiphone  > .\%var%

rem d:\BitNami\redmine-2.1.4-0\mysql\bin\mysqld -nt

rem if installed winrar, zip it
rem winrar a -df -agYYYYMMDD-HHMMSS .zip %var%

rem use 7-zip
%~dp07za a -tzip %var%.zip %var%
del %var%


rem echo . & pause
```