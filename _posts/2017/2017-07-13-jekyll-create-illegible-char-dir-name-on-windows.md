---
layout: post
title: 在Windows上，Jekyll 将中文文件夹名生成为乱码
categories: [dev, jekyll]
tags: [jekyll, illegible-character, windows, encoding]
---

## 原因

convertible/page 的 url 属性 url encoding 时，使用的是 gbk，而 convertible mkdir 的时候，对url使用 “utf8” 解码。

ruby 2.1.7 的 URI::escape 有问题，url encoding 时用的GBK。

## 解决方法

### 方法一，直接修改ruby 库 URI::escape （推荐）

* 修改文件： ruby-2.1.7-x64-mingw32\lib\ruby\2.1.0\uri\common.rb
* 修改： 在 escape 方法中 添加 us.encode!("utf-8")

~~~ ruby
    def escape(str, unsafe = @regexp[:UNSAFE])
      unless unsafe.kind_of?(Regexp)
        # perhaps unsafe is String object
        unsafe = Regexp.new("[#{Regexp.quote(unsafe)}]", false)
      end
      str.gsub(unsafe) do
        us = $&
        tmp = ''
        ### ### wi: fix chinese folder name becomes illegible in jekyll 2017-07-13
        us.encode!("utf-8")
        ### ###
        us.each_byte do |uc|
          tmp << sprintf('%%%02X', uc)
        end
        tmp
      end.force_encoding(Encoding::US_ASCII)
    end
~~~

### 方法二，修改jekyll库，解码的时候用gbk

* 修改文件 ruby-2.1.7-x64-mingw32\lib\ruby\gems\2.1.0\gems\jekyll-3.3.1\lib\jekyll\url.rb

~~~ ruby
module Jekyll
  class URL
    def self.unescape_path(path)
      ### ### URI.unescape(path.encode("utf-8"))
      ### ### 改为
      URI.unescape(path.encode("gbk"))
    end
  end
end
~~~



