---
layout: post
title: 从其他git库导入commit
categories: [cm, git]
tags: [cm, git]
---

参考：<http://stackoverflow.com/questions/5120038/is-it-possible-to-cherry-pick-a-commit-from-another-git-repository/9507417#9507417>

### 栗子

```shell 
git --git-dir=../some_other_repo/.git \
format-patch -k -1 --stdout <commit SHA> | \
git am -3 -k
```

format-patch 将另外一个repo中的commit格式化为patch输出到stdout，git am将patch打到当前的repo

### 再来一个栗子

从另外的repo中迁移commit过来，例如：

```
git --git-dir=../php_yii/.git/ format-patch -k --stdout e39ff71..HEAD | git am -3 -k
```

* 注意： 这个例子迁移，不包括e39ff71，用数学区间表示：(e39ff71, HEAD]

要单独将e39ff71迁移，可以执行：

```
git --git-dir=../php_yii/.git/ format-patch -k -1 --stdout e39ff71 | git am -3 -k
```

说明：其中-1参照，表示只去一个commit

