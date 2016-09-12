---
layout: post
title: 为gerrit配置git
categories: [cm, git]
tags: [cm, git, gerrit]
---

```
git config remote.review.pushurl ssh://<GERRIT_HOST>:29418/<PROJECT_PATH>.git
git config remote.review.push refs/heads/*:refs/for/*
git push review # this will push your current branch up for review
```

```
[remote "review"]
url = ssh://msohn@egit.eclipse.org:29418/egit.git
fetch = +refs/heads/*:refs/remotes/origin/*
fetch = +refs/notes/review:refs/notes/review
push = HEAD:refs/for/master
[remote "review-1.0"]
pushurl = ssh://msohn@egit.eclipse.org:29418/egit.git
push = HEAD:refs/for/stable-1.0
```

for pushing to code review for refs/for/master I say

```
$ git push review
```

and for stable-1.0 code review I say

```
$ git push review-1.0
```


