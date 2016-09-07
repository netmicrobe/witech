---
layout: post
title: Windows数据库备份mysql
categories: [cm, mysql]
tags: [cm, mysql]
---


下面脚本需要在脚本同目录下放置7za.exe

{% highlight bat %}

@echo off

set var="%date:~,4%%date:~5,2%%date:~8,2%"
echo %var%

C:\server\xampp-win32-1.8.1-VC9\xampp\mysql\bin\mysqldump --extended-insert=false --hex-blob=true --opt -u redmine --password=2013Pwd --port=7306 redmine  > .\%var%

rem d:\BitNami\redmine-2.1.4-0\mysql\bin\mysqld -nt

rem if installed winrar, zip it
rem winrar a -df -agYYYYMMDD-HHMMSS .zip %var%

rem use 7-zip
%~dp07za a -tzip %var%.zip %var%
del %var%


rem echo . & pause

{% endhighlight %}

