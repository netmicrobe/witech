---
layout: post
title: CentOS上安装配置OpenLDAP
categories: [cm, ldap]
tags: [openldap, ldap, centos]
---


* 参考：
  * <http://blog.csdn.net/u013080248/article/details/17512885>
  * <http://blog.sina.com.cn/s/blog_6ccfa4f30100vtv9.html>
  * <http://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-ldap-daemonsutils.html>
  * <http://www.openldap.org/doc/admin24/quickstart.html>
  * <http://www.tldp.org/HOWTO/LDAP-HOWTO/index.html>

## 一、openldap安装：

主要有3个包：openldap、openldap-servers、openldap-clients

```shel
[root@localhost ~]# yum -y install openldap*
或者
yum list *openladp*
yum install openldap.x86_64 openldap-servers.x86_64 openldap-clients.x86_64
```

安装成功会产生一个用户 ldap

再确认下有没安装：

```shell
yum install nss-pam-ldapd.x86_64
yum install mod_authz_ldap.x86_64
yum install php-ldap.x86_64
```

## 二、进入openldap目录，改名或者移动slapd.d目录，否则不会读取slapd.conf文件

```shell
[root@localhost openldap]# cd /etc/openldap/;ls -l
drwxr-xr-x.  2 root root 4096 Dec 22 08:20 certs
-rw-r--r--.  1 root root  282 Aug 24 14:18 ldap.conf
-rw-r--r--.  1 root root  280 Apr 29  2013 ldap.conf.rpmnew
drwxr-xr-x.  2 root root 4096 Dec 22 08:20 schema
drwx------.  3 ldap ldap 4096 Dec 22 08:20 slapd.d
[root@localhost openldap]# mv slap.d  ~/slap.d-bak
```

## 三、创建slapd.conf文件

如果openldap此目录下没有slapd.conf.bak文件，就去openldap-servers目录下拷贝slapd.conf.obsolete，然后改名为slapd.conf

```shell
[root@localhost openldap]# cp /usr/share/openldap-servers/slapd.conf.obsolete .
[root@localhost openldap]# cp slapd.conf.obsolete slapd.conf
```

## 四、配置 slapd.conf

使用slappasswd 生成ldap server登录帐号的密码，将生成的密文保存下来，待会拷贝到 slapd.conf 配置文件中。

```
# slappasswd -h {MD5}--生成MD5格式密码
```

在slapd.conf 中设置bdb数据库

```
 database        bdb
 suffix          "dc=example,dc=com"
 checkpoint      4 15
 rootdn          "cn=manager,dc=example,dc=com"
 # Cleartext passwords, especially for the rootdn, should
 # be avoided.  See slappasswd(8) and slapd.conf(5) for details.
 # Use of strong authentication encouraged.
 # rootpw                secret
   rootpw                {MD5}4QrcOUm6Wau+VuBX8g+IPg==
```

## 五、测试配置文件

```
# slaptest -u -f slapd.conf
config file testing succeeded
或者：
slaptest -f /etc/openldap/slapd.conf -F /etc/openldap/slapd.d
```

这个过程会自动生成 /etc/openldap/slapd.d 文件夹及下面的配置内容


## 六、创建数据库文件

```
# cd /var/lib/ldap/
# cp /usr/share/openldap-servers/DB_CONFIG.example .
# mv DB_CONFIG.example  DB_CONFIG
```

使用root执行来slapadd后，ldap的所有者是root，要改成ldap用户的，才能启动slapd。

```
chown -R ldap /var/lib/ldap
```

## 七、启动LDAP服务，自动创建数据库文件

```
[root@localhost ldap]# service slapd start
```

## 八、导入数据

编辑 base.ldif文件：

```
[root@localhost migrationtools]# vim base.ldif
dn: dc=example,dc=com
dc: example
objectClass: top
objectClass: domain

dn: ou=People,dc=example,dc=com
ou: People
objectClass: top
objectClass: organizationalUnit

dn: ou=Group,dc=example,dc=com
ou: Group
objectClass: top
objectClass: organizationalUnit
```
 
导入base.ldif数据文件：

```
[root@localhost migrationtools]# ldapadd -x -D "cn=manager,dc=example,dc=com" -W -x -f base.ldif
Enter LDAP Password: --输入上面设置好的密码
adding new entry "dc=example,dc=com"
adding new entry "ou=People,dc=example,dc=com"
adding new entry "ou=Group,dc=example,dc=com"
```

## 九、测试

```
[root@localhost migrationtools]# ldapsearch -x -b "ou=People,dc=example,dc=com"
```

## 十、安装配置phpldapadmin

phpldapadmin 提供浏览器图形界面来操作管理openldap
官网地址： <http://phpldapadmin.sourceforge.net/wiki/index.php/Main_Page>

下载；

```
wget http://ncu.dl.sourceforge.net/project/phpldapadmin/phpldapadmin-php5/1.2.3/phpldapadmin-1.2.3.tgz
```

拷贝phpldapadmin-1.2.3/config中 config.php.example 成 config.php 并修改。

配置下语言和时区：

```php
$config->custom->appearance['language'] = 'en_EN';
$config->custom->appearance['timezone'] = 'Asia/Shanghai';
```

配置下管理帐号：

```php
$servers->setValue('login','bind_id','cn=Manager,dc=duzzle,dc=com');
```



## 十一、设置自启动

```
chkconfig --list slapd
chkconfig slapd on
```