---
layout: post
title: 添加新的查询过滤器到Redmine的issue查询界面
date: 2018-07-23 11:40:18 +0800
categories: [ dev, ruby ]
tags: [redmine, rails]
---

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

























