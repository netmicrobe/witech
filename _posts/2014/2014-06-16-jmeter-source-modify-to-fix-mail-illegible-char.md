---
layout: post
title: jmeter：修改源码，解决邮件乱码问题
description: 
categories: [cm, jmeter]
tags: [cm, jmeter, illegible, java]
---

jmeter的邮件在Outlook、foxmail中显示为乱码，原因是：jmeter发送的时候没设置content type。

修改src/components/org/apache/jmeter/reporters/MailerModel.java

Sendmail的地方，将MimeMessage的Content-Type设置下就好了

```java
  // create a message
  Message msg = new MimeMessage(session);

  msg.setFrom(new InternetAddress(from));
  msg.setRecipients(Message.RecipientType.TO, address);
  msg.setSubject(subject);
  msg.setText(attText);
  
  // 加入下面这句，设置Content-Type为UTF8
  msg.setHeader("Content-Type", "text/plain; charset=UTF-8");
  Transport.send(msg);
```

参考：
<http://stackoverflow.com/questions/15044027/utf-8-charset-doesnt-work-with-javax-mail>
