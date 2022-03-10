---
layout: post
title: rails-rake-task-使用.md
categories: [dev, ruby]
tags: []
---

* 参考
  * [What is Rake in Ruby & How to Use it](https://www.rubyguides.com/2019/02/ruby-rake/)
  * [How to Write a Custom Rake Task](https://www.seancdavis.com/posts/how-to-write-a-custom-rake-task/)
  * []()
  * []()
  * []()




## How to Write a Rake Task

~~~ruby
desc "Print reminder about eating more fruit."

task :apple do
  puts "Eat more apples!"
end
~~~

using Rails, you can save this under `lib/tasks/apple.rake`.


To run this task:

~~~sh
rake apple
# "Eat more apples!"
~~~


## rake task 开发

*.rake 中除了可以使用ruby，还可以调用其他ruby、sh。

you can copy files with `cp`, create directories with `mkdir_p,` and even change file permissions with `chown`.

~~~sh
task :clean_cache do
  rm_r FileList["tmp/cache/*"]
end
~~~

注意，`rm_r` 可以直接不用确认就删除文件。


### 调用其他 rb 程序

running a Ruby script inside the data folder in my Rails project.

~~~sh
task :import do
  puts "Importing data..."
  Dir.chdir(Rails.root.join("data")) { ruby "load-data.rb" }
end
~~~

### 给 task 限定 namespace

例如， 在 backup namespace 中定义 create、list 

~~~sh
namespace :backup do
  task :create do
    # ...
  end
  task :list do
    # ...
  end
end
~~~

~~~sh
rake backup:create
~~~

### task 的调用依赖

In this example, `load_database` will run before `create_examples`.

~~~
task create_examples: "load_database" do
  # ...
end
~~~


### 调用其他 task


~~~sh
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task["test"].execute
end
~~~

### Use Rake Rules

~~~
task compress: FileList["/tmp/*.txt"].ext(".txt.gz")
rule '.txt.gz' => '.txt' do |t|
  sh "gzip", "-k", "-f", t.source
end
~~~

1. We use the `FileList` class, which is part of Rake, to define a list of files we want to work with.

2. The rule starts with the TARGET extension, to make the rule match we have to use `.ext(".txt.gz")` on the FileList.

3. This `.txt.gz => .txt` doesn’t mean we go from txt.gz to txt, it’s the other way around. The arrow is hash syntax.



## Rake 命令

~~~sh
rake -T (list available tasks)
rake -P (list tasks & their dependencies)
rake -W (list tasks & where they are defined)
rake -V (verbose mode, echo system commands)
rake -t (debugging mode)
rake -f (use a specific Rakefile)
~~~

~~~sh
> rake -T test
rake test         # Runs all tests in test folder except system ones
rake test:db      # Run tests quickly, but also reset db
rake test:system  # Run system tests only
~~~




