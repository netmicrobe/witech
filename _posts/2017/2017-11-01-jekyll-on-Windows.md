---
layout: post
title: jekyll在windows上使用和调试
categories: [ cm, jekyll ]
tags: [jekyll, jekyll-themes, liquid]
---



## Windows 上调试

### 解决中文文件名问题

#### 修改ruby 库 URI::escape

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

#### webrick 中文支持

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



### build 时，报错： Invalid GBK character

~~~
jekyll 3.5.1 | Error:  Liquid error (line 77): Invalid GBK character "\xE2" on line 108
~~~

#### scssfiy 时出问题，utf-8 的 scss 文件被误认为 GBK

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


#### 解决 link tag 参数出现中文文件名时，报错：incompatible character encodings

* 报错信息
  ~~~
  format_error: incompatible character encodings: UTF-8 and GBK (Encoding::CompatibilityError)
  ~~~

* 解决方法
  ruby-2.3.3-x64-mingw32\lib\ruby\gems\2.3.0\gems\jekyll-3.3.1\lib\jekyll\liquid_renderer.rb
  
  ~~~ ruby
  def file(filename)
      # 解决 link tag 参数出现中文文件名时，报错：
      #   `format_error': incompatible character encodings: UTF-8 and GBK (Encoding::CompatibilityError)
      # 加入一句代码
      filename.encode!("utf-8")
      
      ...
  end
  ~~~

### drafts 草稿模式使用 liquid link tag 无法找到文件，导致无法运行

* 问题描述
  drafts 草稿模式使用 liquid link tag 无法找到文件，这些文件放在 _posts 里面，无法在草稿模式找到。

* 解决方法
  修改 link tag 的源码，只是警告提醒，而不中止编译。
  
  ruby-2.3.3-x64-mingw32\lib\ruby\gems\2.3.0\gems\jekyll-3.3.1\lib\jekyll\tags\link.rb

~~~ ruby
  def render(context)
    site = context.registers[:site]

    site.each_site_file do |item|
      return item.url if item.relative_path == @relative_path
      # This takes care of the case for static files that have a leading /
      return item.url if item.relative_path == "/#{@relative_path}"
    end

    # wi 2017-12-22
    # 找不到文档，只提醒，不报错而导致build中止。
    # 使用 drafts 的时候可能无法找到link的文档
    # 删除这一句
    #raise ArgumentError, <<eos
    # 添加这句话
    Jekyll.logger.warn "WARNING:", <<eos
    
Could not find document '#{@relative_path}' in tag '#{self.class.tag_name}'.

Make sure the document exists and the path is correct.
eos
  end
~~~




## 附录

### 找到当前 webrick 代码目录

~~~
shell> irb
irb> require "webrick/httpservlet"
irb> WEBrick::HTTPServlet::FileHandler.instance_method(:set_filename).source_location
~~~

















