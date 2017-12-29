---
layout: post
title: redmine project 开发相关
categories: [dev, ruby]
tags: [ruby, rails, redmine, tree]
---


## project model 的二维表树型结构

### Project model 的代码继承&mixin关系

<pre class="code">
[父类] ActiveRecord::Base
    [子类] Project
        [include] Redmine::NestedSet::ProjectNestedSet
            [include] Redmine::NestedSet::Traversing
</pre>

### 涉及 Project 的属性：

* parent_id
* lft
  * 前序遍历项目树时候的序号
* rgt
  * 后序遍历项目树时候的序号




