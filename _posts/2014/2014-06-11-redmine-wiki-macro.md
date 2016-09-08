---
layout: post
title: redmine：wiki macro，包含其他wiki页
categories: [cm, redmine]
tags: [cm, redmine, wiki]
---

## include

Include a wiki page. Example:

{%raw%}{{include(Foo)}}{%endraw%}

or to include a page of a specific project wiki:

{%raw%}{{include(projectname:Foo)}}{%endraw%}