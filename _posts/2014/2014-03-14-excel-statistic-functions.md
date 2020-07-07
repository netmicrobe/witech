---
layout: post
title: excel的统计函数
description: 
categories: [cm, office, excel]
tags: [cm, office, excel]
---


### 某个值出现的次数

```
=COUNTIF(C13:C500,"=联网")
```

#### 在一整列/行出现的次数

```
=COUNTIF(C:C, "=是")
```

#### 包含 某个文字

`=COUNTIF(Range,"*要包含的文字*")`


#### 不包含 某个文字

`=COUNTIF(Range,"<>*不要包含的文字*")`



### 统计“符合多个条件”的行数

#### COUNTIFS

> =COUNTIFS(A:A, "=1", E:E, "=是")

说明：第一列值为1，第五列值为“是”


### 有多少个不同的值出现过，类似 sum(distinct)

=SUMPRODUCT((data<>"")/COUNTIF(data,data&""))

* 参考：<https://exceljet.net/formula/count-unique-values-in-a-range-with-countif>



### 统计不为空的cell数目

#### COUNTA

例子：

计算一列中，多少不为空    COUNTA(A:A)
计算多列中，不为空   COUNT(A:A, B:B, ...) 可以跟很多，最多255个range

* 参考：<https://support.office.com/zh-cn/article/COUNTIF-%E5%87%BD%E6%95%B0-E0DE10C6-F885-4E71-ABB4-1F464816DF34>



### 统计范围内多少个空cell ，Count Blank or Empty Cells

=COUNTBLANK( Range)
