---
layout: post
title: Jekyll 上，将资源（图片等）和文档放在同一目录
categories: [dev, jekyll]
tags: [jekyll]
---


## 缘起

jekyll 一般都要将图片等附件，放到根目录的 images/ 或者 assets/img 等，最后也不知道这些图片被哪些文档使用。

把图片等资源和post放到一起岂不是很好呢！


## 把图片等资源和post放到一起

解决方法，添加如下代码，放到 _plugins。同时要在 _config.yml 中设置 permalink: pretty

> along_with_resources.rb

~~~ ruby
# encoding: UTF-8

module Jekyll
  # Reader.retrieve_posts 没有检查文件是合法的post，还是二进制文件。
  # 所以，当 _post 文件夹中放置二进制文件（例如，图片）会导致 Liquid 报错，
  # 例如：
  #   Liquid Exception: invalid byte sequence in UTF-8 in _post/some-pic.jpg
  #
  # 重写 Reader.get_entries
  #
  # 这个修改，并不能使得 post 同目录的资源文件被拷贝，要添加下面的hook
  #
  class Reader
    def get_entries_with_check_yaml(dir, subfolder)      
      base = site.in_source_dir(dir, subfolder)
      entries = get_entries_without_check_yaml(dir, subfolder)
      # 没有 Front Matter，不是合法的 post，不用 Liquid 处理
      entries.delete_if { |e| !Utils.has_yaml_header?(site.in_source_dir(base, e)) }
    end
    
    alias_method :get_entries_without_check_yaml, :get_entries
    alias_method :get_entries, :get_entries_with_check_yaml
  end
end


# 
# 使得 post 同目录的资源文件被拷贝
#
Jekyll::Hooks.register :posts, :post_write do |post|
  
  # 整理出要拷贝的文件位置
  post_absolute_path = post.site.in_source_dir(post.relative_path)
  assets_folder = File.expand_path("../#{post.basename_without_ext}", post_absolute_path)
  
  # 文件要拷贝到的目标目录
  assets_dist_folder = File.expand_path("../.", post.destination(''))
  
  # 如果目录存在，就开始拷贝其中的所有 *文件*
  if File.directory?(assets_folder)
    if !Dir.exist?(assets_dist_folder)
      FileUtils.mkdir_p(assets_dist_folder)
    end
    FileUtils.chmod("a=rw", assets_dist_folder)
    FileUtils.cp_r(Dir["#{assets_folder}/*"], assets_dist_folder)
  end
end

~~~

## 把图片等资源和 collection 的 Document 放到一起

~~~ ruby
module Jekyll
  # 在 collection 文件夹中放置中文文件夹和中文二进制文件时，
  # 报错：  No such file or directory @ dir_s_mkdir
  # 
  # 原因是，StaticFile#destination_rel_dir 对 collection 使用 url 作为相对路径，
  #      去 mkdir，但是 url 是 escape 的， 包含 % ，无法在文件系统创建这样的文件夹。
  # 
  # 本修改，只是解决jekyll扫描 collection 文件夹是不报错，
  #   并不能将其中的 static file 拷贝到 _site，
  #   jekyll 自己会将 collection 文件夹下的 static file 拷贝的
  # 
  class StaticFile
    def destination_rel_dir
      if @collection
        # wi 2017-07-19 remove
        #File.dirname(url)
        # wi 2017-07-19 add
        File.dirname(URI.unescape(url))
        # wi 2017-07-19 end
      else
        @dir
      end
    end
  end
end
~~~




