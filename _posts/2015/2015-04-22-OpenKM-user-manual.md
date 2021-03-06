---
layout: post
title: OpenKM文档管理系统使用手册
description: 
categories: [cm, openkm]
tags: [cm, openkm, cms]
author: diaoys
---

## OpenKM介绍

OpenKM是一个文档管理系统,用于组织和共享文档。可以通过名称,内容,关键字等来搜索文档。

基于Jboss+J2EE+Ajax web(GWT)+Jackrabbit(lucene)等开发。

### 功能介绍

1 支持多语言功能
2 网站多样式
3 上传,下载(把修改后的文件上传或下载后修改;只可以上传MIME在配置文件里有写明)
4 版本控制
5 回收站(删除文件后具有恢复功能)
6 文档分类管理
7 用户权限管理
8 搜索引擎(可提供查找功能)
9 每个用户一个session

### 开发用的功能

1 工作流(workflow)
2 Email通知机制
3 用LDAP存储用户的信息
4 web spider 一种搜索引擎
5 用户空间控制
6 收藏夹
7 文件修改后通知机制
8 我的文档(存个人的文档)

## 登录退出用户

### 登录用户

打开页面http://113.31.29.146:8080/OpenKM(注意OpenKM大小写)

默认管理员账号:用户名 okmAdmin 密码 admin

![](/images/cm/openkm/login_ui.png)

### 退出用户

点击菜单栏中的【文件】——【退出】按钮即可,如下图:

![](/images/cm/openkm/logout_ui.png)

非正常关闭再次登录系统后,会提示该用户已登录并报错。

注意:退出是请按照如上图方法退出用户,如果直接关闭浏览器下次登录该用户会提示报错。


## 新建目录

### 系统界面

目录可分为公共文档,自定义分类,知识库,模板,我的文档,电子邮件,回收站几种。

* 【我的文档】用于存放私人文件,只有文件拥有者才有权查看,
* 【模板】用来放置模板文件,
* 【回收站】中可以恢复已删除文件。

![](/images/cm/openkm/main_ui.png)

### 查看目录或文件权限

在新建目录前,需要确定是否可写权限,如下图所示:

![](/images/cm/openkm/directory_access_control_ui.png)

### 查看目录或文件详细权限

用鼠标点击需要查看权限的目录或者文件,再点击屏幕下方的【安全】标签,则可以看到该文件或者目录对应的组或者

用户所拥有的权限情况。打“对勾”的为允许,打“叉”的为禁止。如下图所示:

![](/images/cm/openkm/detail_access_controll_ui.png)

### 添加目录

1. 选择要添加目录的上一次目录
2. 点击工具栏上的【新建文件夹】按钮
3. 重命名添加的目录名称

如下图所示,在根目录下按右键选择【新建文件夹】按钮

![](/images/cm/openkm/create_dir_ui.png)

### 设置目录权限

新建好目录以后,为了防止他人未经许可而对该目录进行修改或者查看操作,可以对目录进行权限设置,具体方法如下:

1. 点击需要改变权限的目录
2. 点击详细权限中的【更新】按钮

如下图所示文件夹属性

![](/images/cm/openkm/dir_properties_ui.png)

点击【文件夹权限】栏,如图

![](/images/cm/openkm/dir_access_controll_settings_ui.png)

点击【更新】按钮,可以对此文件夹权限进行设置。

![](/images/cm/openkm/update_dir_access_control_ui.png)

如上图可以自定义不同用户对此文件夹的访问权限。

### 删除文件夹

如下图,可以对文件夹删除,重命名。

![](/images/cm/openkm/delete_dir_access_control_ui.png)



## 添加文件

### 上传文件

如下图所示,选择新建档按钮即可新建文档

![](/images/cm/openkm/new_doc_ui.png)

此时弹出对话框,可以选择本地要上传的新建文档

![](/images/cm/openkm/upload_doc_ui.png)

点击【浏览】按钮选择要上传的文件,同时可选项有通知用户和从ZIP压缩文件上传,最后点击发送,便完成了文件的上传。(上传时间视文件大小而定)如下图:

![](/images/cm/openkm/uploading_doc_ui.png)

在这个界面可以选择【新增另一文件】继续上传新文件,或者点击【关闭】,完成上传。


### 设置文件权限

跟目录一样,文件也可以设置权限,可以指定的用户可读或者可读可写。

点击某一文档后点击【文档权限】按钮,如图

![](/images/cm/openkm/view_file_access_control_ui.png)

设置文档权限方法如文件夹权限方法一致。
Step1 选择要设置权限的文件
Step2 点击【安全】标签

![](/images/cm/openkm/go_to_set_access_control_ui.png)

Step3 点击【更新】按钮

![](/images/cm/openkm/update_access_control_ui.png)

如上图,将要设置的用户添加到左侧区域,对其设置读和写的权限(点击复选框),如果读写权限全部取消则用户被自动转移到右侧区域。

注意:请务必对自己设置可写权限,否则讲给今后文件的更新带来麻烦。


