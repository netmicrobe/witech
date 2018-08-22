---
layout: post
title: jekyll plugins/插件：在文章中用iframe演示html的例子
categories: [ dev, jekyll ]
tags: [ruby, html, iframe, css, javascript]
---

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









































