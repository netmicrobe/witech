---
layout: post
title: postgresql
categories: [cm, database, postgresql]
tags: [cm, database, postgresql]
---

## Admin

### 在 centos 6 上安装

```
yum list \*postgre\*
yum install postgresql-server.i686 postgresql.i686 postgresql-contrib.i686

```

安装完成后，会添加一个linux用户：postgres

```
$ id postgres
uid=26(postgres) gid=26(postgres) groups=26(postgres)
```

安装完成后设置下自启动

```
service postgresql initdb
chkconfig postgresql on 
```

centOS上执行后，数据文件默认存放 /var/lib/pgsql/data

或者

```
root# mkdir /usr/local/pgsql/data
root# chown postgres /usr/local/pgsql/data
root# su postgres
postgres$ initdb -D /usr/local/pgsql/data
```


### 启动 postgresql daemon

可以通过service、postgres命令、postgresql 的 pg_ctl 命令来启动数据库服务器。

启动后，pid 存放在数据目录的 postmaster.pid 文件中。

#### service 启动

```
service postgresql start
```

默认的数据库文件地址：/var/lib/pgsql

#### 手动启动

以 postgresql 的账号登录后，再执行如下启动命令。

* 前台启动

```
$ su postgres -c 'postgres -D /usr/local/pgsql/data'
```

* 后台启动

```
$ postgres -D /usr/local/pgsql/data > logfile 2>&1 &
```

#### pg_ctl 启动

```
pg_ctl start -D /usr/local/pgsql/data -l logfile
```

会在后台启动 postgresql daemon。



### 关闭数据库服务器

pg_ctl stop、service stop 都可以关闭。

手动关闭可以执行：

```
$ kill -INT `head -1 /usr/local/pgsql/data/postmaster.pid`
```

### 开放远程tcpip连接数据库

1. 开放远程连接
  修改 data/postgresql.conf 将 *listen_address = "localhost"* 改为 *listen_address = "\*"*

2. 开放权限
  在 data/pg_hba.conf 中添加
  host    all         all         192.168.56.0/24          trust

3. 重启 postgresql
  service postgresql restart

4. 测试是否成功
  在远程机器上使用 psql 测试：
  psql -h server-address -U postgres
  
* 如果还连接不上？
  
  可能是被 iptables 挡住了。


## 数据库操作

### 创建数据库

createdb mydb

### 删除数据库

dropdb mydb

### 创建用户

CREATE USER foo WITH PASSWORD 'secret';

```
CREATE USER name [ [ WITH ] option [ ... ] ]

where option can be:
    
      SUPERUSER | NOSUPERUSER
    | CREATEDB | NOCREATEDB
    | CREATEROLE | NOCREATEROLE
    | CREATEUSER | NOCREATEUSER
    | INHERIT | NOINHERIT
    | LOGIN | NOLOGIN
    | CONNECTION LIMIT connlimit
    | [ ENCRYPTED | UNENCRYPTED ] PASSWORD 'password'
    | VALID UNTIL 'timestamp' 
    | IN ROLE rolename [, ...]
    | IN GROUP rolename [, ...]
    | ROLE rolename [, ...]
    | ADMIN rolename [, ...]
    | USER rolename [, ...]
    | SYSID uid 
```

CREATE USER is now an alias for CREATE ROLE. The only difference is that when the command is spelled CREATE USER, LOGIN is assumed by default, whereas NOLOGIN is assumed when the command is spelled CREATE ROLE.

* 参考：<https://www.postgresql.org/docs/8.4/static/sql-createuser.html>

### 权限管理

权限管理文件在 /var/lib/pgsql/data/pg_hba.conf 文件中

例如：

```
# TYPE  DATABASE    USER        CIDR-ADDRESS          METHOD

# "local" is for Unix domain socket connections only
local   all         all                               ident
# IPv4 local connections:
host    all         all         127.0.0.1/32          ident
# IPv6 local connections:
host    all         all         ::1/128               ident
```

一共支持 7 种格式：

```
local      database  user  auth-method  [auth-options]
host       database  user  CIDR-address  auth-method  [auth-options]
hostssl    database  user  CIDR-address  auth-method  [auth-options]
hostnossl  database  user  CIDR-address  auth-method  [auth-options]
host       database  user  IP-address  IP-mask  auth-method  [auth-options]
hostssl    database  user  IP-address  IP-mask  auth-method  [auth-options]
hostnossl  database  user  IP-address  IP-mask  auth-method  [auth-options]
```

* database

  * 可能的值：
    * db1-name,db2-name,...
    * <b><u>all</u></b> specifies that it matches all databases. 
    * <b><u>sameuser</u></b> specifies that the record matches if the requested database has the same name as the requested user. 
    * <b><u>samerole 或 samegroup</u></b>  specifies that the requested user must be a member of the role with the same name as the requested database.


* user
  * 可能的值
    * user1,user2,...
    * <b><u>all</u></b> specifies that it matches all users. 
    * <b><u>+group-name</u></b>


#### role 角色

* 参考： <https://www.postgresql.org/docs/8.4/static/user-manag.html>

PostgreSQL manages database access permissions using the concept of roles. 

A role can be thought of as either a database user, or a group of database users, depending on how the role is set up.

Roles can own database objects (for example, tables) and can assign privileges on those objects to other roles to control who has access to which objects.

