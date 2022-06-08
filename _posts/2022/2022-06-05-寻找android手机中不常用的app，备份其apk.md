---
layout: post
title: 寻找android手机中不常用的app，备份其apk，关联 adb
categories: []
tags: []
---

* 参考
  * []()
  * []()

~~~
adb shell pm list packages | grep -v "oneplus\|com.google\|com.android\|com.qualcomm\|com.taobao\|tencent\|com.youku\|com.youdao\|com.qiyi\|com.oem\|com.jingdong\|com.zhihu\|com.synology\|epson.print\|shanghai.metro\|com.epson\|com.cctv\|com.huawei\|meituan\|com.dianping\|Xplore\|com.heytap\|com.autonavi\|tv.danmaku.bili\|com.qti\|com.nearme\|com.cn21.ecloud\|com.pagoda\|com.smile.gifmaker\|Alipay\|cn.wps\|com.achievo\|com.xweisoft.nbs"
~~~



com.xweisoft.nbs    牛咔视频
com.hoperun.intelligenceportal   我的南京
com.lalamove.huolala.client   货拉拉
com.ss.android.ugc.aweme.lite   抖音极速版
com.sunrisedutyfree.apps.sunrisemembers    日上会员app
com.MobileTicket    12306
com.wondersgroup.whs    江苏智慧人社
mark.via.gp   via浏览器
com.xingin.xhs    小红书
com.ygkj.chelaile.standard    车来了
com.chinacaring.njch_public   南京儿医在线
com.ataaw.tianyi    天翼生活
com.wudaokou.hippo    盒马
cn.lunkr.android    Coremail论客
com.ximalaya.ting.android    喜马拉雅
com.htinns    华住酒店
uni.UNIEE56932    南京明基医院
com.maycur.common    每刻报销
com.chebada    巴士管家
com.greenpoint.android.mc10086.activity   中国移动

