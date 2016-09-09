---
layout: post
title: git diff 时忽略空格
categories: [cm, git]
tags: [cm, git, diff]
---

有时格式化过commit，会使得全文看起来都改变了，其实只是空格、tab的变化。

使用diff的ignore options可以忽略这些。

```
git diff

       --ignore-space-at-eol
           Ignore changes in whitespace at EOL.

       -b, --ignore-space-change
           Ignore changes in amount of whitespace. This ignores whitespace at line end, and considers all other sequences of
           one or more whitespace characters to be equivalent.

       -w, --ignore-all-space
           Ignore whitespace when comparing lines. This ignores differences even if one line has whitespace where the other
           line has none.
```

