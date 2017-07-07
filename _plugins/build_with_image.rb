# encoding: UTF-8

module Jekyll
  # Reader.retrieve_posts 没有检查文件是合法的post，还是二进制文件。
  # 所以，当 _post 文件夹中放置二进制文件（例如，图片）会导致 Liquid 报错，
  # 例如：
  #   Liquid Exception: invalid byte sequence in UTF-8 in _post/some-pic.jpg
  #
  # 重写 Reader.get_entries
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


