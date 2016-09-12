---
layout: post
title: subversion, 在windows上架设svn server，并创建repository
categories: [cm, subversion]
tags: [cm, subversion, windows]
---

## 下载svn

在subversion官网下载svn-win32-1.7.14-ap24.zip
http://subversion.apache.org/
http://subversion.apache.org/download/#recommended-release

## 安装、启动svn

解压然后执行svnserve就可启动svn server了

```
cd E:\server\subversion\svn-win32-1.7.14\bin
svnadmin create D:\tmp\svn\repo\hiredmine
svnserve -d -r D:\tmp\svn\repo
```

注意：在新库（如上例，hiredmine）的conf目录下设置用户，重启svnserve后才能正常使用。
否则，只能checkout，不能commit

### 配置svn用户

1）conf/svnserve.conf 设置用户设置文件为当前目录的passwd：

password-db = passwd

2）在passwd文件中配置用户

例如：

```
[users]
sally = sallyssecret
```

### 调试方式启动svn

调式用的话可以加个 --foreground

```
svnserve --foreground -d -r /cygdrive/d/tmp/svn/repo
```



## 客户端checkout
svn co svn://localhost/hiredmine

* 参考：
  * <http://svnbook.red-bean.com/en/1.7/svn.serverconfig.svnserve.html>



## 创建SVN repository

```
svnadmin create /var/svn/your-repo
```

* 参考：
  *<http://svnbook.red-bean.com/en/1.7/svn.reposadmin.create.html>










