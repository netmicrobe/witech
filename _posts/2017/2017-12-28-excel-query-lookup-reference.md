---
layout: post
title: excel 中利用 VLOOKUP & INDIRECT 查找信息表中的记录，并获取记录字段
categories: [ cm, office ]
tags: [ office, excel, vlookup ]
---

* 参考
  * [Microsoft - Excel - Formulas and functions - Reference - VLOOKUP function](https://support.office.com/en-us/article/VLOOKUP-function-0BBC8083-26FE-4963-8AB8-93A18AD188A1)
  * [Microsoft - Look up values in a list of data](https://support.office.com/en-us/article/Look-up-values-in-a-list-of-data-c249efc5-5847-4329-bfee-ecffead5ef88)
  * [知乎 - Excel公式中如何固定获取相对单元格的值](https://zhuanlan.zhihu.com/p/29887818)
  * [Microsoft - Lookup and reference functions - reference](https://support.office.com/en-us/article/Lookup-and-reference-functions-reference-8aa21a3a-b56a-4055-8257-3ec89df2b23e?ui=en-US&rs=en-US&ad=US)

## 场景

需要实现：如果“甲表 人员联系方式表”中B列某人电话改变，“乙表 进出货记录”中B列电话也要随之改变。

甲表 人员联系方式

||A|B|C|
|1|姓名|电话|地址|
|2|张三|16992880081|上海路8号|
|3|李四|19982920971|湖南路9号|
|4|赵武|18100001111|广州路20号|


乙表 进出货记录

||A|B|C|
|1|姓名|电话|进出货记录|
|2|张三|16992880081|进货100袋大米|
|3|赵武|18100001111|领走5包薯条|
|4|李四|19982920971|进货10条鲨鱼|
|5|张三|16992880081|进货50吨大麦|


## 实现方法

1. 找到“乙表”电话号码字段所在记录，名字字段的内容
2. 根据名字检索“甲表”获得电话号码

~~~
=VLOOKUP(INDIRECT(ADDRESS(ROW(),COLUMN()-1)),人员联系方式!$A$1:$B$4,2,FALSE)

# 如果查找失败，可能是excel数值转换的问题，例如，是更加电话号码来检索，使用VALUE函数就好了
# 原因目前还没搞清楚。。。
=VLOOKUP(VALUE(INDIRECT(ADDRESS(ROW(),COLUMN()-1))),人员联系方式!$A$1:$B$4,2,FALSE)

# 出现NA未找到的情况，excel显示NA，可以使用IFNA函数来转换为需要的值，例如，下面转换为空字符串
=IFNA(VLOOKUP(VALUE(INDIRECT(ADDRESS(ROW(),COLUMN()-1))),人员联系方式!$A$1:$B$4,2,FALSE),"")
~~~


## 附录

### 定位函数

#### 如何获取相对单元格上的值

* 取同一列上一行的值：`=INDIRECT(ADDRESS(ROW()-1,COLUMN()))`
* 取上同一行向左两列：`=INDIRECT(ADDRESS(ROW(),COLUMN()-2))`
* 取上同一行向左一列：`=INDIRECT(ADDRESS(ROW(),COLUMN()-1))`

#### ROW()函数

ROW()函数的调用格式为：

~~~
=ROW([reference])
~~~

* 其中reference是一个数据区域。ROW()函数会返回这个数据区域的首行行号。
* 如果不给定reference，则返回公式所在单元格的行号。

例如 `=ROW(A2:F7)` 得到的值是2，因为这个数据区域的是从第2行开始的。


#### COLUMN()函数

COLUMN()函数的调用格式： 

~~~
=COLUMN([refrence])
~~~

* 和ROW()函数相对应的，COLUMN()函数返回的是列号，不过它返回值的是以数字形式表示的，而不是以Excel界面中A列、B列这种字母表示。
* 如果不给定reference，则返回公式所在单元格的列号。

例如 `=COLUMN(K4:M10)` 得到的值是11，因为第K列是第11列。



#### ADDRESS()函数

ADDRESS()函数的调用格式是

~~~
=ADDRESS(row_num, column_num, [abs_num], [a1], [sheet_text])
~~~

它的作用是给定单元格所在的行号和列号（都是数字）后返回它在Excel中表示的地址，类似$A$2、D$7这种形式。其中

* row_num：在单元格引用中使用的行号。
* column_num：在单元格引用中使用的列标。
* abs_num：用以指定返回地址的类型，可选参数值和意义如下：
  * 值为 1 ：绝对引用，为默认值。返回的地址类似$A$2这种绝对引用的地址。
  * 值为 2 ：绝对行号，相对列标。类似A$2。
  * 值为 3 ：相对行号，绝对列标。类似$A2。
  * 值为 4 ：相对引用。类似A2。
* a1：布尔值，用于设置返回地址的形式。
  * 如果值为TRUE，则返回值的形式为`<字母表示的列号><数字表示的行号>`，比如 `=ADDRESS(1, 8, 4, TRUE)` 返回的是H1；
  * 如果值为FALSE，则返回值形式为`R<数字表示的行号>C<数字表示的列号>`，比如 `=ADDRESS(1, 8, 4, FALSE)` 返回的是R[1]C[8]。
  * 默认值是TRUE。
* sheet_text：文本值，指定作为外部引用的工作表的名称，如果省略 sheet_text，则不使用任何工作表名。

#### INDIRECT()函数

INDIRECT()函数的调用格式是

~~~
=INDIRECT(ref_text, [a1])
~~~

作用是返回ref_text所表示的单元格的引用。其中

* ref_text：文本值，
  表示所引用单元格的地址，可以是类似A8形式的地址，也可以是类似R8C1形式的地址，
  但如果使用后一种形式，要把参数a1的值设置为FALSE。
* a1: 布尔值。
  * 若值为TRUE表示参数ref_text表示的引用格式是类似A8形式的地址，
  * 若为FALSE，则表示ref_text表示的引用格式是类似R8C1形式的地址。
  * 默认值为TRUE。


### VLOOKUP 


>=VLOOKUP(**lookup value**, **lookup range**, the **column number** containing the return value, **how to match**).


1. The value you want to look up, also called the **lookup value**.

2. The **lookup range** where the lookup value is located. Remember that the **lookup value** should always be in the __first column__ in the range for VLOOKUP to work correctly. For example, if your lookup value is in cell C2 then your range should start with C.

3. The **column number** in the range that contains the return value. For example, if you specify B2: D11 as the range, you should count B as the first column, C as the second, and so on.

4. Optionally, you can specify TRUE if you want an approximate match or FALSE if you want an exact match of the return value. If you don't specify anything, the default value will always be TRUE or approximate match.














