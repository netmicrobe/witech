---
layout: post
title: rails 开发
categories: [ dev, ruby ]
tags: [ rails, rake, scaffold, command ]
---

---

* 参考
  * [Ruby on Rails Guides (v4.2.10)](https://guides.rubyonrails.org/v4.2/)
---

## i18n 资源

在 config/locales/en.yml 定义 

~~~ yml
label_xc_tags_title: 'Tags'
~~~

在任何view中都可以使用，例如：

~~~ erb
<legend><%= l(:label_xc_tags_title)%></legend>
~~~


## model

* 参考
  * [ruby-china - Active Record 基础](https://ruby-china.github.io/rails-guides/active_record_basics.html)
  * []()
  * []()
  * []()

### 设置多对多关系

~~~ ruby
# FILE: app/models/issue.rb
has_and_belongs_to_many :xc_tags, :join_table => :xc_tags_issues

# FILE: app/models/xc_tag.rb
has_and_belongs_to_many :issues, :join_table => :xc_tags_issues
~~~




## view

### 跨controller，跨格式，引用view

* 跨controller ： `render(:partial => 'another-controller/its-partial-view')`
* 跨格式 ： `render(..., :local => {:format => 'html'})`

~~~ erb
# app/views/xc_tags/tagissue.js.erb

<%# 更新issue备注（历史记录） %>
<% htmlstr = "<h3>#{l(:label_history)}</h3>" %>
<% htmlstr += render(:partial => 'issues/history', :locals => {:format => 'html', :issue => @issue, :journals => @issue.journals }) %>
<% htmlstr.gsub!('"', '\\"') %>
<% htmlstr.gsub!("\n", ' ') %>
$("#history").html("<%= htmlstr.html_safe %>");
~~~


## routes

### 命令行列出所有可用routes

~~~ ruby
bundle exec rake routes

# 某个controller 的 routes
CONTROLLER=users bundle exec rake routes
~~~


### 开发模式直接网页查看 routes

`http://localhost:3000/rails/info/routes`



## 命令行工具

### 自动生成CRUD

~~~ shell
# 会同时生成：db的migraton脚本、model、contorller、view代码
bundle exec rails generate scaffold XcJtag name:string color:string
~~~



## database migration

* [ruby-china - Active Record 迁移](https://ruby-china.github.io/rails-guides/active_record_migrations.html)

### 简单的例子

~~~ ruby
class CreateXcJtags < ActiveRecord::Migration
  def up
    create_table :xc_jtags do |t|
      t.string :name
      t.string :color  # css style 语法

      t.timestamps null: false
    end

    create_join_table :journals, :xc_jtags, :table_name => :xc_jtags_journals

    XcJtag.create(name:"自动QA", color:"color:white; background-color:greenyellow;")
  end

  def down
    drop_table :xc_jtags
    drop_table :xc_jtags_journals
  end
end
~~~

### 执行 migration

~~~ shell

bundle exec rake db:migrate

# migrate 到指定版本
bundle exec rake db:migrate VERSION=20080906120000
~~~

### 回滚 migration

~~~ shell
# 回退一个migration
bundle exec rake db:rollback

# 回退 3个migration
bundle exec rake db:rollback STEP=3
~~~



