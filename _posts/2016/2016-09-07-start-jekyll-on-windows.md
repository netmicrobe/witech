---
layout: post
title: 在 Windows上使用 jekyll 写博客，发布到 Githubs
categories: [cm, jekyll]
tags: [cm, jekyll, githubs, markdown]
---

## 安装 ruby 环境

下载后解压即可，后面将执行路径配置到 path 环境变量就好了。

* *注意*
  * 目前命令都在windows command line 下执行的，没试过 Cygwin 啊

### ruby 1.9.3 & Devkit

<div markdown="0"><a href="http://pan.baidu.com/s/1dFn0TRr" class="btn btn-success">ruby 1.9.3</a></div>
<div markdown="0"><a href="https://pan.baidu.com/s/1dE3zIpj" class="btn btn-success">Devkit_for_1.8.7_and_1.9.3</a></div>


### ruby 2.0.0 & Devkit

<div markdown="0"><a href="http://pan.baidu.com/s/1dFdX0Al" class="btn btn-success">ruby 2.0.0</a></div>
<div markdown="0"><a href="http://pan.baidu.com/s/1bo4PFzx" class="btn btn-success">Devkit_for_Ruby2.0_and_above_32bits</a></div>
<div markdown="0"><a href="http://pan.baidu.com/s/1c1752rY" class="btn btn-success">Devkit_for_Ruby2.0_and_above_64bits</a></div>


### 为什么同时使用 1.9.3 和 2.0.0

可能一些基于jekyll 2 的 theme，在 jekyll 3 下运行，要调整下 _config.yml 或者 Gemfile

* jekyll 2
  * Required Ruby Version: >= 1.9.3
  
* jekyll 3
  * Required Ruby Version: >= 2.0.0

### 调整 ruby gem 源

~~~
# 用的 ruby china 的国内镜像
gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
~~~


* 默认源：http://rubygems.org/
  国外源速度奇慢，不知为何。。呵呵。。

* 其他国内源：
  * 淘宝 https://ruby.taobao.org
    淘宝的源用的 https ，可能有证书问题
  * 中山大学  http://mirror.sysu.edu.cn/rubygems/

* 查看目前的下载源： # gem sources
* 添加下载源： # gem sources --add https://ruby.taobao.org --remove 不需要的源


### 安装 jekyll等gems

gem install jekyll bundler


## 使用 jekyll 模板

### 使用 jekyll 默认模板

```shell
~ $ gem install jekyll bundler
~ $ jekyll new myblog
~ $ cd myblog
~/myblog $ bundle install
~/myblog $ bundle exec jekyll serve
# => Now browse to http://localhost:4000
```

### 要好看的、现成的theme

搜索“best jekyll theme”之类，自己去下载咯

我下载了一些，放在 [jekyll themes](http://pan.baidu.com/s/1dFJoVDn)


## 编写 blog

在 jekyll 模板的 _post 目录下按照格式  日期-英文说明.md（例如，2016-09-07-start-jekyll-on-windows.md） 创建文件

使用 markdown 和 [Liquid template Language](https://github.com/shopify/liquid/wiki/Liquid-for-Designers) 的语法编写blog，保存

在 jekyll 模板根目录运行如下命令，如果模板根目录下没有 Gemfile 这个文件，就不要在命令开头加“bundle exec ”

```
bundle exec jekyll build
bundle exec jekyll serve
```

然后浏览器打开 localhost:4000 ，就看到在本地服务器的博客了



### Liquid Template Language

#### 显示博客索引

{% raw %}
```
<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>
```
{% endraw %}



#### 博客摘要

{% raw %}
```
<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>
```
{% endraw %}

* 这样生成的“摘要”前后会有 \<p\> 标签，要删除p标签的话：

{% raw %}
```
{{ post.excerpt | remove: '<p>' | remove: '</p>' }}
```
{% endraw %}

* 自己定义“摘要”分隔符

默认“摘要”分隔符是 \<!\-- more \--\>

在 post 头的yaml定义区，添加自定义的设置

excerpt_separator: \<!\-- end-of-summary \--\>



#### 语法高亮

highlight language [linenos]

写了 linenos 可以显示行号，也可以不写。

{% raw %}
```
{% highlight ruby linenos%}
def show
  @widget = Widget(params[:id])
  respond_to do |format|
    format.html # show.html.erb
    format.json { render json: @widget }
  end
end
{% endhighlight %}
```
{% endraw %}


### markdown


#### 使用反斜杠 \ 转义


* 转义 html tags

文档中 \< \> 成对出现时，markdown 会解释为html的tag，所以需要写成 \\\< content-in-angle-brackets \\\>

尖括号单个出现是，markdown 解释器还比较智能，能很好处理。

* 转义 \--

默认 \-- 会被转换为 -- ，这会导致技术文档很郁闷啊，拷贝个命令，参数都错误。。。

使用 \\\-- 转义，就会显示为 \--



#### 为url加链接

\<url\> ，例如，

```
\<http://www.google.com\>
```

{% raw %}
```
... you can [get the PDF]({{ site.url }}/assets/mydoc.pdf) directly.
```
{% endraw %}



#### 添加图片

{% raw %}
```
![My helpful screenshot]({{ site.url }}/assets/screenshot.jpg)
```
{% endraw %}




#### 链接到当前页面的某个位置

1. 添加锚点
  ```<a name="your-anchor"></a>```
2. 添加链接，跳转到锚点
  ```[link text](#your-anchor)```

* 参考： <http://stackoverflow.com/a/7015050>







### 为啥 textile 在windows上不支持

使用 [*.textile](http://redcloth.org/textile) 需要 jekyll-textile-converter gem 在windows上安装有问题，还不知道为啥，为啥呢。。。。


## 发布到 Github

参考：<https://jekyllrb.com/docs/github-pages/>

1. 安装 gem install github-pages
2. 注册 Github 账号
3. 登录 Github 后，创建一个新的版本库，名字必须是；your-github-account-name.github.io
4. 在 Github 账号中设置 “Github Pages”相关的选项，例如，选择主干。
5. 设置本地库的remote地址： git remote add origin your-github-repo-url
6. 发布： git push origin master






## 参考

### 官方文档

<https://jekyllrb.com/docs/home/>







