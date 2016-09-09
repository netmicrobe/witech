---
layout: post
title: Git Reversing patches
categories: [cm, git]
tags: [cm, git, patch]
---

参考：    <https://www.drupal.org/patch/reverse>


You can reverse a patch if you have finished testing it, or if you want to see whether a problem has been introduced by a particular patch. 

You should also reverse a patch prior to adding a newer, updated version of the same patch. 

To reverse the patch, use the patch command with the -R option:

patch -p1 -R < path/file.patch

(If your patch was applied with the -p0 option, use that instead.)

Or:

git apply -R path/file.patch




