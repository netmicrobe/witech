---
layout: post
title: 常用 jekyll plugins/插件 的源码和说明
categories: [ dev, jekyll ]
tags: [ruby, html, iframe, css, javascript]
---

## iframe_with_content.rb : 在文章中用iframe演示html的例子

### 方法一，js添加iframe

拷贝如下文件到 plugins 目录

* iframe_with_content.rb

{%raw%}
~~~ ruby
# 生成一个iframe，包含指定的内容
# 例如：
# {%iframe basic_sample%}
# <html><body><p>samples</p></body></html>
# {%endiframe%}
# 

module Jekyll
  class RenderIframeTag < Liquid::Block

    def initialize(tag_name, input, tokens)
      super
      @container_id = input
    end

    def render(context)
      output_text = <<EOT
<div id='#{@container_id}'></div>
<script type="text/javascript">
$( document ).ready(function() {
  var iframe = document.createElement('iframe');
  document.getElementById('#{@container_id}').appendChild(iframe);
  var doc = iframe.document;
  if(iframe.contentDocument)
    doc = iframe.contentDocument; // For NS6
  else if(iframe.contentWindow)
    doc = iframe.contentWindow.document; // For IE5.5 and IE6
  // Put the content in the iframe
  doc.open();
  doc.write(\"#{super.to_s.gsub(/[\n\r]/, ' ').gsub('"', '\\"')}\");
  doc.close();
});
</script>
EOT
    end
  end
end

Liquid::Template.register_tag('iframe', Jekyll::RenderIframeTag)
~~~
{%endraw%}


### 方法二，ruby添加iframe

方法一，html document 中出现 `<script>` 的时候，就乱拉。

SO，改为使用ruby添加iframe，可以避免。

* iframe_with_content.rb

  ~~~ ruby
  # 生成一个iframe，包含指定的内容
  # 例如：
  # {%iframe basic_sample%}
  # <html><body><p>samples</p></body></html>
  # {%endiframe%}
  # 

  module Jekyll
    class RenderIframeTag < Liquid::Block

      def initialize(tag_name, input, tokens)
        super
        @container_id = input
      end

      def render(context)
      
        site = context.registers[:site]
        page = context.registers[:page]
        distdir = File.expand_path("../.", page.destination(''))
        
        if !Dir.exist?(distdir)
          FileUtils.mkdir_p(distdir)
          FileUtils.chmod("u=rwx,go=rx", distdir)
        end
        
        filename = Time.now.strftime('%Y%m%d%H%M%S%L') << '.html';
        filepath = File.expand_path(filename, distdir)
        
        File.open(filepath, 'w') do |f|
          f.write("#{super.to_s}")
        end
        
        output_text = <<EOT
  <iframe class="embeded-iframe" src="#{filename}"></iframe>
  EOT
      end
    end
    
    module Drops
      class DocumentDrop
        def_delegators :@obj, :destination
      end
    end
    
    class Site
      # cleanup 会把 render 阶段生成的文件给删掉，
      # 所以将 clearup 提前到 render 前面
      def process
        reset
        read
        generate
        cleanup
        render
        write
        print_stats
      end
    end
  end

  Liquid::Template.register_tag('iframe', Jekyll::RenderIframeTag)
  ~~~

* script.html

  ~~~ html
  <script type="text/javascript">
    // embeded-iframe
    $(window).load(function(){
      $('.embeded-iframe').each(function(){
        $(this).height($(this).contents().find('html').height());
      });
    });
  </script>
  ~~~



## list_attachments.rb : 列出与page同目录的文件

列出与page同目录的文件，与插件 `along_with_resource.rb` 配合

* 用法示例1：
  文档中列出这些文件名：`{%raw%}{{page.attachments | join ' , '}}{%endraw%}`
* 用法示例2：
  ~~~ liquid
  {%raw%}
  {% for attach in page.attachments %}
  * [{{attach}}]({{attach}})
  {% endfor %}
  {%endraw%}
  ~~~

### list_attachments.rb

~~~ ruby
# 列出与page同目录的文件

module Jekyll
  module Drops
    class DocumentDrop
      def_delegators :@obj, :site, :basename_without_ext
      def attachments
        post_absolute_path = site.in_source_dir(relative_path)
        assets_folder = File.expand_path("../#{basename_without_ext}", post_absolute_path)
        
        # 如果目录存在，就将其中的所有文件的文件名放入数组，返回
        #
        # windows 上从文件系统获取的字符串很可能是 GBK 编码
        # 需要强制转换成 UTF-8
        # 否则有如下报错：
        # Liquid Exception: incompatible character encodings: UTF-8 and GBK in ...
        
        files = []
        if Dir.exist?(assets_folder)
          files = Dir.entries(assets_folder).map {|f| f.encode("utf-8")};
          files = files.select do |f|
            File.file?(File.expand_path(f, assets_folder))
          end
        end
        files
      end
    end
  end
end
~~~




## along_with_resources.rb : Jekyll 上，将资源（图片等）和文档放在同一目录


### 缘起

jekyll 一般都要将图片等附件，放到根目录的 images/ 或者 assets/img 等，最后也不知道这些图片被哪些文档使用。

把图片等资源和post放到一起岂不是很好呢！


### 把图片等资源和post放到一起

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

### 把图片等资源和 collection 的 Document 放到一起

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



## gather_cates_tags.rb : 重写 site.categories / site.tags ，将 page 的 categories & tags 收纳进来。


重写 Jekyll::Site 的 tags 和 categories 方法，将 page 的 categories & tags 收纳进来。

原版的 site.categories / site.tags 只包含 posts （_posts collection 中的带日期的 doc）

* **gather_cates_tags.rb**

~~~ ruby
module Jekyll
  class Site
    
    # 
    # 将其他 colleciton 中 document 排入 site.categories
    # 
    def categories_with_pages
      # 获取 _posts 的 categories， jekyll 自带
      cates = categories_without_pages
      
      # 将其他 colleciton 中 document 排入 site.categories
      collections.each do |k, v|
        next if k == 'posts'
        v.docs.each do |doc|
          # Add doc into categories
          if doc.data['categories']
            doc.data['categories'].each do |cate|
              # category 可以支持 utf-8 中文，在模板中使用 ['chinese-cate']的方式引用
              # 例如： {%raw%}{% for page in site.categories['运维'] %}{%endraw%}
              #        {%raw%}{{ page.title }}{%endraw%}<br/>
              #        {%raw%}{% endfor %}{%endraw%}
              cates[cate.force_encoding('utf-8')] << doc
            end
          end
        end
      end
      
      cates
    end
    
    alias_method :categories_without_pages, :categories
    alias_method :categories, :categories_with_pages
    
    #
    # 将其他 colleciton 中 document 排入 site.tags
    #
    def tags_with_pages
      # 获取 _posts 的 tags， jekyll 自带
      tags = tags_without_pages
      collections.each do |k, v|
        next if k == "posts"
        v.docs.each do |doc|
          if doc.data['tags']
            doc.data['tags'].each do |t|
              tags[t.force_encoding('utf-8')] << doc
            end
          end
        end
      end
      
      tags
    end
    
    alias_method :tags_without_pages, :tags
    alias_method :tags, :tags_with_pages
  end

end

~~~


## archive.rb : 按月排布的posts

~~~ ruby
module Jekyll
  class Site
    
    # 
    # site.archives 包含按月排布的posts
    # 
    def archives
      hash = Hash.new { |h, key| h[key] = [] }

      # In Jekyll 3, Collection#each should be called on the #docs array directly.
      if Jekyll::VERSION >= "3.0.0"
        self.posts.docs.reverse.each { |p| hash[p.date.strftime("%Y-%m")] << p }
      else
        self.posts.reverse.each { |p| hash[p.date.strftime("%Y-%m")] << p }
      end
      hash.values.each { |posts| posts.sort!.reverse! }
      hash
    end

  end # Site
  
  module Drops
    class SiteDrop
      def_delegators :@obj, :archives
    end
  end
end

~~~






## events_filter.rb : site信息打印工具

~~~ ruby
module Jekyll
  module EventsFilter
    def project_events(input)
      input.select do |p|
        ret = false
        if ret = p.relative_path.start_with?("_xcdocs/项目管理/变更记录")
          p.data['xctype'] = '变更记录'
        elsif ret = p.relative_path.start_with?("_xcdocs/项目管理/发布记录")
          p.data['xctype'] = '发布记录'
        elsif ret = p.relative_path.start_with?("_xcdocs/项目管理/会议纪要")
          p.data['xctype'] = '会议纪要'
        elsif ret = p.relative_path.start_with?("_xcdocs/项目管理/里程碑")
          p.data['xctype'] = '里程碑'
        end
        ret
      end
    end
    
    def docs_in_dir(input, dir)
      input.select do |p|
        p.relative_path.start_with?(dir)
      end
    end
    
    def docs_of_category(input, category)
      input.select do |p|
        p.data['categories'].include?(category) if p.data['categories'] != nil
      end
    end

    def reverse(input)
      input.reverse
    end
    
    # usage: {{ site | print_site_info }}
    def print_site_info(input)
      # input = @context.registers[:site]  # other way to get site
      info = "\n"
      info << "\n * site : #{input.class}"
      info << "\n   * site time : #{input.time}"
      info << "\n   * site data : #{input.data.class}" if input.data != nil
      info << "\n   * site pages : #{input.pages[0].class}" if input.pages[0] != nil
      info << "\n   * site documents : #{input.documents[0].class}" if input.documents[0] != nil
      info << "\n   * site static_files : #{input.static_files[0].class}" if input.static_files[0] != nil
      info << "\n   * site categories : #{input.categories.keys}"
      info << "\n   * * * * * * * * * : #{print_categories(input.categories)}"
      info << "\n   * site tags : #{input.tags.keys}"
      info << "\n   * * * * * * * * * : #{print_tags(input.tags)}"
      info << "\n"
    end
    
    # 打印所有主类别
    # usage: {{ site | print_main_categories }}
    def print_main_categories(input)
      info = "\n"
      info << "\n * site : #{input.class}"
      info << "\n   * site main_categories :"
      input.main_categories.each do |cate|
        info << "\n       * [ cate ] : #{cate}"
      end
      info << "\n"
    end
    
    # 打印 archives
    # usage: <pre>{{ site | print_archives }}</pre>
    def print_archives(input)
      info = "\n"
      info << "\n * site : #{input.class}"
      info << "\n   * site archives :"
      input.archives.each do |month, posts|
        info << "\n       * [ month ] : #{month}"
        if posts
          posts.each {|p| info << "\n             * [ doc ] : #{p.data['title']}" }
        else
          info << "\n             * [ no doc ]}" 
        end
      end
      info << "\n"
    end
    
    def print_categories(cates)
      info = "#{cates.class}"
      cates.each do |k, v|
        info << "\n       * [ category ] : #{k}"
        v.each do |doc|
          info << "\n           * [ doc ] : #{doc.data['title']}"
        end
      end
      info
    end

    def print_tags(tags)
      info = "#{tags.class}"
      tags.each do |k, v|
        info << "\n       * [ tag ] : #{k}"
        v.each do |doc|
          info << "\n           * [ doc ] : #{doc.data['title']}"
        end
      end
      info
    end

    def print_page_info(input)
      # print page's info
      info = "\n"
      info << "## input.class : #{input.class}"
      info << "\n"
      input.each do |p|
        info << "\n\n* #{p.class}"
        
        info << "\n  * data = "
        p.data.each_key { |key| info << "#{key} " }
        info << "\n  * data[:title] = #{p.data['title']}"
        info << "\n  * data[:layout] = #{p.data['layout']}"
        info << "\n  * data[:draft] = #{p.data['draft']}"
        info << "\n  * data[:date] = #{p.data['date']}"
        info << "\n  * data[:ext] = #{p.data['ext']}"
        tags = p.data['tags'].map {|c| c.force_encoding('utf-8') }.join(" , ")
        info << "\n  * data[:tags] = #{tags}"
        cates = p.data['categories'].map {|c| c.force_encoding('utf-8') }.join(" , ")
        info << "\n  * data[:categories] = #{cates}"
        #info << "\n  * data[:categories] = #{p.data['categories']}"
                
        info << "\n  * url = #{p.url}" if p.respond_to?(:url)
        info << "\n  * date __#{p.date.class}__ = #{p.date}" if p.respond_to?(:date)
        info << "\n  * path = #{p.path}" if p.respond_to?(:path)
        info << "\n  * relative_path = #{p.relative_path}" if p.respond_to?(:relative_path)
        info << "\n  * name = #{p.name}" if p.respond_to?(:name)
        info << "\n  * id = #{p.id}" if p.respond_to?(:id)
      end
      info << "\n"
    end
  end
end

Liquid::Template.register_filter(Jekyll::EventsFilter)
~~~






































































































