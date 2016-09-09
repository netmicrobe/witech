---
layout: post
title: 将某个commit或其中某个文件修改提取出来
categories: [cm, git]
tags: [cm, git]
---


### git cherry-pick

git cherry-pick -n <hash>...
-n 表示不会立即提交。 




### git apply

```
git diff a4858b2^..a4858b2 statsvn/src/net/sf/statsvn/input/XcqcRepositoryManager.java | git apply
```

注意，执行时所在的目录





### git patch

```
git format-patch -1 -k --stdout a4858b2 statsvn/src/net/sf/statsvn/input/XcqcRepositoryManager.java | git am -3 -k
```

这个命令执行完成，会立即提交。一般这个不是我们想要的，我们只想将原来的修改，应用到当前文件，省掉重复劳动。




### 使用通用patch

生成通用 patch

```
git diff startHash..endHash > some-feature.patch
```

应用通用 patch

```
patch -p0 < some-feature.patch
```
