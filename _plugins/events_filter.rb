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