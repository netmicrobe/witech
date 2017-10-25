---
layout: post
title: Jenkins Restful API
categories: [cm, jenkins]
tags: [restful, api]
---


* 参考
  * [Jenkins Github Project](https://github.com/jenkinsci/jenkins/tree/master/core/src/main/java/jenkins)
  * [jenkins.io - Remote access API](https://wiki.jenkins.io/display/JENKINS/Remote+access+API)




jenkins 的 REST API 帮助链接在页面底部，点进去后，是针对性的api帮助，例如，在某个job页面，进去就是 job 相关的 api 帮助。

如果当前页面没有“REST API”链接，说明当前页面功能不提供api支持。

<!-- more -->

## 通用说明

### 如何认证

api 要求以 http basic auth 方式传递 user:password 参数

### depth=?

这个参数决定返回内容多少。可以对 api 使用 depth=0 ， depth=1 分别试试。默认 `depth=0`。


## APIs


### buildWithParameters ： 启动job（带参数）

* method: POST
* path： `/jenkins/job/<job-name>/buildWithParameters`
* 参数: 
  * 以 form 格式传递 job 参数
* 返回: status=200 ，没有数据返回，然后直接跳转到job首页。



### build ： 启动job

* path： `/jenkins/job/<job-name>/build`




### job 信息

包含 builds 的信息，depth=1，会返回更多信息。

* method: GET
* path： `/jenkins/job/<job-name>/api/json`


### build 信息


包含单个 build 的信息：执行参数、执行结果等。

* method: GET
* path: `/jenkins/job/<job-name>/<build-id>/api/json`


### build console output

* path: `/jenkins/job/<job-name>/<build-id>/logText/progressiveText?start=0`
* 参数:
  * start: offset 的字节数
* 返回:
  * X-Text-Size header ，可以用于下次访问时的start参数
  * X-More-Data: true header, the server is indicating that the build is in progress, and you need to repeat the request after some delay。When this header is not present, you know that you've retrieved all the data and the build is complete.




## 如何使用jmeter 测试？

### Http Basic Authorization

* 参考： <https://stackoverflow.com/questions/12560494/jmeter-basic-authentication>

1. 添加 BeanShell PreProcessor 
    
    添加代码

    ~~~ java
    import org.apache.commons.codec.binary.Base64;
    byte[] encodedUsernamePassword = Base64.encodeBase64("your-name:your-pass".getBytes());
    vars.put("base64HeaderValue",new String(encodedUsernamePassword));
    ~~~

2. 添加 “HTTP Header Manager”，加入认证信息
  * header name **Authorization**
  * header value **Basic ${base64HeaderValue}**

















