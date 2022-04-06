---
layout: post
title: thunderbird-默认按日期近到远排序
categories: [cm, mail]
tags: [mail, thunderbird]
---

* 参考： 
  * [Change the default sorting order in Thunderbird](https://superuser.com/a/13551)
  * []()



1. Tools \> Options \> Advanced \> General \> Config Editor
    91.8.0 版本的位置： 菜单 \> Preference \> 搜索 Config Editor
1. `mailnews.default_sort_type` : 18
1. `mailnews.default_sort_order` 从 1（ascending）改为 2（descending）


更多设置：

~~~
Preference Name                      Status       Type        Value
mailnews.default_news_sort_order:    default      integer     x
mailnews.default_news_sort_type:     default      integer     y
mailnews.default_sort_order:         default      integer     x
mailnews.default_sort_type:          default      integer     y
~~~

**x** (see <https://developer.mozilla.org/en/nsMsgViewSortOrder>)

~~~
1 = Ascending
2 = Descending
~~~

**y** (see https://developer.mozilla.org/en/nsMsgViewSortType)

~~~
17 = None
18 = Date
19 = Subject
20 = Author
21 = ID (Order Received)
22 = Thread
23 = Priority
24 = Status
25 = Size
26 = Flagged
27 = Unread
28 = Recipient
29 = Location
30 = Label
31 = Junk Status
32 = Attachments
33 = Account
34 = Custom
35 = Received
~~~


