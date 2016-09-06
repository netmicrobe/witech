---
layout: post
title: jenkins 如何让Job生成流水线视图
description: 
categories: [cm, jenkins]
tags: [cm, jenkins]
---


### 安装插件Build Pipeline Plugin

### 创建，配置pipeline的一个视图

![](/images/cm/jenkins/create_pipeline_1.png)
![](/images/cm/jenkins/create_pipeline_2.png)
![](/images/cm/jenkins/create_pipeline_3.png)


配置效果如下：
![](/images/cm/jenkins/pipeline_created.png)

展示效果如下（绿色表示构建成功）：
![](/images/cm/jenkins/pipeline_view.png)

如何将job添加到该流水线中，需要更新job的配置项，如下图：
![](/images/cm/jenkins/pipeline_setting_of_job.png)







