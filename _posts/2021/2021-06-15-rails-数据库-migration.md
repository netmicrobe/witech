---
layout: post
title: rails-数据库-migration
categories: [ dev, ruby ]
tags: [ rails, rake, migration, database ]
---

---

* 参考
  * [Ruby on Rails Guides (v4.2.10)](https://guides.rubyonrails.org/v4.2/)
  * [ruby-china - Active Record 迁移](https://ruby-china.github.io/rails-guides/active_record_migrations.html)
  * []()
---



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




## 创建 migration

`bin/rails generate migration your-migration-file-name` 来创建 migration,

自动生成后，可以修改 `db/migrate/YYYYMMDDHHMMSS_your-migration-file-name.rb` 文件，根据需要增删代码。

### 添加字段
~~~
bin/rails generate migration AddPartNumberToProducts
~~~

如果迁移名称是 AddXXXToYYY 或 RemoveXXXFromYYY 的形式，并且后面跟着字段名和类型列表，那么会生成包含合适的 add_column 或 remove_column 语句的迁移。

~~~
bin/rails generate migration AddPartNumberToProducts part_number:string
~~~

~~~ ruby
class AddPartNumberToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :part_number, :string
  end
end
~~~

### 创建表格、model

如果迁移名称是 CreateXXX 的形式，并且后面跟着字段名和类型列表，那么会生成用于创建包含指定字段的 XXX 数据表的迁移。例如：

~~~
bin/rails generate migration CreateProducts name:string part_number:string
~~~

~~~ ruby
class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :part_number
    end
  end
end
~~~

~~~
bin/rails generate model Product name:string description:text
~~~

~~~ ruby
class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
 
      t.timestamps
    end
  end
end
~~~








## 执行 migration


### 执行 migration

~~~ shell
# 之前所有的迁移
bundle exec rake db:migrate

# 如果指定了目标版本，Active Record 会运行该版本之前的所有迁移
bundle exec rake db:migrate VERSION=20080906120000
~~~


### 回滚 migration

~~~ shell
# 回退一个migration
bundle exec rake db:rollback

# 回退 3个migration
bundle exec rake db:rollback STEP=3

# redo 任务用于回滚最后一个迁移并再次运行这个迁移。
bin/rails db:migrate:redo STEP=3
~~~


### 安装数据库 rails db:setup

用于创建数据库，加载数据库模式，并使用种子数据初始化数据库。

### 重置数据库 rails db:reset

用于删除并重新创建数据库，其功能相当于 `rails db:drop db:setup`。


### 运行指定迁移

要想运行或撤销指定迁移，可以使用 db:migrate:up 和 db:migrate:down 任务。只需指定版本，对应迁移就会调用它的 change 、up 或 down 方法，例如：

~~~
$ bin/rails db:migrate:up VERSION=20080906120000
~~~

上面的命令会运行 20080906120000 这个迁移，调用它的 change 或 up 方法。db:migrate:up 任务会检查指定迁移是否已经运行过，如果已经运行过就不会执行任何操作。


### 在不同环境中运行迁移

`bin/rails db:migrate` 任务默认在**开发环境**中运行迁移。要想在其他环境中运行迁移，可以在执行任务时使用 RAILS_ENV 环境变量说明所需环境。例如，要想在测试环境中运行迁移，可以执行下面的命令：

~~~
$ bin/rails db:migrate RAILS_ENV=test
~~~


### 修改迁移运行时的输出

运行迁移时，默认会输出正在进行的操作，以及操作所花费的时间。

~~~ ruby
class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    suppress_messages do
      create_table :products do |t|
        t.string :name
        t.text :description
        t.timestamps
      end
    end
 
    say "Created a table"
 
    suppress_messages {add_index :products, :name}
    say "and an index!", true
 
    say_with_time 'Waiting for a while' do
      sleep 10
      250
    end
  end
end
~~~

会生成下面的输出：

~~~
==  CreateProducts: migrating =================================================
-- Created a table
   -> and an index!
-- Waiting for a while
   -> 10.0013s
   -> 250 rows
==  CreateProducts: migrated (10.0054s) =======================================
~~~

要是不想让 Active Record 生成任何输出，可以使用 `rails db:migrate VERBOSE=false`。




## 利用 migration 添加或修改数据

对于不能删除和重建的数据库，如生产环境的数据库，这些功能非常有用。

~~~ ruby
class AddInitialProducts < ActiveRecord::Migration[5.0]
  def up
    5.times do |i|
      Product.create(name: "Product ##{i}", description: "A product.")
    end
  end
 
  def down
    Product.delete_all
  end
end
~~~

### 种子数据

在开发和测试环境中，经常需要重新加载数据库，这时“种子”特性就更有用了。使用“种子”特性很容易，只要用 Ruby 代码填充 db/seeds.rb 文件，然后执行 `rails db:seed` 命令即可：

~~~
5.times do |i|
  Product.create(name: "Product ##{i}", description: "A product.")
end
~~~

相比之下，这种设置新建应用数据库的方法更加干净利落。






























































































