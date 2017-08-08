---
layout: post
title: 在 Gitlab Pages 上创建 Jekyll 站点
categories: [cm, git, gitlab]
tags: [git, gitlab, pages, jekyll, jekyll-themes]
---

## 在 Gitlab Pages 上创建 Jekyll 站点



### Project 首页 > Set Up Ci

![](/images/gitlab/pages/jekyll/setup_jekyll_ci_01.png)!



### 创建网站自动编译配置文件

New file > Template .gitlab-ci.yml > jekyll
添加 jekyll 的 ci 配置模板（ **不需要改动，就是用默认的，生成静态网页到 public** ）

![](/images/gitlab/pages/jekyll/setup_jekyll_ci_02.png)!

![](/images/gitlab/pages/jekyll/setup_jekyll_ci_03.png)!




### 查看网站发布地址

Project 首页 > Pipeline > Settings > Pages > 查看 **网站发布地址**

![](/images/gitlab/pages/jekyll/setup_jekyll_ci_04.png)!


![](/images/gitlab/pages/jekyll/setup_jekyll_ci_05.png)!



### 设置 site.url

在项目根目录的 _config.yml 添加：

```
url: http://192.168.251.72:8091/<your-group>/<your-project>/public
```

在 JEKYLL_ENV=production 时，才会使用 site.url 编译。

修改 .gitlab-ci.yml ， 添加 JEKYLL_ENV=production

```yml
  script:
  - JEKYLL_ENV=production 
  - bundle exec jekyll build -d public
```



## 站点模板下载地址

* <https://github.com/jekyll/jekyll/wiki/Themes>
* <http://jekyllthemes.org/>
* <https://jekyll-themes.com/>