Furthermore, it is possible to grant membership in a role to another role, thus allowing the member role use of privileges assigned to the role it is a member of.

##### 默认存在的role

  和运行initdb时的用户一个名字，postgres，是“superuser”。

* 创建、删除 role

  CREATE ROLE name;
  DROP ROLE name;

  命令方式

  createuser name
  dropuser name

* 列出所有 role

  SELECT rolname FROM pg_roles;

  或者 pgsql 的命令：

  ```
  mydb=> \du
  ```

* role的属性
  * login privilege ，使用CREATE USER 默认具有 LOGIN 属性，或者 CREATE ROLE rolename **LOGIN**
  * superuser status ，如果是 superuser，无视所有权限检查。 CREATE ROLE name **SUPERUSER** 
  * database creation， 角色是否能够创建数据库，CREATE ROLE name **CREATEDB**
  * role creation， 是否能够创建、删除角色。CREATE ROLE name **CREATEROLE** ，如果要操作 superuser 类型的角色，也需要 SUPERUSER 的权限的。
  * password ， 指定密码， CREATE ROLE name **PASSWORD** 'string'


* 关闭 role 的索引扫描

  ALTER ROLE name SET enable_indexscan TO off;

  重新与此role连接数据库。


* privileges
  
  There are several different kinds of privilege: **SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER, CREATE, CONNECT, TEMPORARY, EXECUTE, and USAGE**
  
  To assign privileges, **GRANT UPDATE ON accounts TO joe;**
  
  To revoke a privilege, **REVOKE ALL ON accounts FROM PUBLIC;**
  
  object‘s ownship 不能 grant 和 revoke，可以将ownship整体转交其他user，同时 owner 自己可以 revoke 一些敏感 privilege，如，将table变为read-only ，来防止误操作。


* 设置 角色关系

  **GRANT** group_role **TO** role1, ... ;
  role1 变为 group_role 成员
  
  **REVOKE** group_role **FROM** role1, ... ;
  role1 从 group_role 移出
  
  ```
  CREATE ROLE joe LOGIN **INHERIT**;
  CREATE ROLE admin **NOINHERIT**;
  CREATE ROLE wheel NOINHERIT;
  GRANT admin TO joe;
  GRANT wheel TO admin;
  ```
  joe 登录后，因为 INHERIT 声明，就有 joe 和 admin 的权限；但是没有 wheel 的权限，因为 admin 是 NOINHERIT ，阻断了继承关系。
  
  主动设置了 admin 身份： **SET ROLE admin;** ，会话拥有 admin 的 privileges，而没有 joe 的 privileges。
  
  主动设置 wheel 身份： **SET ROLE wheel;** ，会话拥有 wheel 的 privileges ，而没有 joe 或者 admin 的 privilegess。
  
  恢复为 自己的身份： **RESET ROLE;**
  
  * 特殊 privilege（LOGIN, SUPERUSER, CREATEDB, and CREATEROLE）不能被 inherite
    
    they are never inherited as ordinary privileges on database objects are. You must actually SET ROLE to a specific role having one of these attributes in order to make use of the attribute.
  
  

## 客户端

### 命令行客户端 psql

#### 登录数据库

psql mydb  登录成功将会显示

```
psql (8.4.22)
Type "help" for help.
 
mydb=>
```

#### 查看帮助

```
mydb=> \h
```


#### 退出登录

```
mydb=> \q
```

#### 查看当前连接的数据库

命令提示符就显示的是 database_name=>

#### 所有数据库

```
mydb=> \l
```

或
psql -l

#### 切换数据库

```
\connect DBNAME
或
\c DBNAME
```

#### 所有表格

```
mydb=> \d
```

#### 所有列

```
mydb=> \d table_name
```

#### 表格详情

```
mydb=> \d+ table_name
```



### pgAdmin 图形客户端

官网： <https://pgadmin.org/>




## SQL

### scheme 信息查询

#### 当前数据库

SELECT current_database();

#### 所有数据库

SELECT * FROM pg_database;

#### 可用的proc

SELECT * FROM pg_proc WHERE proname LIKE 'current%';

#### 所有表

SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

#### 所有列

SELECT column_name FROM information_schema.columns WHERE table_name ='your-table';

### 操作SQL

#### CREATE DATABASE

```
CREATE DATABASE name
    [ [ WITH ] [ OWNER [=] dbowner ]
           [ TEMPLATE [=] template ]
           [ ENCODING [=] encoding ]
           [ LC_COLLATE [=] lc_collate ]
           [ LC_CTYPE [=] lc_ctype ]
           [ TABLESPACE [=] tablespace ]
           [ CONNECTION LIMIT [=] connlimit ] ]
```

* 参考
** <https://www.postgresql.org/docs/8.4/static/sql-createdatabase.html>


#### CREATE/DROP TABLE

```
CREATE TABLE weather (
    city            varchar(80),
    temp_lo         int,           -- low temperature
    temp_hi         int,           -- high temperature
    prcp            real,          -- precipitation
    date            date
);

CREATE TABLE cities (
    name            varchar(80),
    location        point          -- 坐标数据类型，PostgreSql独有的数据类型
);
```

```
DROP TABLE tablename;
```

#### COPY 从文件insert数据

```
COPY weather FROM '/home/user/weather.txt'
```




## 参考

[PostgreSQL 8.4.22 Documentation](https://www.postgresql.org/docs/8.4/static/index.html)




