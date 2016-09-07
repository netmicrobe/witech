---
layout: post
title: mysql 连接控制 Connection Verification
categories: [cm, mysql]
tags: [cm, mysql, security]
---


## host配置 的示例

<table>
  <tr>
  <td>Host Value</td>
  <td>User Value</td>
  <td>Permissible Connections</td>
  </tr>
  
  <tr>
  <td>'thomas.loc.gov'</td>
  <td>'fred'</td>
  <td>fred, connecting from thomas.loc.gov</td>
  </tr>
  
  <tr>
  <td>'thomas.loc.gov'</td>
  <td>''</td>
  <td>Any user, connecting from thomas.loc.gov</td>
  </tr>
  
  <tr>
  <td>'%'</td>
  <td>'fred'</td>
  <td>fred, connecting from any host</td>
  </tr>
  
  <tr>
  <td>'%'</td>
  <td>''</td>
  <td>Any user, connecting from any host</td>
  </tr>
  
  <tr>
  <td>'%.loc.gov'</td>
  <td>'fred'</td>
  <td>fred, connecting from any host in the loc.gov domain</td>
  </tr>
  
  <tr>
  <td>'x.y.%'</td>
  <td>'fred'</td>
  <td>fred, connecting from x.y.net, x.y.com, x.y.edu, and so on; this is probably not useful</td>
  </tr>
  
  <tr>
  <td>'144.155.166.177'</td>
  <td>'fred'</td>
  <td>fred, connecting from the host with IP address 144.155.166.177</td>
  </tr>
  
  <tr>
  <td>'144.155.166.%'</td>
  <td>'fred'</td>
  <td>fred, connecting from any host in the 144.155.166 class C subnet</td>
  </tr>
  
  <tr>
  <td>'144.155.166.0/255.255.255.0'</td>
  <td>'fred'</td>
  <td>Same as previous example</td>
  </tr>
</table>

## bind-address

如果远程登录不上，可能是my.ini中设置了：

bind-address=127.0.0.1

解决方法：注释掉即可。
 
 
## 参考

<http://dev.mysql.com/doc/refman/5.1/en/connection-access.html>

