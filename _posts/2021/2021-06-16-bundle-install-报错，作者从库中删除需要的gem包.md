---
layout: post
title: bundle-install-报错，作者从库中删除需要的gem包，例如，mimemagic
categories: [ dev, ruby ]
tags: [ rails, rake, bundle, mimemagic, redmine ]
---

---

* 参考
  * [mimemagicrb / mimemagic github 主页](https://github.com/mimemagicrb/mimemagic)
  * [gems - mimemagic - All Versions](https://rubygems.org/gems/mimemagic/versions)
  * [stackoverflow.com - Your bundle is locked to mimemagic (0.3.5), but that version could not be found in any of the sources listed in your Gemfile ](https://stackoverflow.com/a/66921259)
  * []()
---


## 例子： mimemagic (0.3.3) 的作者将它从gems库里面删除了，再bundle install mimemagic -v 0.3.3 版本会报错.


* **报错信息**

~~~
Resolving dependencies...
Your bundle is locked to mimemagic (0.3.3), but that version could not be found in any of the
sources listed in your Gemfile. If you haven't changed sources, that means the author of
mimemagic (0.3.3) has removed it. You'll need to update your bundle to a version other than
mimemagic (0.3.3) that hasn't been removed in order to install.
~~~


* **处理办法**

1. 到github 找到 mimemagic 项目地址： <https://github.com/mimemagicrb/mimemagic>
1. 找到 mimemagic (0.3.3) 对应的hash后，修改Gemfile：

~~~
gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: 'd5ebc0cd846dcc68142622c76ad71d021768b7c2'
~~~






































































































