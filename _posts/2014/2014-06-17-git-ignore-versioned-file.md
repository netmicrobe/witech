---
layout: post
title: git 忽略已入库的文件的更新
categories: [cm, git]
tags: [cm, git]
---

Fortunately GIT has a very easy solution for this, just run the following command on the file or path you want to ignore the changes of:

git update-index --assume-unchanged <file>

If you wanna start tracking changes again run the following command:

git update-index --no-assume-unchanged <file>