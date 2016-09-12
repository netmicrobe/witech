---
layout: post
title: 修改某个已提交的commit
categories: [cm, git]
tags: [cm, git]
---

You can use git rebase, for example, if you want to modify back to commit bbc643cd, run

```
$ git rebase --interactive bbc643cd^ 
```

In the default editor, modify 'pick' to 'edit' in the line whose commit you want to modify. Make your changes and then stage them with

```
$ git add <filepattern> 
```

Now you can use

```
$ git commit --amend 
```

to modify the commit, and after that

```
$ git rebase --continue 
```

to return back to the previous head commit.
