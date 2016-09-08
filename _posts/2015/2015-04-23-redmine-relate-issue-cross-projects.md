---
layout: post
title: Redmine 跨项目关联issue
categories: [cm, redmine]
tags: [cm, redmine]
---

Redmine 跨项目关联issue

当前版本不支持，只能通过修改数据库来实现。

```sql
    INSERT INTO issue_relations (issue_from_id, issue_to_id, relation_type)  VALUES(258, 252, 'relates')  
```
    
研究下如何放开该限制。

