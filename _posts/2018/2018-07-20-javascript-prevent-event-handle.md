---
layout: post
title: Javascript 停止默认的时间处理
categories: [ dev, javascript ]
tags: [  ]
---

---

* 参考
  * <https://stackoverflow.com/a/1357151>
  * []()
  * []()
---

1. event.preventDefault()
    ~~~ javascript
    $('a').click(function (e) {
        // custom handling here
        e.preventDefault();
    });
    ~~~

2. return false

    ~~~ javascript
    $('a').click(function () {
        // custom handling here
        return false;
    });
    ~~~


return false from within a jQuery event handler is effectively the same as calling both e.preventDefault and e.stopPropagation on the passed jQuery.Event object.

e.preventDefault() will prevent the default event from occuring, e.stopPropagation() will prevent the event from bubbling up and return false will do both. Note that this behaviour differs from normal (non-jQuery) event handlers, in which, notably, return false does not stop the event from bubbling up.









