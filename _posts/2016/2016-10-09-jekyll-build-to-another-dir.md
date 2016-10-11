---
layout: post
title: jekyll build 生成到其他目录，而非 _site
categories: [cm, jekyll]
tags: [cm, jekyll, githubs]
---

* 参考
  * <http://jekyllrb.com/docs/usage/>

## jekyll build 生成到其他目录

```
$ jekyll build --destination <destination>
# => The current folder will be generated into <destination>
```

## 什么时候用到?

github-pages 不支持插件，所以带插件的 jekyll site 不如将生成的 _site push 上去。

避免和source 库冲突，在其他目录生成 静态site，在push 到 githubs。
