---
layout: post
title: npm 设置国内镜像
categories: [dev, javascript, nodejs]
tags: [javascript, nodejs, npm, mirror]
---

* 参考
  * [淘宝 NPM 镜像](http://npm.taobao.org/)
  * [国内优秀npm镜像推荐及使用](https://segmentfault.com/a/1190000002576600)
  * [cnblogs.com - pingfan1990 - npm国内镜像](http://www.cnblogs.com/pingfan1990/p/4703773.html)

---

### 设置淘宝源

~~~ shell
npm config set registry https://registry.npm.taobao.org

// 配置后可通过下面方式来验证是否成功
npm config get registry
~~~



### 设置官方源


~~~ shell
npm config set registry https://registry.npmjs.org/

# 或者不使用ssl，有时候证书不信任就装不了

npm config set registry http://registry.npmjs.org/
~~~





