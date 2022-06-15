---
layout: post
title: rails 开发
categories: [ dev, ruby ]
tags: [ rails, rake, scaffold, command ]
---

---

* 参考
  * [Ruby on Rails Guides (v4.2.10)](https://guides.rubyonrails.org/v4.2/)
  * [Active Record 基础](https://ruby-china.github.io/rails-guides/active_record_basics.html)
  * []()
  * []()
  * []()
  
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

* 参考
  * <https://guides.rubyonrails.org/v4.2/routing.html>


### 默认 route 和 helper 简单的例子

`resources :photos`

| HTTP Verb | Path | Controller#Action | Used for |
| GET | /photos | photos#index | display a list of all photos |
| GET | /photos/new | photos#new | return an HTML form for creating a new photo |
| POST | /photos | photos#create | create a new photo |
| GET | /photos/:id | photos#show | display a specific photo |
| GET | /photos/:id/edit | photos#edit | return an HTML form for editing a photo |
| PATCH/PUT | /photos/:id | photos#update | update a specific photo |
| DELETE | /photos/:id | photos#destroy | delete a specific photo |

* path helpers：

  * `photos_path` returns `/photos`
  * `new_photo_path` returns `/photos/new`
  * `edit_photo_path(:id)` returns `/photos/:id/edit` (如，edit_photo_path(10) returns /photos/10/edit)
  * `photo_path(:id)` returns /photos/:id (如， photo_path(10) returns /photos/10)

* url helpers:
  把 path helpers 函数名中path替换为url就行了，例如，photos_url ，就是比 photos_path 多了 协议和host的前缀，如，http://your-host/photos

### 嵌入式的route / Nested Resources

~~~ruby
class Magazine < ActiveRecord::Base
  has_many :ads
end
 
class Ad < ActiveRecord::Base
  belongs_to :magazine
end
~~~

* route 规则

~~~
resources :magazines do
  resources :ads
end
~~~

| HTTP Verb | Path | Controller#Action | Used for |
| GET | /magazines/:magazine_id/ads | ads#index | display a list of all ads for a specific magazine |
| GET | /magazines/:magazine_id/ads/new | ads#new | return an HTML form for creating a new ad belonging to a specific magazine |
| POST | /magazines/:magazine_id/ads | ads#create | create a new ad belonging to a specific magazine |
| GET | /magazines/:magazine_id/ads/:id | ads#show | display a specific ad belonging to a specific magazine |
| GET | /magazines/:magazine_id/ads/:id/edit | ads#edit | return an HTML form for editing an ad belonging to a specific magazine |
| PATCH/PUT | /magazines/:magazine_id/ads/:id | ads#update | update a specific ad belonging to a specific magazine |
| DELETE | /magazines/:magazine_id/ads/:id | ads#destroy | delete a specific ad belonging to a specific magazine |


### 命令行列出所有可用routes

在 `config/route.rb` 中配置 route

~~~ ruby
bundle exec rake routes

# 某个controller 的 routes
CONTROLLER=users bundle exec rake routes
~~~

#### helper 生成 path url

`route.rb` 中： `get '/patients/:id', to: 'patients#show', as: 'patient'`

controller 中： `@patient = Patient.find(17)`

view 中 `<%= link_to 'Patient Record', patient_path(@patient) %>` 会生成链接指向 `/patients/17`


#### 默认 route 规则

`route.rb` 中规则从上到下匹配，先匹配先生效。

`GET /patients/17` 匹配 `get '/patients/:id', to: 'patients#show'`

* `resources :objects`

一句route 配置规则，就能覆盖 index, show, new, edit, create, update and destroy actions。


### 开发模式直接网页查看 routes

`http://localhost:3000/rails/info/routes`



## 命令行工具

* [rubyonrails.org - The Rails Command Line](https://guides.rubyonrails.org/command_line.html)


### 自动生成CRUD

~~~ shell
# 会同时生成：db的migraton脚本、model、contorller、view代码
bundle exec rails generate scaffold XcJtag name:string color:string
~~~

### 生成 controller

* 语法

~~~
bin/rails generate controller NAME [action action] [options]
~~~

* 例子

~~~
bin/rails generate controller CreditCards open debit credit close
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



