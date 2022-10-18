---
layout: post
title: java8-Stream，关联 流，comparator, sort
categories: [ dev, java ]
tags: []
---

* 参考
  * [Java中的排序（stream多字段排序踩坑）](https://www.jianshu.com/p/3989603ab243)
  * []()
  * []()
  * []()



* Stream不是集合元素，它不是数据结构并不保存数据，它是有关算法和计算的，它更像一个高级版本的Iterator。用户只要给出须要对其包含的元素执行什么操做，好比，“过滤掉长度大于 10 的字符串”、“获取每一个字符串的首字母”等，Stream会隐式地在内部进行遍历，作出相应的数据转换。

* Stream能够并行化操做，在处理大批量数据操做中更加高效。


## 使用

### List 倒序排列

~~~java
List<Double> salesData = new ArrayList<>();

Collections.reverse(salesData);
~~~

### java8 stream多字段排序

~~~java
List<类> rankList = new ArrayList<>(); 表明某个集合
 
//返回 对象集合以类属性一升序排序
 
rankList.stream().sorted(Comparator.comparing(类::属性一));
 
//返回 对象集合以类属性一降序排序 注意两种写法
 
rankList.stream().sorted(Comparator.comparing(类::属性一).reversed()); //先以属性一升序,而后对结果集进行属性一降序
 
rankList.stream().sorted(Comparator.comparing(类::属性一, Comparator.reverseOrder())); //以属性一降序
 
//返回 对象集合以类属性一升序 属性二升序
 
rankList.stream().sorted(Comparator.comparing(类::属性一).thenComparing(类::属性二));
 
//返回 对象集合以类属性一降序 属性二升序 注意两种写法
 
rankList.stream().sorted(Comparator.comparing(类::属性一).reversed().thenComparing(类::属性二));//先以属性一升序,升序结果进行属性一降序,再进行属性二升序
 
rankList.stream().sorted(Comparator.comparing(类::属性一,Comparator.reverseOrder()).thenComparing(类::属性二));//先以属性一降序,再进行属性二升序
 
//返回 对象集合以类属性一降序 属性二降序 注意两种写法
 
rankList.stream().sorted(Comparator.comparing(类::属性一).reversed().thenComparing(类::属性二,Comparator.reverseOrder()));//先以属性一升序,升序结果进行属性一降序,再进行属性二降序
 
rankList.stream().sorted(Comparator.comparing(类::属性一,Comparator.reverseOrder()).thenComparing(类::属性二,Comparator.reverseOrder()));//先以属性一降序,再进行属性二降序
 
//返回 对象集合以类属性一升序 属性二降序 注意两种写法
 
rankList.stream().sorted(Comparator.comparing(类::属性一).reversed().thenComparing(类::属性二).reversed());//先以属性一升序,升序结果进行属性一降序,再进行属性二升序,结果进行属性一降序属性二降序
 
rankList.stream().sorted(Comparator.comparing(类::属性一).thenComparing(类::属性二,Comparator.reverseOrder()));//先以属性一升序,再进行属性二降序
~~~


注意两种写法

一、 `Comparator.comparing(类::属性一).reversed();`

二、 `Comparator.comparing(类::属性一,Comparator.reverseOrder());`

两种排序是彻底不同的，必定要区分开来：方式1是获得排序结果后再排序，方式2是直接进行排序！！！方式2更好理解








































