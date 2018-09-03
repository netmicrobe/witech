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




