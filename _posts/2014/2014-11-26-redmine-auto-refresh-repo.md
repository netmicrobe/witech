---
layout: post
title: 如何自动刷新Redmine的版本库
categories: [cm, redmine]
tags: [cm, redmine]
---

## 故事背景
 
Redmine项目关联版本库之后，在svn中提交，不会触发Redmine读取新的commit信息，只有刷新了“版本库”页面才会触发Redmine读取svn。



### Redmine刷新版本库的外部接口
 
Redmine提供了刷新版本库的外部接口，参见：

[“HowTo setup automatic refresh of repositories in Redmine on commit”](
http://www.redmine.org/projects/redmine/wiki/HowTo_setup_automatic_refresh_of_repositories_in_Redmine_on_commit)
 
/sys/fetch_changesets?key=<your service key>刷新所有版本库信息

/sys/fetch_changesets?id=<project identifier>&key=<your service key>

针对指定项目刷新版本库信息，id参数可以是项目的标识，也可以是项目的id。



### 启用Redmine版本库刷新接口
 
默认上述版本库刷新接口是不可用的，要开下Redmine的相应设置，还要生成下接口中需要的key。
 
登录Redmine 》 管理 》 配置 》 版本库




### 刷新接口为https时的问题
 
架设在https上的Redmine，在访问刷新接口时候可能会遇到证书问题。
 
直接使用curl，会报告curl: (60) SSL certificate problem

使用curl -k，企图忽略证书，Redmine报告500错误。
 
最后使用 wget --no-check-certificate 忽略证书检查




## 如何自动刷新Redmine的版本库
 
综上，定期触发Redmine版本库刷新接口就可以了。
 
如下方案是使用jenkins定期触发刷新接口，熟悉svn的话，也可以配置svn hook，在有新提交时候刷新接口。


### jenkins定期触发刷新接口

#### 编写刷新脚本
脚本refresh_repo_redmine34.sh内容如下：

{% highlight shell %}
#!/bin/bash
 
# 说明：
# 使用 wget --no-check-certificate 忽略证书检查
# 使用 wget -O- 使得wget不要下载文件到文件系统。
# 使用 sleep 1m   使得各项目刷新错开时间，降低Redmine压力。
 
# 项目A
wget -O- --no-check-certificate http://your-redmine-address/sys/fetch_changesets?key=your-api-key&id=project-a-id
sleep 1m
 
# 项目B
wget -O- --no-check-certificate http://your-redmine-address/sys/fetch_changesets?key=your-api-key&id=project-b-id
sleep 1m
 
{% endhighlight %}
 
 
#### 在jenkins中配置

将上述refresh_repo_redmine.sh拷贝到jenkins所在服务器上，例如：

/opt/redmine/refresh_repo_redmine.sh
 
创建一个job，配置每半小时执行一次该脚本。
 
 
 
## 参考

* <http://www.redmine.org/projects/redmine/wiki/HowTo_setup_automatic_refresh_of_repositories_in_Redmine_on_commit>
* <http://www.redmine.org/boards/2/topics/13245>
* <http://www.redmine.org/boards/2/topics/10933>
 
 
 
 