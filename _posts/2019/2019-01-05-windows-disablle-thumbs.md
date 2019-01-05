---
layout: post
title: 禁止windows创建 thumbs.db 文件
categories: [ cm, windows ]
tags: []
---


### 在资源浏览器中设置

资源浏览器 ，文件夹选项，“查看”选项卡，选择“始终显示图标，重不显示缩略图”

### 在组策略中启用“关闭thumbs.db缩略图缓存”

1. 运行 `gpedit.msc`
2. 用户配置，管理模版，windows组件，windows资源管理器
3. 启用 “关闭隐藏的 thumbs.db  文件中的缩略图缓存”





