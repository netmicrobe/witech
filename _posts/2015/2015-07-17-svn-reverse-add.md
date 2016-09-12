---
layout: post
title: Undo that SVN add
categories: [cm, subversion]
tags: [cm, subversion]
---

参考：<http://data.agaric.com/undo-svn-add>

In Subversion, to cancel an svn add example_folder command before committing to the repository, do not use svn delete or svn remove or made-up stuff like undo or cancel.

Use the svn revert command:

```
svn revert --recursive example_folder
```


