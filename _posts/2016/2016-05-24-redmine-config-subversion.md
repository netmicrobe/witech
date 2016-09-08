---
layout: post
title: redmine 和 subversion（https）整合
categories: [cm, redmine]
tags: [cm, redmine, subversion]
---

## 问题

subversion是通过apache的https的访问的。

很悲催，这样在redmine项目中创建（配置》版本库》新建版本库），查看版本库，提示404，找不到项目。

查看log（apache2/logs/error_log），提示“svn: E175002"、"服务器证书校验失败证书已经过时, 证书发行者不被信任”

应该是redmine在连接svn时无法接受证书的问题。

## 解决

### 首先，先让redmine能找到证书。


#### （1）先用svn命令以“apache进程用户”执行下。


apache进程用户daemon为例：

用root登录：

mkdir /opt/web/redmine/.subversion

chown -R daemon /opt/web/redmine/.subversion

mkdir /opt/web/redmine/tmpdir

chown -R daemon /opt/web/redmine/tmpdir

用daemon登录：

cd /opt/web/redmine/tmpdir

svn --config-dir /opt/web/redmine/.subversion list https//your-repo-path/


#### （2）使redmine在访问svn的时候，使用刚创建的config dir

修改 /opt/web/redmine/apps/redmine/htdocs/lib/redmine/scm/adapters/subversion_adapter.rb


在self中定义变量存放configdir参数：

{% highlight ruby %}
class << self
  def client_command
    @@bin    ||= SVN_BIN
  end

  def sq_bin
    @@sq_bin ||= shell_quote_command
  end


  def config_dir
    @@config_dir ||= '--config-dir /opt/web/redmine/.subversion'
  end

  ...
{% endhighlight %}


在所有出现svn命令，也即 cmd = "#{self.class.sq_bin}... 的地方添加config dir参数：

例如：

{% highlight ruby %}
def entries(path=nil, identifier=nil, options={})
  path ||= ''
  identifier = (identifier and identifier.to_i > 0) ? identifier.to_i : "HEAD"
  entries = Entries.new
  cmd = "#{self.class.sq_bin} list #{self.class.config_dir} --xml #{target(path)}@#{identifier}"
  cmd << credentials_string
  ...
{% endhighlight %}


#### （3）重启redmine（bitnami），./ctlscript.sh restart apache


#### 查看下apache https用的证书，在hosts文件中设置下域名。


httpd.conf 或者 其include的配置文件中有证书文件位置定义。找到证书文件，用如下命令就可查看证书针对的域名：

##### 查看crt证书

openssl x509 -in certificate.crt -text -noout


例如，如下域名为 egame.svn

```
openssl x509 -in server.crt -text -noout

Certificate:

    Data:

        Version: 1 (0x0)

        Serial Number:

            b2:89:8b:99:14:f7:57:92

        Signature Algorithm: sha1WithRSAEncryption

        Issuer: C=CN, ST=Jiangsu, L=Nanjing, O=CT, CN=egame.svn

        Validity

            Not Before: Jan 11 00:40:45 2013 GMT

            Not After : Jan 11 00:40:45 2014 GMT

        Subject: C=CN, ST=Jiangsu, L=Nanjing, O=CT, CN=egame.svn

        Subject Public Key Info:

            Public Key Algorithm: rsaEncryption

                Public-Key: (1024 bit)

                Modulus:

                    00:d0:8a:28:8b:10:2f:5a:67:e7:c7:64:97:b7:9e:

                    f5:04:7d:7a:3d:d5:60:e9:4e:85:b1:b1:51:63:1d:

                    ea:04:e6:e5:1a:56:42:a6:89:46:15:ef:a8:b7:f6:

                    1b:03:fb:da:8e:5b:3f:60:c8:9b:e9:88:76:1f:77:

                    0e:bd:60:8b:bb:bc:0b:58:22:bc:9e:cb:68:dd:f7:

                    22:b4:d3:ef:ec:5c:d0:3f:65:29:f7:a5:03:62:cf:

                    d4:97:ff:88:87:6e:9a:52:a6:35:0d:2c:db:30:0e:

                    95:9b:83:c8:20:5f:86:dd:6c:3d:4b:15:83:cf:7a:

                    5f:20:40:ff:e7:b7:49:da:73

                Exponent: 65537 (0x10001)

    Signature Algorithm: sha1WithRSAEncryption

        9b:10:55:29:a7:00:c2:24:89:25:15:f5:86:b0:1c:03:23:82:

        aa:61:16:b0:00:5b:3e:9a:cd:0c:5b:b3:39:90:12:6c:17:9c:

        0d:01:83:68:0b:7b:d4:b2:c7:88:71:79:e2:57:da:8f:a4:db:

        a0:aa:b5:85:5d:b7:50:ef:61:c5:59:0e:5e:a1:e3:8e:d0:04:

        c5:76:84:3a:d7:7c:91:8c:70:e8:5e:db:59:36:ff:61:76:cc:

        9e:ef:31:51:d4:b0:9f:de:38:ec:9e:4b:05:13:a8:46:b1:41:

        41:f7:20:d1:28:ea:c5:55:cf:75:6f:9e:fa:68:66:a9:44:17:

        ce:51
```


##### 知道域名后，在redmine运行的机器上设置的下hosts（linux的hosts在/etc/hosts）

127.0.0.1 egame.svn

#### 最后，在redmine上创建新的版本库，host使用刚刚证书中发现的域名。
        

## 背景知识：


intranet中配置https时，一般使用自己生产的证书，方法如下：


自己生产crt证书

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mysitename.key -out mysitename.crt


## 参考：

<https://www.sslshopper.com/article-how-to-create-and-install-an-apache-self-signed-certificate.html>





