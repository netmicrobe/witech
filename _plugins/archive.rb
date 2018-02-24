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
