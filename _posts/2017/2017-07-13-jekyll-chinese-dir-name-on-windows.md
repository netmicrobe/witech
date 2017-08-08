---
layout: post
title: 在Windows上中文环境下使用Jekyll
categories: [dev, jekyll]
tags: [jekyll, illegible-character, windows, encoding, webrick]
---


## 在Windows上，Jekyll 将中文文件夹名生成为乱码

### 原因

convertible/page 的 url 属性 url encoding 时，使用的是 gbk，而 convertible mkdir 的时候，对url使用 “utf8” 解码。

ruby 2.1.7 的 URI::escape 有问题，url encoding 时用的GBK。

### 解决方法

#### 方法一，直接修改ruby 库 URI::escape （推荐）

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

#### 方法二，修改jekyll库，解码的时候用gbk

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




## 在Windows上，webrick url 含有某些中文时候，找不到文件 404

### 现象

/产品研发立项审批确认单/ 乱码成 /产品研发立项审批确认�?

webrick 报错 

~~~
[2017-07-14 18:10:37] ERROR Encoding::InvalidByteSequenceError: "\xE5\x8D" followed by "?" on UTF-8
~~~

### 原因

webrick\httpservlet\filehandler.rb 的 prevent_directory_traversal 对 url 编码为 Encoding.find("filesystem")

中文语言的Window Encoding.find("filesystem") 是 GBK 编码。而 URL 是 UTF-8 编码。

### 解决方法

webrick\httpservlet\filehandler.rb 的 prevent_directory_traversal 函数中

~~~ ruby
  ### ### wi-start @ 2017-07-17 
  # wi : delete below
  #path = req.path_info.dup.force_encoding(Encoding.find("filesystem"))
  # wi : add this
  #      this cause illegible characters in path, files in chinese folder 404
  path = req.path_info.dup.force_encoding("utf-8").encode("gbk")
  ### ### wi-end @ 2017-07-17
~~~





## build 时，报错： Invalid GBK character

~~~
jekyll 3.5.1 | Error:  Liquid error (line 77): Invalid GBK character "\xE2" on line 108
~~~

### scssfiy 时出问题，utf-8 的 scss 文件被误认为 GBK

**原因**

sass 处理 “@import” 时读取文件，使用 File.read 是该方法默认使用 Windows 中文环境的 GBK 编码。

改不了内建的 File.read ，就只能改 Sass 了，例如：

* \sass-3.5.1\lib\sass\importers\filesystem.rb
* Sass::Importers::_find

~~~ ruby
module Sass
  module Importers
    class Filesystem
      def _find(dir, name, options)
        full_filename, syntax = Sass::Util.destructure(find_real_file(dir, name, options))
        return unless full_filename && File.readable?(full_filename)

        # TODO: this preserves historical behavior, but it's possible
        # :filename should be either normalized to the native format
        # or consistently URI-format.
        full_filename = full_filename.tr("\\", "/") if Sass::Util.windows?

        options[:syntax] = syntax
        options[:filename] = full_filename
        options[:importer] = self
        ### ### 
        # wi 2017-07-26 : remove
        #Sass::Engine.new(File.read(full_filename), options)
        # wi 2017-07-26 : add
        Sass::Engine.new(File.read(full_filename, :encoding => "utf-8"), options)
        ### ###
      end
    end
  end
end
~~~



## Windows 上报错 “Missing dependency: RedCloth”

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

### 解决方法

~~~
> bundle list RedCloth
D:\ruby-2.1.7-x64-mingw32\lib\ruby\gems\2.1.0\gems\RedCloth-4.3.2\ext

> cd D:\ruby-2.1.7-x64-mingw32\lib\ruby\gems\2.1.0\gems\RedCloth-4.3.2\ext

> mkdir 2.1

> xcopy /E redcloth_scan\* 2.1\
~~~





## 附录

### 找到当前 webrick 代码目录

~~~
shell> irb
irb> require "webrick/httpservlet"
irb> WEBrick::HTTPServlet::FileHandler.instance_method(:set_filename).source_location
~~~




