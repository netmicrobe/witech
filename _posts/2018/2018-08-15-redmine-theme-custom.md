---
layout: post
title: Redmine 主题（theme）自定义
categories: [ cm, redmine ]
tags: [css]
---


---

* REFER TO
  * [redmine.org - HowTo create a custom Redmine theme](http://www.redmine.org/projects/redmine/wiki/HowTo_create_a_custom_Redmine_theme)


---


## Creating a new theme

Create a directory in public/themes. The directory name will be used as the theme name.

Example:

`public/themes/my_theme`

Create your custom `application.css` and save it in a subdirectory named stylesheets:

`public/themes/my_theme/stylesheets/application.css`

application.css 自定义的例子：

~~~ css
/* load the default Redmine stylesheet */
@import url(../../../stylesheets/application.css);

/* add a logo in the header */
#header {
    background: #507AAA url(../images/logo.png) no-repeat 2px;
    padding-left: 86px;
}

/* move the project menu to the right */
#main-menu { 
    left: auto;
    right: 0px;
}
~~~












