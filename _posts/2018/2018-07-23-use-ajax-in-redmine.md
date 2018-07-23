---
layout: post
title: Redmine中使用ajax
date: 2018-07-23 11:40:18 +0800
categories: [ dev, ruby ]
tags: [redmine, ajax, rails]
---


### view 代码

~~~ erb
<input class="xc_tags" type="checkbox" name="<%= cboxid %>" id="<%= cboxid %>" 
 onchange="tagIssue('<%= escape_javascript tagissue_xc_tag_path( {:id => tag.id, :issue_id => @issue.id, :format => 'js'} )%>', this); return false;"/>

<script>
// 一般放在独立的js文件中
function tagIssue(url, elem) {
  return $.ajax({
    url: url,
    type: 'get'
  });
}
</script>
~~~


### 目标 contorller

~~~ ruby
  # /xc_tag/1/tagissue/:issue_id
  def tagissue
    begin
      @issue = Issue.find(params[:issue_id])
    rescue ActiveRecord::RecordNotFound
      #render plain: "no such issue", status: 404
      head :no_content
      return
    end
    
    if @xc_tag.issues.exists?(@issue)
      # take off the tag
      @xc_tag.issues.delete(@issue)
    else
      # put the tag on
      @xc_tag.issues << @issue
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end
~~~


#### 目标js

* views\xc_tags\tagissue.js.erb

~~~ erb
alert("<%= @xc_tag.tagname %>");
~~~




