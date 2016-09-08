---
layout: post
title: Redmine on Thin
categories: [cm, redmine]
tags: [cm, redmine, thin]
---

## Thin

 
Thin是一个运行rails的web server，比webrick快很多。

参考：

* <https://www.ruby-toolbox.com/categories/web_servers>
* <http://rubydoc.info/gems/thin/frames>


## On Windows

### run redmine on thin

Thin 1.6.1 & Redmine 2.4.2

* 环境
  * redmine-dir：C:\server\redmine\redmine-2.4.2
  * Thin 1.6.1
 
在redmine-dr下执行

bundle exec thin start -p 3000 -c C:\server\redmine\redmine-2.4.2 -e production
 
在其他目录也可以执行

thin start -p 3000 -c C:\server\redmine\redmine-2.4.2 -e production
 
有时会出现错误提示：

```
runtime.rb:34:in `block in setup': You have already activated rack 1.5.2, but your Gemfile requires rack 1.4.5.
```

```
> gem list rack
rack (1.5.2, 1.4.5)
```

会发现有2个版本的rack，卸载到1.5.2的rack就好了，或者返回到redmine-dir下用bundle exec启动。

```
> gem uninstall rack --version 1.5.2
```
 
### 创建Service

 
* 参考：
  * <http://www.dixis.com/?p=140>
  * <http://www.cr173.com/html/15478_1.html>
 
下载微软的工具集 Windows Resource Kit.

<http://www.microsoft.com/downloads/details.aspx?familyid=9d467a69-57ff-4ae7-96ee-b18c4790cffd&displaylang=en>

下载下来是一个rktools.exe的安装文件，双击安装。
 
#### 创建Service

```
---- INSTALL INSTRUCTION ----
C:\Program Files (x86)\Windows Resource Kits\Tools> instsrv "redmine-thin01" "C:\Program Files (x86)\Windows Resource Kits\Tools\srvany.exe"
 
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\[my_service_name]\Parameters]
Application=C:\server\ruby\ruby-1.9.3-p448-i386-mingw32\bin\ruby.exe
AppDirectory=C:\server\redmine\redmine-2.4.2
AppParameters=C:\server\ruby\ruby-1.9.3-p448-i386-mingw32\bin\thin start -p 6000 -e production
```

注册表截图：

![](/images/cm/redmine/config_thin_in_windows_reg_table.png)

#### 删除Service

用如下命令卸载Service：

```
---- UNINSTALL INSTRUCTION ----
instsrv.exe redmine-thin01 REMOVE
```
 
## On Linux

### thin 上配置redmine并启动

thin config -C/etc/thin/<config-name>.yml -c<rails-app-root-path>--servers<number-of-threads>-e<environment>

在当前目录下创建config-name.yml文件，文件内容类似：

```
   ---  
    address: localhost  
    pid: tmp/pids/thin.pid  
    wait: 30  
    port: 3000  
    timeout: 30  
    log: log/thin.log  
    max_conns: 1024  
    require: []  
 
    environment: production  
    max_persistent_conns: 512  
    servers: 5  
    daemonize: true  
    chdir: /var/www/redmine
```
 
thin start -C config-name.yml

即可按照yml配置文件运行thin了。




 
### 修改redmine到网站子目录

 
添加Redmine 子目录设置到 redmine-2.4.2\config\environment.rb

如下：

```
# Initialize the rails application
RedmineApp::Application.initialize!
```
 
#### 添加如下设置

Redmine::Utils::relative_url_root = "/redmine"
 
修改后，redmine所有静态文件（css，js等）相对url都转移到/redmine下，但是redmine app的各个页面仍然在网站根目录上。启动thin添加 --prefix /redmine 参数将app page移到/redmine下。
 
#### 启动 thin

thin start -p 3000 -c C:\server\redmine\redmine-2.4.2 -e production --prefix /redmine

 
#### 参考

http://www.redmine.org/projects/redmine/wiki/HowTo_Install_Redmine_in_a_sub-URI



### apache 负载均衡多个Thin

使用apache balancer module进行负载均衡

 
#### 在apache上启用balancer模块

 
在httpd.conf同时要启用如下模块，不存在则添加：

```
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_balancer_module modules/mod_proxy_balancer.so
LoadModule proxy_http_module modules/mod_proxy_http.so
LoadModule proxy_ajp_module modules/mod_proxy_ajp.so
LoadModule proxy_connect_module modules/mod_proxy_connect.so
LoadModule proxy_ftp_module modules/mod_proxy_ftp.so
 
LoadModule expires_module modules/mod_expires.so
LoadModule headers_module modules/mod_headers.so
LoadModule rewrite_module modules/mod_rewrite.so
 
LoadModule slotmem_shm_module modules/mod_slotmem_shm.so
LoadModule lbmethod_bybusyness_module modules/mod_lbmethod_bybusyness.so
LoadModule lbmethod_byrequests_module modules/mod_lbmethod_byrequests.so
LoadModule lbmethod_bytraffic_module modules/mod_lbmethod_bytraffic.so
```

#### 配置balancer

如下有个例子，详细参数我也不熟悉，有待研究。

```
<Proxy balancer://redminecluster>
 BalancerMember http://127.0.0.1:3000
</Proxy>
#ProxyRequests Off
ProxyPass /redmine balancer://redminecluster
#ProxyPassReverse /redmine balancer://redminecluster
```

#### 参考

<http://limingnihao.iteye.com/blog/1934548>
 















