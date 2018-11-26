---
layout: post
title: 使用jquery检查元素是否可见 visible
categories: [ dev, javascript ]
tags: [ jquery ]
---

---

* 参考
  * <https://stackoverflow.com/a/178450/3316529>

---

~~~ javascript
// Checks css for display:[none|block], ignores visibility:[true|false]
$(element).is(":visible"); 

// The same works with hidden
$(element).is(":hidden"); 
~~~




