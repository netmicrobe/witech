---
layout: post
title: markdown 中如何创建页面内的跳转链接（anchor）
categories: [dev, markdown]
tags: [markdown, anchor]
---

1. 埋anchor

    ~~~ markdown
    ### <a name="pookie"></a>Some heading
    ~~~

    或者

    ~~~ markdown
    ### Some heading
    [](){: name="pookie"}
    ~~~

2. 写跳转链接

    ~~~ markdown
    Take me to [pookie](#pookie)
    ~~~





