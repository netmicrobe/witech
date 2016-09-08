---
layout: post
title: 整合gerrit和redmine
categories: [cm, redmine]
tags: [cm, redmine, gerrit]
---

## 关联redmine项目和gerrit中的项目。


在redmine项目设置中指明对应的gerrit项目git库位置。

在redmine项目的设置 Settings > Repositories > New Repository 中创建关联：

```
SCM:git
Main repository: check it if it's main
Identifier:hiworkflow
Path to Repository: G:\server\gerrit\gerrit_server_2.8.1\git\hiworkflow.git
```

其他默认，点击创建。
 
## 在redmine comments中引用commit

commit:\<sha-of-commit\>sha长短皆可。

例如：

```
commit:d675f2e5c
commit:d675f2e5cd6bd87f45246422a79b0c4b93f366c4
```
 
 
## 在commit中引用redmine的issue

 
默认的引用关键字是refs、references、IssueID

如下commit message就可以将issue和commit建立连接，将会在该issue的详情也显示commit信息。

COMMIT MESSAGE:

> fix issueID #2 : can readmine recognize it!

### “引用关键字”设置

“引用关键字”可以在 Administration > Settings > Repositories中设置。

“Fixing keywords”/“用于解决问题的关键字” 也可以在其中设置。搜索到commit中的Fixing关键字，可以改变状态和完成度。

### 注意点

* 在commit搜索这些关键字都不区分大小写。
* 提交完成后要点击下项目的Repository标签卡，才能将commit message中内容同步到redmine数据库中。
 
 
## 参考

* <http://www.redmine.org/projects/redmine/wiki/RedmineSettings#Referencing-issues-in-commit-messages>
* <http://www.redmine.org/projects/redmine/wiki/HowTo_Easily_integrate_a_%28SSH_secured%29_GIT_repository_into_redmine>
 
 
 
 