---
layout: post
title: git repository 整理维护
categories: [cm, git]
tags: [cm, git]
---

### 清除暂存区操作时引入的临时对象

```
git prune
```



### 放弃所有reflog，默认90后才过期

```
git reflog expire --expire=now --all 让所有reflog的记录过期
git prune

git gc
```

或者，无视2周过期的限制，直接运行：  git gc --prune=now




### 检查是否有dangling的object

```
git fsck
```

