---
layout: post
title: Gitlab CI 使用入门
categories: [cm, git, gitlab]
tags: [ci, git, gitlab, integration]
---


* 参考
  * [Getting started with GitLab CI ](https://docs.gitlab.com/ce/ci/quick_start/README.html)
  * [the reference documentation on .gitlab-ci.yml.](https://docs.gitlab.com/ce/ci/yaml/README.html)

## 为项目设置持续集成

1. Add .gitlab-ci.yml to the root directory of your repository
2. Configure a Runner

## .gitlab-ci.yml

* yaml 格式文件，注意缩进，且不要用 Tab 缩进，用空格缩进
* 存放在 repository 的根目录

### an example for a Ruby on Rails project.

```yml
before_script:
  - apt-get update -qq && apt-get install -y -qq sqlite3 libsqlite3-dev nodejs
  - ruby -v
  - which ruby
  - gem install bundler --no-ri --no-rdoc
  - bundle install --jobs $(nproc)  "${FLAGS[@]}"

rspec:
  script:
    - bundle exec rspec

rubocop:
  script:
    - bundle exec rubocop
```






## Runner

In order to have a functional Runner you need to follow two steps:

1. Install it
2. Configure it


































