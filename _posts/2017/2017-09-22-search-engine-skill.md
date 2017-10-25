---
layout: post
title: 搜索引擎使用技巧，search engine skill
categories: [cm, web]
tags: [search-engine, baidu, 百度]
---

* 参考/摘自
  * [百度搜索支持哪些高级搜索指令和参数？](https://www.zhihu.com/question/23622803)
  * [百度高级搜索](https://www.baidu.com/gaoji/advanced.html)


## Baidu 百度


### site 搜索范围限定在特定站点中

您如果知道某个站点中有自己需要找的东西，就可以把搜索范围限定在这个站点中，提高查询效率。

* “site:”后面跟的站点域名，不要带“http://”。
* site:和站点名之间，不要带空格。

例如：
* `百度影音 site:www.skycn.com`
* `"离岸人民币 site:http://microbell.com"`


### intitle 搜索范围限定在网页标题

网页标题通常是对网页内容提纲挈领式的归纳。把查询内容范围限定在网页标题中，有时能获得良好的效果。

`intitle:` 和后面的关键词之间不要有空格。

例如: `出国留学 intitle:美国`




### inurl搜索范围限定在url链接中

网页url中的某些信息，常常有某种有价值的含义。您如果对搜索结果的url做某种限定，可以获得良好的效果。

例如：`auto视频教程 inurl:video`

查询词“auto视频教程”是可以出现在网页的任何位置，而“video”则必须出现在网页url中。






### 双引号“”和书名号《》精确匹配

查询词加上双引号“”则表示查询词不能被拆分，在搜索结果中必需完整出现，可以对查询词精确匹配。如果不加双引号“”经过百度分析后可能会拆分。

查询词加上书名号《》有两层特殊功能，一是书名号会出现在搜索结果中；二是被书名号扩起来的内容，不会被拆分。 书名号在某些情况下特别有效果，比如查询词为手机，如果不加书名号在很多情况下出来的是通讯工具手机，而加上书名号后，《手机》结果就都是关于电影方面的了。

### 减号 `-` 不含特定查询词

查询词用减号 `-` 语法可以帮您在搜索结果中排除包含特定的关键词所有网页。

例子：

* 查询词“电影”在搜索结果中，“qvod”被排除在搜索结果中。 `电影 -qvod`  
* 要搜寻关于"武侠小说"，但不含"古龙"的资料，可使用：`武侠小说 -古龙`
* 避免广告 `“注册会计师考试 -推广 -推广链接”`


### 加号 `+` 包含特定查询词

查询词用加号 `+` 语法可以帮您在搜索结果中必需包含特定的关键词所有网页。

例子：

* `电影 +qvod` 查询词“电影”在搜索结果中，“qvod”被必需被包含在搜索结果中。


### Filetype 搜索范围限定在指定文档格式中

查询词用 `Filetype` 语法可以限定查询词出现在指定的文档中，
支持文档格式有pdf，doc，xls，ppt，rtf,all(所有上面的文档格式)。对于找文档资料相当有帮助。

例子：

* `photoshop实用技巧 filetype:doc`
* `管理经济学复习题 filetype:pdf`


### 『』查找论坛版块

『』是直行双引号。『论坛版块名称』 。eg：`『影视交流』`.

符号的输入可以使用中文软键盘


### 查询网站24小时之内被收录的情况

在浏览器地址栏中输入如下url：`http://www.baidu.com/s?wd=site%3A（域名）&lm=1`

末尾的数字1表示1天内，那么查询7天的方法只需将末尾数字改为7即可，一个月和一年内的查询方法一样。这里需要注意的是只支持一天、七天、一个月、一年内以及全部时间段的搜索查询。【仅适用百度】


### 百度高级搜索页面

通过访问 [高级搜索](https://www.baidu.com/gaoji/advanced.html) 网址，
百度高级搜索页面将上面的所有的高级语法集成，用户不需要记忆语法，
只需要填写查询词和选择相关选项就能完成复杂的语法搜索。



### 怎么告诉百度，不要追踪我的浏览记录

“百度首页 -> "使用百度前必读“ -> "隐私权保护声明" -> "个性化配置工具设置" -> "选择停用”






## 其他技巧


### alilintitle

搜索返回的是标题中包含 **多关键词** 的页面。多个关键词间用空格分开。

如， 搜索 `alilintitle：秋夕 月舞`，相当于`intitle：秋夕 intitle：月舞`


### allinurl

搜索返回的是 url中包含 **多关键词** 的页面。多个关键词间用空格分开。


### 搜索 “开始连接”、“正在连接”

网络上有很多热心人提供***的下载地址。为了表明真实可靠，把下载过程也同时附上。
现在最流行的下载工具是flashget和迅雷。 Flashget下载开始就是“正在连接”，迅雷则是“开始连接”。

所以，**可以用想找的电影名字，加上“开始连接”或者“正在连接”，来寻找xxx**。 

检索式形式如：`电影名 开始连接`、`电影名 正在连接`、`电影名 (开始连接 | 正在连接)` 。

如：哈利波特4 开始连接 、倩女幽魂 正在连接 、史前一万年 (正在连接 \| 开始连接) 。
