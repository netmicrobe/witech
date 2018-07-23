---
layout: post
title: JQuery UI widget checkboxradio 用法
categories: [ dev, javascript ]
tags: [ jquery-ui ]
---

---

* 参考
  * [Jquery UI Api Doc - Checkboxradio Widget](https://api.jqueryui.com/1.12/checkboxradio/)
  * <https://stackoverflow.com/questions/15644051/how-to-correctly-change-checkbox-radio-state-un-jquery-1-9-jquery-mobile-apps>
  * []()
  * []()
---

### 初始化

~~~ javascript
$(document).ready(function(){
  $( "input.tags" ).checkboxradio({
    icon: false
  });
});
~~~


### 设置选中状态

~~~ javascript
// to check it

$("#" + IDProduct).prop("checked", true).checkboxradio("refresh");

// to un-check it

$("#" + IDProduct).prop("checked", false).checkboxradio("refresh");

// status

$("#" + IDProduct).prop("checked") true/false

~~~














