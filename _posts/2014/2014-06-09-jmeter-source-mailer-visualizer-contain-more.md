---
layout: post
title: jmeter：修改源码，使mailer visualizer 在邮件中包含更多内容
description: 
categories: [cm, jmeter]
tags: [cm, jmeter]
---

修改MailerModel.java

\apache-jmeter-2.9_src\apache-jmeter-2.9\src\components\org\apache\jmeter\reporters\MailerModel.java

在add(SampleResult sample, boolean sendMails)函数中，

调用sendMail()发送邮件的地方，调整内容，例如，在邮件中加入assetion的result

```java
import org.apache.jmeter.assertions.AssertionResult;
...
...
//ADD BY WI, 2013-06-27
AssertionResult[] as_arr = sample.getAssertionResults();
String asstr = "\r\n==============================\r\n";
asstr += "Number of assertion results:" + as_arr.length + "\r\n";
asstr += "------------------------------\r\n\r\n";
for(int x=0; x<as_arr.length; ++x) {
    asstr += "[ " + x + " ]\r\n";
    asstr += as_arr[x].getFailureMessage() + "\r\n";
    asstr += "------------------------------\r\n\r\n";
}
asstr += "==============================\r\n";
//END

// REMOVE AND REPLACE
    // sendMail(getFromAddress(), addressList, getFailureSubject(), "URL Failed: "
           // + sample.getSampleLabel(), getSmtpHost(),
           // getSmtpPort(), getLogin(), getPassword(),
           // getMailAuthType(), false);
// BY
    sendMail(getFromAddress(), addressList, getFailureSubject(), "URL Failed: "
           + sample.getSampleLabel() + asstr, getSmtpHost(),
           getSmtpPort(), getLogin(), getPassword(),
           getMailAuthType(), false);
//END
```

