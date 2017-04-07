---
layout: post
title: 如何使得 android app 的字体大小不受系统字体大小设置
categories: [dev, android]
tags: [android, font]
---

* 参考
  * [Think About Font Scale ](https://commonsware.com/blog/2012/12/12/think-about-font-scale.html)
  * [Android Developer - Dimension](http://developer.android.com/guide/topics/resources/more-resources.html#Dimension)
  * [Understanding Density Independence In Android](https://www.captechconsulting.com/blogs/understanding-density-independence-in-android)
  * [Android User Interface Design: Basic Font Sizes](https://code.tutsplus.com/tutorials/android-user-interface-design-basic-font-sizes--mobile-11194)

## 问题

有很多app 在系统字体大小调整为“超大”、“特大”时，界面出现问题，超出屏幕大小

## 原因

字体大小的单位使用了 sp (Scale-independent Pixels) ，sp单位受系统字体大小设置影响。

## 解决

使用 dp 作为字体单位

使用 ScrollView 作为容器，万一界面有缩放，拖动还能显示出来，凑合凑合。

例如：

```
<ScrollView>
  <LinearLayout ...>
    <!-- your layout -->
  </LinearLayout>
</ScrollView>
```

## 附录

### 摘自 <http://stackoverflow.com/questions/2025282/what-is-the-difference-between-px-dp-dip-and-sp-on-android>



* px

Pixels - corresponds to actual pixels on the screen.

* in

Inches - based on the physical size of the screen.
1 Inch = 2.54 centimeters

* mm

Millimeters - based on the physical size of the screen.

* pt

Points - 1/72 of an inch based on the physical size of the screen.

* dp or dip

Density-independent Pixels - an abstract unit that is based on the physical density of the screen. These units are relative to a 160 dpi screen, so one dp is one pixel on a 160 dpi screen. The ratio of dp-to-pixel will change with the screen density, but not necessarily in direct proportion. Note: The compiler accepts both "dip" and "dp", though "dp" is more consistent with "sp".

* sp

Scale-independent Pixels - this is like the dp unit, but it is also scaled by the user's font size preference. It is recommended you use this unit when specifying font sizes, so they will be adjusted for both the screen density and user's preference.


    +----------------+----------------+---------------+-------------------------------+
    | Density Bucket | Screen Density | Physical Size | Pixel Size                    | 
    +----------------+----------------+---------------+-------------------------------+
    | ldpi           | 120 dpi        | 0.5 x 0.5 in  | 0.5 in * 120 dpi = 60x60 px   | 
    +----------------+----------------+---------------+-------------------------------+
    | mdpi           | 160 dpi        | 0.5 x 0.5 in  | 0.5 in * 160 dpi = 80x80 px   | 
    +----------------+----------------+---------------+-------------------------------+
    | hdpi           | 240 dpi        | 0.5 x 0.5 in  | 0.5 in * 240 dpi = 120x120 px | 
    +----------------+----------------+---------------+-------------------------------+
    | xhdpi          | 320 dpi        | 0.5 x 0.5 in  | 0.5 in * 320 dpi = 160x160 px | 
    +----------------+----------------+---------------+-------------------------------+
    | xxhdpi         | 480 dpi        | 0.5 x 0.5 in  | 0.5 in * 480 dpi = 240x240 px | 
    +----------------+----------------+---------------+-------------------------------+
    | xxxhdpi        | 640 dpi        | 0.5 x 0.5 in  | 0.5 in * 640 dpi = 320x320 px | 
    +----------------+----------------+---------------+-------------------------------+

    
    
    +---------+-------------+---------------+-------------+--------------------+
    | Unit    | Description | Units Per     | Density     | Same Physical Size | 
    |         |             | Physical Inch | Independent | On Every Screen    | 
    +---------+-------------+---------------+-------------+--------------------+
    | px      | Pixels      | Varies        | No          | No                 | 
    +---------+-------------+---------------+-------------+--------------------+
    | in      | Inches      | 1             | Yes         | Yes                | 
    +---------+-------------+---------------+-------------+--------------------+
    | mm      | Millimeters | 25.4          | Yes         | Yes                | 
    +---------+-------------+---------------+-------------+--------------------+
    | pt      | Points      | 72            | Yes         | Yes                | 
    +---------+-------------+---------------+-------------+--------------------+
    | dp      | Density     | ~160          | Yes         | No                 | 
    |         | Independent |               |             |                    | 
    |         | Pixels      |               |             |                    | 
    +---------+-------------+---------------+-------------+--------------------+
    | sp      | Scale       | ~160          | Yes         | No                 | 
    |         | Independent |               |             |                    | 
    |         | Pixels      |               |             |                    | 
    +---------+-------------+---------------+-------------+--------------------+