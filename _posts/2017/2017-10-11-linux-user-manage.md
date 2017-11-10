---
layout: post
title: linux 用户(user) 管理
categories: [cm, linux]
tags: [linux, useradd, login, userdel ]
---

* 参考
  * <https://www.lifewire.com/create-users-useradd-command-3572157>
  * <https://www.centos.org/docs/5/html/5.1/Deployment_Guide/s2-users-add.html>








## useradd 创建用户

<table>
  <colgroup>
    <col>
    <col>
  </colgroup>
  <thead>
    <tr>
      <th>
      Option
    </th>
      <th>
      Description
    </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
      <code>-c</code> '<em><code>&lt;comment&gt;</code></em>'
    </td>
      <td>
      <em><code>&lt;comment&gt;</code></em> can be replaced with any string. This option is generally used to specify the full name of a user.
    </td>
    </tr>
    <tr>
      <td>
      <code>-d</code><em><code>&lt;home-dir&gt;</code></em>
    </td>
      <td>
      Home directory to be used instead of default <code class="filename">/home/<em><code>&lt;username&gt;</code></em>/</code>
    </td>
    </tr>
    <tr>
      <td>
      <code>-e</code><em><code>&lt;date&gt;</code></em>
    </td>
      <td>
      Date for the account to be disabled in the format YYYY-MM-DD
    </td>
    </tr>
    <tr>
      <td>
      <code>-f</code><em><code>&lt;days&gt;</code></em>
    </td>
      <td>
      Number of days after the password expires until the account is disabled. If <strong class="userinput"><code>0</code></strong> is specified, the account is disabled immediately after the password expires. If <strong class="userinput"><code>-1</code></strong> is specified, the account is not be disabled after the password expires.
    </td>
    </tr>
    <tr>
      <td>
      <code>-g</code><em><code>&lt;group-name&gt;</code></em>
    </td>
      <td>
      Group name or group number for the user's default group. The group must exist prior to being specified here.
    </td>
    </tr>
    <tr>
      <td>
      <code>-G</code><em><code>&lt;group-list&gt;</code></em>
    </td>
      <td>
      List of additional (other than default) group names or group numbers, separated by commas, of which the user is a member. The groups must exist prior to being specified here.
    </td>
    </tr>
    <tr>
      <td>
      <code>-m</code>
    </td>
      <td>
      Create the home directory if it does not exist.
    </td>
    </tr>
    <tr>
      <td>
      <code>-M</code>
    </td>
      <td>
      Do not create the home directory.
    </td>
    </tr>
    <tr>
      <td>
      <code>-n</code>
    </td>
      <td>
      Do not create a user private group for the user.
    </td>
    </tr>
    <tr>
      <td>
      <code>-r</code>
    </td>
      <td>
      Create a system account with a UID less than 500 and without a home directory
    </td>
    </tr>
    <tr>
      <td>
      <code>-p</code><em><code>&lt;password&gt;</code></em>
    </td>
      <td>
      The password encrypted with <code class="command">crypt</code>
    </td>
    </tr>
    <tr>
      <td>
      <code>-s</code>
    </td>
      <td>
      User's login shell, which defaults to <code class="filename">/bin/bash</code>
    </td>
    </tr>
    <tr>
      <td>
      <code>-u</code><em><code>&lt;uid&gt;</code></em>
    </td>
      <td>
      User ID for the user, which must be unique and greater than 499
    </td>
    </tr>
  </tbody>
</table>

### 创建简单用户

~~~ shell
useradd jack
~~~

jack 用户的默认配置，由 /etc/default/useradd 决定

* /etc/default/useradd 文件内容示例：
    ~~~
    $ cat /etc/default/useradd
    # useradd defaults file
    GROUP=100
    HOME=/home
    INACTIVE=-1
    EXPIRE=
    SHELL=/bin/bash
    SKEL=/etc/skel
    CREATE_MAIL_SPOOL=yes
    ~~~


### 创建包含 Home目录 的用户

~~~ shell
useradd -m tom
cd /home/tom
~~~

### 创建用户时，指定非默认的 Home目录

~~~ shell
useradd -m -d /home/guests/trump trump
~~~

### 默认就创建 Home目录，而不需要 `-m` 参数

修改 [/etc/login.defs](#login-defs)

~~~
CREATE_HOME yes
~~~

### 创建一个有期限的用户

~~~ shell
useradd -m -e 2017-10-11 visitor-tony
~~~

### 创建时，将用户指派给Group

~~~ shell
useradd -m -G visitors tony
~~~

### 创建用户时候的高级设置

~~~ shell
# PASS_MAX_DAYS=5 密码5天后过期
# PASS_WARN_AGE=3 提前3天提醒密码将过期
# LOGIN_RETRIES=1 允许输错密码1次
sudo useradd test5 -m -K PASS_MAX_DAYS=5 -K PASS_WARN_AGE=3 -K LOGIN_RETRIES=1
~~~



## 修改 | 设置用户密码

~~~ shell
passwd someone
~~~




## 切换用户

~~~ shell
su - steve
~~~




## usermod 修改用户

### 修改登录后的shell

~~~ shell
usermod -s /bin/bash someone
~~~

### 禁止登录

~~~ shell
usermod -s /bin/nologin someone
~~~









## 用户管理设置


### /etc/login.defs

<a name="login-defs"></a>

* PASS_MAX_DAYS - how long before a password expires 
* PASS_MIN_DAYS - how often can a password be changed
* PASS_WARN_AGE - number of days warning before a password expires
* LOGIN_RETRIES - number of login attempts before failure
* LOGIN_TIMEOUT - how long is it before the login times out.
* DEFAULT_HOME - can a user login if no home folder exists




## userdel 删除用户

~~~
userdel tony
~~~

### `-r` , 连带 Home目录 一起删除

~~~
userdel -r tony
~~~


### `-f` , 强制删除用户，即使该用户仍然登录































