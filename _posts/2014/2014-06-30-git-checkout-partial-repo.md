---
layout: post
title: git：checkout部分目录， sparse checkout
categories: [cm, git]
tags: [cm, git]
---

```
git init <repo>
cd <repo>
git remote add -f origin <url>
```

This creates an empty repository with your remote. Then do:

```
git config core.sparsecheckout true
```

Now you need to define which files/folders you want to actually check out. This is done by listing them in .git/info/sparse-checkout, eg:

```
echo "some/dir/" >> .git/info/sparse-checkout
echo "another/sub/tree" >> .git/info/sparse-checkout
```

Last but not least, update your empty repo with the state from the remote:

```
git pull origin master
```

* 参考：
  * <http://stackoverflow.com/a/13738951/3316529>
  * <http://jasonkarns.com/blog/subdirectory-checkouts-with-git-sparse-checkout/>
  * <http://schacon.github.io/git/git-read-tree.html#_sparse_checkout>