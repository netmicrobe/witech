---
layout: post
title: 在 Jekyll 中自动生成目录
categories: [dev, jekyll]
tags: [jekyll, document]
---

## 使用 kramdown 的 markdown 语法生成目录

* 参考：
  * <https://about.gitlab.com/2016/07/19/markdown-kramdown-tips-and-tricks/#table-of-contents-toc>
  * <http://www.seanbuscay.com/blog/jekyll-toc-markdown/>
  * <https://github.com/gettalong/kramdown>
  * <https://www.zfanw.com/blog/jekyll-table-of-content.html>

~~~
无序列表的目录

* TOC
{:toc}

有序列表的目录

1. TOC
{:toc}

带样式的目录

<div class="panel radius" markdown="1">
**Table of Contents**
{: #toc }
*  TOC
{:toc}
</div>
~~~

### 带样式的目录的例子

~~~
<style>
.panel.radius {
    border-radius: 3px;
}
.panel {
    border-style: solid;
    border-width: 1px;
    border-color: #cbcbcb;
    margin-bottom: 1.25rem;
    padding: 1.25rem;
    background: #E4E4E4;
    color: #333;
}
.panel > :first-child {
    margin-top: 0;
}
.panel h1, .panel h2, .panel h3, .panel h4, .panel h5, .panel h6, .panel p, .panel li, .panel dl {
    color: #333;
}
</style>


<div class="panel radius" markdown="1">
**Table of Contents**
{: #toc }
*  TOC
{:toc}
</div>
~~~




## javascript 实现目录生成

* [I5ting ztree toc](http://i5ting.github.io/i5ting_ztree_toc/)
* [neo-hpstr-jekyll-theme](https://github.com/aron-bordin/neo-hpstr-jekyll-theme)



## Liquid 实现目录生成

* <https://allejo.io/blog/a-jekyll-toc-in-liquid-only/>
