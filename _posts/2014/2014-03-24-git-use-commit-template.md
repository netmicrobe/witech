---
layout: post
title: 在git中使用commit message模板
categories: [cm, git]
tags: [cm, git]
---

### 创建一个模板文件

例如：git_commit_template.txt

```
# [BUGFIX|TASK #???] [ Subject: One line only short meaningful description for logs ]===|
# refs: #???
```

### 设置下模板，下次提交就可以用了

```
git config --global  commit.template ～/git_commit_template.txt
```

## 参考：

<http://wiki.typo3.org/CommitMessage_Format_%28Git%29>



