---
layout: post
title: bootstrap row 中，如何使得所有 col 的高度和一行中最高 col 一样
categories: [dev, web]
tags: [web, css, flex, bootstrap]
---

* 参考：
  <https://stackoverflow.com/a/23305885>
  <http://acmetech.github.io/todc-bootstrap-3/examples/equal-height-columns/>

~~~css
/*
enhance bootstrap 3
Note that flexbox isn't supported in IE<10.

refer to: 
  https://stackoverflow.com/a/23305885
  http://acmetech.github.io/todc-bootstrap-3/examples/equal-height-columns/

*/

.row-eq-height {
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
}
~~~

row 多加一个 row-eq-height

~~~html
<div class="row row-eq-height">
</div>
~~~




