---
layout: post
title: thunderbird-profile文件在virtualbox共享目录，丢失配置
categories: [cm, mail]
tags: [mail, thunderbird]
---

* 参考： 
  * [bugzilla.mozilla.org - Bug 1497819 Session.json info is lost in via network file shared folder, losing customizations](https://bugzilla.mozilla.org/show_bug.cgi?id=1497819)
  * [bugzilla.mozilla.org - data loss 相关bugs](https://bugzilla.mozilla.org/buglist.cgi?bug_type=defect&classification=Client Software&classification=Developer Infrastructure&classification=Components&classification=Server Software&classification=Other&f1=short_desc&f2=component&f3=OP&f4=short_desc&f5=longdesc&f6=CP&keywords=dataloss&keywords_type=allwords&o1=nowordssubstr&o2=nowordssubstr&o4=anywordssubstr&o5=anywordssubstr&product=MailNews Core&product=Thunderbird&resolution=---&short_desc=network share&short_desc_type=anywordssubstr)
  * [Files and folders in the profile - Thunderbird](http://kb.mozillazine.org/Files_and_folders_in_the_profile_-_Thunderbird)
  * []()



## 现象

1. profile文件在virtualbox共享目录，丢失配置

1. 这个问题只有虚拟机的host系统是Windows的时候发生，linux和mac都正常。

1. 这个问题 Thunderbird 60 开始出现

1. Tools \> Developer Tools \> Error Conosle 显示类似如下报错信息：
    ~~~
    "Win error 32 during operation rename on file F:\Thunderbird\default\extensions.json". The process cannot access the file because it is already used by another process. 
    resource://gre/modules/DeferredTask.jsm:313:7
    self-hosted:1229:9
    ~~~


## 分析

It seems that Thunderbird saves the settings the following way:

1. save the latest settings in .tmp files
2. delete the original files
3. rename the .tmp files to the original files

And it seems that the last step does not work. Maybe because the network drive still performes step 2 at this moment?
Maybe there is some retry and/or some waiting time necessary between step 2 and step 3 ?

## work around

The settings are preserved if I manually rename the files before starting Thunderbird:

~~~
ren extensions.json.tmp extensions.json
ren session.json.tmp session.json
ren sessionCheckpoints.json.tmp sessionCheckpoints.json
ren xulstore.json.tmp xulstore.json
ren addons.json.tmp addons.json
~~~









