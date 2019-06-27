---
layout: post
title: 在windows 10 上禁用自动更新
categories: [cm, windows]
tags: [windows 10]
---

* 参考
  * [How to stop automatic updates on Windows 10](https://www.windowscentral.com/how-stop-updates-installing-automatically-windows-10)

## 问题

Windows 10 上默认被用户关闭自动更新了

## 解决

1. 开始菜单运行 gpedit.msc 
2. 计算机配置 -> 管理模板 -> 所有配置 -> 
    或 计算机配置 》管理模板 》Windows组件 》Windows更新
3. 双击“配置自动更新” -> 勾选“已禁用”
    英文界面： "Configure Automatic Updates"，选择 Disabled
4. 确认 或 应用 ，保存配置




