---
layout: post
title: git navigate commit tree
categories: [cm, git]
tags: [cm, git]
---


## tree-ish

git的专有名词。表示指向commit的引用。

包括hash、HEAD、branch reference、tag reference、、

parent commit

```
当前commit+尖符^，例如，HEAD^、acf87504^、master^
当前commit~前移一个，例如，HEAD~1，或者干脆：HEAD～
```

grandparent commit

```
HEAD^^、ACF87504^^、master^^
HEAD~2
```


## Exploring tree listings

```
git ls-tree <tree-ish> <file-or-dir-or-省略>
```




## git log

```
git log --oneline
git log -3    #最近的3个commit
git log --since="2014-01-16"
git log --until="2014-01-16"
git log --since="2 weeks ago" --until="3 days ago"
也可以是：git log --since=2.weeks --until=3.days
git log --author="part-of-the-author-name"
git log --grep="part-of-commit-message"
git log <start-commit-not-include>..<end-commit-可省略，省略表示一直到HEAD> <文件名-也可以省略>
git log -p c5b93.. index.html    显示patch到standout
git log --stat --summary    显示commit有哪些文件修改了，以及修改的统计信息
git log --graph    在命令行显示log history
git log --oneline --graph -all --decorate

git log --format=oneline    # 和上一句的区别是，这句执行后显示长hash。
git log --format=short
git log --format=full
git log --format=fuller
git log --format=email
git log --format=raw
```



## git show

```
git show <tree-ish>   # 显示commit信息和diff信息
git show --format=oneline <tree-ish>  #commit信息显示在一行
```


## Comparing Commits

```
git diff <tree-ish>    # <tree-ish>的commit与当前工作目录，所有改动的diff
git diff <tree-ish> <file-path>

git diff <tree-ish>..<tree-ish>  # 2个commit之间的diff
git diff <tree-ish>..<tree-ish> <file-path>

git diff --summary <tree-ish>..<tree-ish>  # 哪些目录、文件改变了
git diff --stat --summary <tree-ish>..<tree-ish> # stat 也即 statistic，显示diff的统计结果
git diff -b 也即 --ignore-space-change
git diff -w 也即 --ignore-all-space
```