### 添加文件关键字

为了索引方便,可以在文件属性中添加关键字。选择要添加关键字的文件,点击下方的【文件属性】按钮,在关键字一栏填入要添加的关键字,接收即可。如下图:

![](/images/cm/openkm/set_file_keyword_ui.png)

![](/images/cm/openkm/set_dir_keyword.png)


### 文件加锁解锁

为了防止自身误操作或者其他拥有可写权限的用户对文件作更改,可以使用加锁功能,在设置加锁以后,自身和其他用户均不可对文件进行一切改变操作(如加关键字,删除,更新等)。如果要恢复文件的可写状态,点击【解锁】按钮即可。如下图:

![](/images/cm/openkm/lock_file_ui.png)

左侧按钮为加锁,右侧为解锁。加锁后的文件前会有锁的图案标志。


### 删除文件

方法一:选择要删除的文件,点击工具栏【删除】按钮,确认即可。加锁文件不能被删除。本删除的文件可在回收站中找到并恢复,如下图:

![](/images/cm/openkm/delete_file_right_click_ui.png)

方法二:选择要删除文件后,点击删除按钮,如下图

![](/images/cm/openkm/delete_file_by_toolbar_ui.png)


## 检索文件

Step1:点击系统右上角【文件检索】按钮,进入检索页面,如下图:

![](/images/cm/openkm/search_file_ui.png)

Step2:输入搜索条件

范围 :必须项,选择要进行检索的目录范围,如分类,我的文档,模板,回收站

内容 :输入要查找的文件中包含的内容(汉字或者字母不得少于 3个字,支持通配符 *或者? )

例如:叫查找包含“测试方案”的所有文档则输入“测试方案”或者“测试方*”

名称 :输入要查找的文件名称(汉字或者字母不得少于3个字,支持通配符*或者?)

关键字 :输入要查找文件的关键字,关键字添加可以在文件的属性中添加

以上填写内容各填一项,点击【检索】,也可以将此检索条件保存。


## 下载文件

如下图所示,在想要下载的文件旁按鼠标右键选择【下载】按钮,之后便可以将文件下载到本地磁盘中。

![](/images/cm/openkm/download_file_ui.png)


## 其他常用功能

### 文件版本更新

#### 更新文件版本

经常会遇到这种情况,如果有文件或者文档需要更新,如果重新上传再删掉旧文件那么会发生其他用户不知道该文件发生改变的情况,那么就可以使用到OpenKM中的签入签出功能,是文件的版本号得到更新,同事也可以通知给其他用户。

步骤如下:

Step1 选择需要更新的文件

Step2 点击【签出】按钮

Step3 点击【签入】按钮,在弹出的对话框中选择新文件,点击【发送】(同时可选择通知到用户该文件已经更新)。

如下图:


![](/images/cm/openkm/checkout_file_ui.png)

![](/images/cm/openkm/send_file_ui.png)

文件更新完成后,可以选择文件,查看文件的版本已从低版本变为高版本号,如1.0变为1.2,如下图

![](/images/cm/openkm/file_version_changed_ui.png)



#### 查看文件历史版本

在文件更新后,如果要查看更新前的文件,如目前文件版本为1.2,要查看1.0时的文件,方法如下:

Step1.点击需要查看历史版本的文件,如下图:

![](/images/cm/openkm/view_old_version_ui.png)

Step2.点击下方的【历史】标签,如上图,可以看到如图所示内容。文件的历史更新版本,更新时间,更新作者,大小等信息。如果要查看或者下载文件,点击【查看】按钮即可,如果将历史版本覆盖当前版本则点击【恢复】按钮。

(注: 恢复操作需要当前账户具有对该文件的可写权限,否则【恢复】按钮将为灰色不可用状态)


### 订阅文件

可以通过此功能,将需要关注的文件添加至订阅中,这样当文件被更新时,可以得到以及通知。

Step1.选择要订阅的文件

Step2.点击工具栏上【订阅】按钮,要取消订阅则点击右侧的【取消订阅】按钮。操作如下图:

![](/images/cm/openkm/subscribe_file_ui.png)


### 个人仪表盘介绍

操作步骤:

打开个人仪表盘。点击系统右上方的【个人仪表盘】标签,进入个人仪表盘面板,如下图:

![](/images/cm/openkm/personal_centre_ui.png)


个人仪表盘中包括个人用户,邮件信息,查询信息,公共信息,工作流,关键字云等部分。其中,个人用户信息栏中包括了被锁定文件,检出文档,最近被下载文档,被订阅文档,最新上传文档等内容,可以根据需要点击相应标题。


## 注意事项

a.退出用户必须采用从菜单中选择【退出】按钮,请勿直接关闭浏览器。

b.每个文件夹和文件均有权限,所有对该文件或文件夹拥有可写权限的用户均可以对该文件进行更改操作,所有对于重要文件请采用加锁功能。

c.部分操作如复制,移动,复制文件链接等操作步骤比较简单,因此本文中不再赘述。


































