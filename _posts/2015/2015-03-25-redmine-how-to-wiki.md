---
layout: post
title: How to wiki in redmine
categories: [cm, redmine]
tags: [cm, redmine, textile]
---

---

* 参考
  * <http://www.redmine.org/projects/redmine/wiki/RedmineWikis>
  * [Redmine Guide » User Guide » Textile formatting](https://redmine.org/projects/redmine/wiki/RedmineTextFormattingTextile)

---

## 页面管理
 
### 创建新的页面
 
在某个现有页面加一个指向新页面的link，例如，`[[MyNewWikiPage]]`

保存该页面，在页面上点击该link，就会自动创建一个名为 *MyNewWikiPage* 的新页面。


### 页面右边索引

wiki右边索引可以显示常用的链接，在wiki中以名为“Sidebar”的页面存在。

如果不存在，用创建新页面的方式，创建即可。


### 制定页面父子关系

建立父子关系好处：

* 自动创建目录时，目录中能看出层级关系
* 在页面上面有面包屑导航，可以看出层级关系
 
如何做

页面的编辑操作命令中，链接“重命名/重定向”可以完成层级关系指定。



### 自动创建目录

{%raw%}
~~~
> {{toc}} => left aligned toc

> {{>toc}} => right aligned toc
~~~
{%endraw%}

* 注意：`{%raw%}{{>toc}}{%endraw%}` 前后必须都是空行。



## 编辑页面

### 插入缩写

例如：JPL(Jean-Philippe Lang)

效果：显示“JPL”，鼠标悬停显示“Jean-Philippe Lang”

### 插入链接

#### 链接到所在redmine的issue

在issue号前加`#`，例如，`#124`，`#124`前后最好加**空格**，一边系统能区分出来


#### 链接到所在redmine的issue的某个comment

例如，`#124-6` 或者 `#124!#note-6`


#### 链接到wiki页面

~~~
[[Guide]] 链接到名为Guide的页面

[[Guide\|User manual]] 链接到名为Guide的页面，但是在页面上显示User manual
~~~



### 插入图片

#### 上传图片

在当前也上传图片，如，截图.png


#### 插入图片

在2个感叹号之间，插入图片名称，即可在所在位置插入图片，如，`!截图.png!`


#### 缩放图片

如，`!{width:50%}截图.png!`


### 连续插入多个空行

直接回车多次，会被压缩成一个。

在2个`&nbsp;`之间回车多次即可。



### 调整字体颜色

例子：

```
p{color:red}.
%{color:red} inline text%   %号和其他文字接触的地方要有空格
```

### 背景颜色

~~~
%{background:red}本次测试目的、内容和方法%
~~~



## 宏
 
可以在页面中加入宏命令，wiki显示是动态生成所在位置内容。

调用宏的格式，由2个大括号将宏名称括起来：{%raw%}`{{宏名称}}`{%endraw%}
* hello_world
  * 测试宏，显示Sample macro
 
* macro_list
  * 显示左右可用的宏。


### include

* 包含本项目的另外一个 wiki page 进当前wiki页面. Example:
  
  <pre>
  {%raw%}{{include(Foo)}}{%endraw%}
  </pre>
  
* 将特定project 的 wiki 页面包含进当前wiki页面：
  <pre>
  {%raw%}{{include(projectname:Foo)}}{%endraw%}
  </pre>

## 表格
 
横跨多个单元格，示例：`\|\3=. 单元格内容`

竖跨多个单元格，示例：`\|/2=.单元格内容`



## 技巧
 
### 收起内容

{%raw%}<pre>
{{collapse(View Details...)
&gt;&lt;pre&gt;&lt;code&gt;
GET /api/v2/egame/log.json HTTP/1.1
req_log: app_key=8888007&channel_id=10310029&imsi=%24EG01%7E9Joj2M2GiTr9arr2TeJ6VQ%3D%3D&msisdn=&user_id=&version=704&network=wifi&meid=A1000032DF0224&model=unknown&terminal_id=363&screen_px=540*960&api_level=16&brand=unknown&prev_page=MP&curr_page=CH-702&duration=36073&event_key=&event_value=&
param: access_token=c7753bb6dafdb4d166936da8fcc40e2b
Host: open.play.cn
&lt;/code&gt;&lt;/pre&gt;
}}
</pre>{%endraw%}


### 解决pre无法强制换行的问题

修改theme的CSS文件中div.wiki pre配置。


#### 方法一： 直接在默认theme的application.css中修改

文件位置：apps\redmine\htdocs\public\stylesheets\application.css

找到div.wiki pre 配置块，添加强制换行的CSS属性

~~~ css
div.wiki pre {
  margin: 1em 1em 1em 1.6em;
  padding: 8px;
  background-color: #fafafa;
  border: 1px solid #e2e2e2;
  width:auto;
  overflow-x: auto;
  overflow-y: hidden;
              white-space: pre-wrap;
        white-space: -moz-pre-wrap;
        white-space: -pre-wrap;
        white-space: -o-pre-wrap;
        word-wrap: break-word;
}
~~~

#### 方法二： 创建一个自定义的theme，修改它的application.css

将public\stylesheets\application.css拷贝到public\themes\default-wi\stylesheets\application.css

按照方法一进行修改。

在redmine管理界面，设置 -》 显示，选择新建的theme（如，default-wi）。


 
 

 
 
