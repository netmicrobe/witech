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
              # 例如： {% for page in site.categories['运维'] %}
              #        {{ page.title }}<br/>
              #        {% endfor %}
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
    
  public
    # 
    # 将 page 的 第一个 category 搜集起来，放入 site.main_categories
    # 作为主要类别，避免显示类别太多的问题
    # 
    def main_categories
      cates = Set.new
      
      # 遍历所有 documents
      collections.each do |k, v|
        v.docs.each do |doc|
          # 找到主类别（第一个类别）
          if doc.data['categories'] && doc.data['categories'].first
            main_cate = doc.data['categories'].first.force_encoding('utf-8')
            cates << main_cate
          end
        end
      end
      
      cates.to_a
    end
    
    # 
    # 将 posts 的 第一个 category 搜集起来
    # 作为主要类别，避免显示类别太多的问题
    # 
    def main_categories_of_posts
      cates = Set.new
      
      # 遍历所有博客的主类别
      collections["posts"].docs.each do |doc|
        # 找到主类别（第一个类别）
        if doc.data['categories'] && doc.data['categories'].first
          main_cate = doc.data['categories'].first.force_encoding('utf-8')
          cates << main_cate
        end
      end
      
      cates.to_a
    end
  end
  
  module Drops
    class SiteDrop
      def_delegators :@obj, :main_categories
      def_delegators :@obj, :main_categories_of_posts
      def_delegators :@obj, :categories_without_pages
    end
  end
end
