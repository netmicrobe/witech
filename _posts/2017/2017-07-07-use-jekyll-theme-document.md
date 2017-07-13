---
layout: post
title: 如何使用 Jekyll 主题 documentation-theme-jekyll
categories: [dev, jekyll]
tags: [jekyll, jekyll-theme, theme]
---

* 参考：
  * [documentation-theme-jekyll - Github Repo](https://github.com/tomjohnson1492/documentation-theme-jekyll)


## 自定义Sidebar

### 自定义Sidebar方法

#### 在 _data/sidebars 目录下创建 sidebar 文件，例如：my_sidebar.yml

my_sidebar.yml 配置例子：

~~~ yml
entries:
- title: Sidebar
  levels: one
  folders:

  - title: Products
    output: web
    folderitems:
    - title: News
      url: /news.html
      output: web
    - title: Theme instructions
      url: /mydoc_introduction.html
      output: web
    - title: Product 1
      url: /p1_landing_page.html
      output: web
    - title: Product 2
      url: /p2_landing_page.html
      output: web
~~~

效果示意图： ![](sidebar_sample01.png)


#### 在 _config.yml 中注册

~~~ yml
sidebars:
- my_sidebar
~~~

#### 在 post 的 front matter 中指定使用的 sidebar

~~~ yml
sidebar: my_sidebar
~~~

### 最多只能有2层菜单

~~~ yml
  - title: Tag archives
    output: web
    folderitems:

    - title: Tag archives overview
      url: /mydoc_tag_archives_overview.html
      output: web

      subfolders:
      - title: Tag archive pages
        output: web
        subfolderitems:

        - title: Formatting pages
          url: /tag_formatting.html
          output: web

        - title: Navigation pages
          url: /tag_navigation.html
          output: web

      - title: Publishing pages
        url: /tag_publishing.html
        output: web
        subfolderitems:

        - title: Special layout pages
          url: /tag_special_layouts.html
          output: web

        - title: Collaboration pages
          url: /tag_collaboration.html
          output: web

    - title: Troubleshooting pages
      url: /tag_troubleshooting.html
      output: web
~~~


效果示意图： ![](sidebar_sample02.png)

### 设置默认 sidebar

在 _config.yml 中设置 defaults

~~~ yml
defaults:
  -
    scope:
      path: ""
      type: "pages"
    values:
      sidebar: home_sidebar
~~~



## 自定义页首导航条 topnav

可以定义多个 topnav ，在 page 的 front matter 中指定， topnav: your-topnav

实现逻辑，在 _include/topnav.html 的 liquid 代码中。

### 自定义导航条

在 _data 创建导航条数据文件，例如， topnav.yml

在 _config.yml 的 defaults 块 设置默认的导航条

~~~ yml
defaults:
  -
    scope:
      path: ""
      type: "pages"
    values:
      layout: "page"
      topnav: topnav
~~~












