# 列出与page同目录的文件
# 用法示例1：
#   文档中列出这些文件名：{{page.attachments | join ' , '}}
# 用法示例2：
#   {% for attach in page.attachments %}
#   * [{{attach}}]({{attach}})
#   {% endfor %}

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





