---
layout: post
title: Excel 条件格式
categories: [cm, office]
tags: [excel]
---

* 参考： 
  * [Excel按单元格条件设置整行的颜色](https://www.jianshu.com/p/d07e7130946e)
  * []()




## 按单元格条件设置整行的颜色


1. 按常规步骤设置**单元格**的条件格式： 
    例如， 条件格式 》突出显示单元格规则》等于 
1. 开始 》条件格式 》管理规则
1. 选中刚刚建立的规则
    1. 修改“应用于”为： `$A:$H` ，这里`$H`看你的表格最后一列是什么
    1. 双击这条规则，弹出“编辑格式规则”
    1. 选择规则类型： 使用公式确定要设置格式的单元格
    1. 为符合此公式的值设置格式： `=$A1="已完成"`， 这里 "已完成" 是你要比较的条件
    1. 一路确定保存就能看到效果了



