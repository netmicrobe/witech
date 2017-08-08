---
layout: post
title: jekyll 支持 textile
categories: [dev, jekyll]
tags: 
  - jekyll
  - document
  - textile
---

* 参考：
  * <https://github.com/jekyll/jekyll-textile-converter>
  * <https://stackoverflow.com/a/8054938>

## 添加 textile 支持

1.  在 Gemfile 添加

    ~~~
    gem 'RedCloth'
    gem 'jekyll-textile-converter'
    ~~~

2.  在 _config.yml 添加

    ~~~ yml
    plugins:
    - jekyll-textile-converter
    
    textile_ext: "textile,txtl,tl"
    ~~~
    

### Windows 上报错 “Missing dependency: RedCloth”

~~~ shell
>bundle exec jekyll build
Configuration file: D:/documentation-theme-jekyll/_config.yml
            Source: D:/documentation-theme-jekyll
       Destination: D:/documentation-theme-jekyll/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
You are missing a library required for Textile. Please run:
  $ [sudo] gem install RedCloth
  Conversion error: Jekyll::Converters::Textile encountered an error while converting 'hello.textile':
                    Missing dependency: RedCloth
             ERROR: YOUR SITE COULD NOT BE BUILT:
                    ------------------------------------
                    Missing dependency: RedCloth
~~~

#### 解决方法

~~~
> bundle list RedCloth
D:\ruby-2.1.7-x64-mingw32\lib\ruby\gems\2.1.0\gems\RedCloth-4.3.2\ext

> cd D:\ruby-2.1.7-x64-mingw32\lib\ruby\gems\2.1.0\gems\RedCloth-4.3.2\ext

> mkdir 2.1

> xcopy /E redcloth_scan\* 2.1\
~~~

