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























