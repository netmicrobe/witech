---
layout: post
title: notepad++ 正则表达式搜索不包含某个字符串的行
categories: [dev, regex]
tags: [regex, notepad++]
---

```
^((?!hede).)*$
```

The regex above will match any string, or line without a line break, not containing the (sub) string 'hede'.

* 参考： <http://stackoverflow.com/a/406408>