---
layout: post
title: 设置与remote branch对应的track branch
categories: [cm, git]
tags: [cm, git]
---


## Git 1.7

```
git branch --set-upstream master origin/master
```



## As of Git 1.8.0:

```
git branch -u upstream/foo 
```

Or, if local branch foo is not the current branch:

```
git branch -u upstream/foo foo 
```

Or, if you like to type longer commands, these are equivalent to the above two:

```
git branch --set-upstream-to=upstream/foo

或

git branch --set-upstream-to=upstream/foo foo 
```