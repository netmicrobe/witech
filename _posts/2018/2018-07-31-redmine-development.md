---
layout: post
title: Redmine 开发
date: 2018-07-31 08:55:18 +0800
categories: [ dev, ruby ]
tags: [redmine, rails]
---




## 添加新的查询过滤器到Redmine的issue查询界面

### 在页面上能显示过滤器

1. app/models/issue_query.rb 添加 需要的过滤器

    ~~~ ruby
    def initialize_available_filters
      ... ...
      
      # 添加 需要的过滤器
      add_available_filter "xc_tag_id",
        :type => :list, :label => :label_xc_tags_title, :values => XcTag.all.collect{|s| [s.tagname, s.id.to_s] }

      ... ...
    end
    ~~~


1. app/helpers/queries_helper.rb 放到一个独立的组中

    ~~~ ruby
    def filters_options_for_select(query)
      ungrouped = []
      grouped = {}
      query.available_filters.map do |field, field_options|
        if [:tree, :relation].include?(field_options[:type]) 
          group = :label_relations
        elsif field =~ /^(.+)\./
          # association filters
          group = "field_#{$1}"
        elsif %w(member_of_group assigned_to_role).include?(field)
          group = :field_assigned_to
        elsif %w(xc_tag_id).include?(field)
          group = :label_xc_filters_group # 自定义的过滤器放到一个独立的组中
        elsif field_options[:type] == :date_past || field_options[:type] == :date
          group = :label_date
        end
        ... ...
      end
      ... ...
    end
    ~~~



### 过滤器真正起作用

1. 在 app/models/issue_query.rb 中添加搜索条件
    可以参考所有 sql_for_#{field}_field
    本例中的 #{field} 是 xc_tag_id，之前 add_available_filter 的时候指定的

    Redmine 会自动寻找 sql_for_#{field}_field 模式的函数，
    参考 `app/models/query.rb` 中的 `Query#statement`
    
    ~~~ ruby
    def sql_for_xc_tag_id_field(field, operator, value)
      db_table = Issue.new.association(:xc_tags).options[:join_table]
      "#{db_table}.xc_tag_id #{ operator == '=' ? 'IN' : 'NOT IN' } ( #{value.join(',')} ) "
    end
    ~~~


1. 如果涉及join联合查询，还要在 issue_query.rb 中join对应的relationship
    例如：
    ~~~ ruby
    # app/models/issue.rb
    
    Class Issue < ActiveRecord::Base
      ... ...
      
      # issue的标签，可以有多个
      has_and_belongs_to_many :xc_tags, :join_table => :xc_tags_issues
      
      ... ...
    end
    ~~~

    ~~~ ruby
    # app/models/issue_query.rb
    def base_scope
      ... ...
      jointo = [:status, :project]
      if filters['xc_tag_id']
        jointo << :xc_tags;   # join 过滤条件对于的relation
      end
      Issue.visible.joins(jointo).where(statement)
      ... ...
    end

    def issues(options={})
      ... ...
      jointo = [:status, :project]
      if filters['xc_tag_id']
        jointo << :xc_tags   # join 过滤条件对于的relation
      end
        scope = Issue.visible.
          joins(jointo).
          where(statement).
          includes(([:status, :project] + (options[:include] || [])).uniq).
          where(options[:conditions]).
          order(order_option).
          joins(joins_for_order_statement(order_option.join(','))).
          limit(options[:limit]).
          offset(options[:offset])
      ... ...
    end

    def issue_ids(options={})
      order_option = [group_by_sort_order, options[:order]].flatten.reject(&:blank?)

      jointo = [:status, :project]
      if filters['xc_tag_id']
        jointo << :xc_tags   # join 过滤条件对于的relation
      end
      Issue.visible.
        joins(jointo).
        where(statement).
        includes(([:status, :project] + (options[:include] || [])).uniq).
        references(([:status, :project] + (options[:include] || [])).uniq).
        where(options[:conditions]).
        order(order_option).
        joins(joins_for_order_statement(order_option.join(','))).
        limit(options[:limit]).
        offset(options[:offset]).
        pluck(:id)
    rescue ::ActiveRecord::StatementInvalid => e
      raise StatementInvalid.new(e.message)
    end
    ~~~


## Redmine中使用ajax


### view 代码

~~~ erb
<input class="xc_tags" type="checkbox" name="<%= cboxid %>" id="<%= cboxid %>" 
 onchange="tagIssue('<%= escape_javascript tagissue_xc_tag_path( {:id => tag.id, :issue_id => @issue.id, :format => 'js'} )%>', this); return false;"/>

<script>
// 一般放在独立的js文件中
function tagIssue(url, elem) {
  return $.ajax({
    url: url,
    type: 'get'
  });
}
</script>
~~~


### 目标 contorller

~~~ ruby
  # /xc_tag/1/tagissue/:issue_id
  def tagissue
    begin
      @issue = Issue.find(params[:issue_id])
    rescue ActiveRecord::RecordNotFound
      #render plain: "no such issue", status: 404
      head :no_content
      return
    end
    
    if @xc_tag.issues.exists?(@issue)
      # take off the tag
      @xc_tag.issues.delete(@issue)
    else
      # put the tag on
      @xc_tag.issues << @issue
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end
~~~


#### 目标js

* views\xc_tags\tagissue.js.erb

~~~ erb
alert("<%= @xc_tag.tagname %>");
~~~




## 添加新设置到Redmine管理界面


修改 lib/redmine.rb

~~~ ruby
Redmine::MenuManager.map :admin_menu do |menu|
  ... ...
  menu.push :info, {:controller => 'admin', :action => 'info'}, :caption => :label_information_plural, :last => true
  
  # 添加新的连接到系统管理菜单
  menu.push :your_new_feature, {:controller => 'your_new_feature', :action => 'index'}, :caption => '新的功能设置'
end
~~~

* 效果如下：
  * ![](settings.png)



## 备注（journal）的访问控制

### issue详情页上的备注可见控制

修改 `app/controllers/issues_controller.rb` 的 show action

~~~ ruby
  def show
    @journals = @issue.journals.includes(:user, :details).
                    references(:user, :details).
                    reorder(:created_on, :id).to_a
    @journals.each_with_index {|j,i| j.indice = i+1}
    
    ... ...
    
    # 自定义备注tag的现实规则，目前tag过的备注，都是只给QA组看
    @journals.reject! {|j| j.xc_jtags.size > 0 } unless User.current.is_qa_member?

    ... ...
end
~~~


### 限制备注更新时，邮件发送

~~~ ruby
# app/models/journal.rb

  # 这个 journal 是否只能QA可见
  def visible_only_qa
    xc_jtags.size > 0 # 是否使用了自定义tag（目前自定义tag都是为QA的）
  end

  def each_notification(users, &block)
    if users.any?
    
      # QA 备注，不发邮件给其他人
      if visible_only_qa
        users.select!(&:is_qa_member?)
      end
      
      users_by_details_visibility = users.group_by do |user|
        visible_details(user)
      end
      users_by_details_visibility.each do |visible_details, users|
        if notes? || visible_details.any?
          yield(users)
        end
      end
    end
  end
~~~




























