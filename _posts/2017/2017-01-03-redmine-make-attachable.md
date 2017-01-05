---
layout: post
title: Redmine 中使 model 支持附件（acts_as_attachable）
categories: [dev, rails, redmine]
tags: [dev, ruby, rails, redmine]
---

* 参考
  * [StackOverflow - Redmine How to upload and download file inside plugin?](http://stackoverflow.com/a/31530352)

## In Model
  
  model 添加 acts_as_attachable
  
## In Controller
    
    ```
    helper :attachments
    include AttachmentsHelper
    
    def create
      ...
      @your_model.save_attachments(params[:attachments])
      ...
      @your_model.save()
      ...
    end
    
    def update
      ...
      @your_model.save_attachments(params[:attachments])
      ...
      @your_model.save()
      ...
    end
    ```
    
## In View
  
  view 的 form 添加附件上传
  
    form 添加 :multipart => true
    
    ```
    <%= form_for(@xc_tool, :html => {:id => 'xctool-form', :multipart => true}) do |f| %>
    ```
    
    利用 attachment 的 partial view 添加上传控件
    
    ```
    <div class="tabular_div">
        <label><b><%= l(:label_xc_tool_icon) %></b></label>
        
        <div style="display: inline; clear: both;">
          <%= render :partial => 'attachments/form', :locals => {:container => @xc_tool, :has_one => true} %>
          
          <% if attachment = @xc_tool.attachments.first %>
            <%= link_to(
              image_tag(
                url_for({:controller => 'attachments', :action => 'download', :id => attachment }),
                :width => '200' ),
              {:controller => 'attachments', :action => 'download', :id => attachment, :filename => attachment.filename}
              )
            %>
            <%= link_to image_tag('delete.png'), attachment_path(attachment),
                                                 :data => {:confirm => l(:text_are_you_sure)},
                                                 :method => :delete,
                                                 :class => 'delete',
                                                 :title => l(:button_delete) %>
          <% else %>
          <%= image_tag('default_tool_icon.png') %>
          <% end %>
        </div>
    </div>
    ```

  





