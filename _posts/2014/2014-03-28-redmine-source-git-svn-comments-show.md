---
layout: post
title: redmine 2.4.2，git或svn commit生成issue comment 显示不对
categories: [cm, redmine]
tags: [cm, redmine, svn, git]
---

## 问题

2.4.2及以前版本，自动产生的comment，显示不对的问题：

1. 链接显示不了
2. 没显示commit message

### 链接显示不了

commit:<hash> 与前面的“\|”没有空格：

```
hellogerrit|commit:44a3b61bb57512629bf2a369765f7623d28b6d73.
```

所有在comment里边不会产生正确的链接。

#### 修改方法：

修改文件 redmine-2.4.2\app\models\changeset.rb

```
def text_tag(ref_project=nil) 函数

tag = "#{repository.identifier}|#{tag}"
改为
tag = "#{repository.identifier}空格|空格#{tag}"
```

然后重启redmine




### commit message 不显示

上述同样的函数

```
tag = "#{repository.identifier} | #{tag}"
改为
tag = "#{repository.identifier} | #{tag} \n #{short_comments}"
```


### comment 提示不清晰

默认提示：英文（Applied in changeset）中文（已应用到变更列表）\| your-repo-name \| r12345

如果不满意中文翻译，可以在 redmine-2.4.2\config\locales\zh.yml 中修改

text_status_changed_by_changeset: "已应用到变更列表 %{value}."

建议改成“已解决，并提交版本库”



