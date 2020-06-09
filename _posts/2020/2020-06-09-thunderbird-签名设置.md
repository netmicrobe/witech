---
layout: post
title: thunderbird-签名设置, signature
categories: [cm, mail]
tags: [mail, thunderbird]
---

* 参考： 
  * [Signatures - support.mozilla.org](https://support.mozilla.org/en-US/kb/signatures)
  * [Removing the '--' signature separator in Mozilla Thunderbird](https://www.calzadamedia.com/knowledgebase/kb308/removing-the-signature-separator-in-mozilla-thunderbird/)
  * []()



1. Tools \> Options \> Account Settings \> your-account-name
1. 设置 `Signature Text`



* 去除签名上面的2个小横
1. Tools \> Options \> Advanced \> General \> Config Editor
1. mail.identity.default.suppress_signature_separator 设置为 true


* 签名出现在回复正文后面，而不是所有邮件最底部

1. Tools \> Options \> Account Settings \> Composition & Addressing
1. `and place my signature` 选中 `below my reply(above the quote)`









