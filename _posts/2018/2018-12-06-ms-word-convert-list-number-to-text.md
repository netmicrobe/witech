---
layout: post
title: WORD文档中的自动编号格式去掉，但还要保留原编号内容
categories: [ cm, microsoft ]
tags: [office, word, macro]
---

* 参考
  * <https://bbs.csdn.net/topics/220012068>

## 使用宏

1. 右键功能区 -》勾选“开发工具”
1. 进入“开发工具”功能区 -》 宏 -》输入宏名称 `ConvertListNumbersToText`，创建
1. 宏内容
    ~~~ vb
    Sub ConvertListNumbersToText()
    '
    ' ConvertListNumbersToText 宏
    '
    '
        Dim kgslist As List
        For Each kgslist In ActiveDocument.Lists
            kgslist.ConvertNumbersToText
        Next
    End Sub
    ~~~





