---
layout: post
title: 配置tomcat7为系统service
categories: [cm, tomcat]
tags: [cm, tomcat, linux]
---



## 参考：
  * <http://tomcat.apache.org/tomcat-7.0-doc/setup.html>

## 编译jsvc

按照“Tomcat Setup”官方指南编译jsvc
将编译好的jsvc拷贝到$CATALINA_HOME/bin下面

```
    cd $CATALINA_HOME/bin
    tar xvfz commons-daemon-native.tar.gz
    cd commons-daemon-1.0.x-native-src/unix
    ./configure
    make
    cp jsvc ../..
    cd ../..
```

至此，jsvc编译完成，并在 $CATALINA_HOME/bin下面



## 为tomcat创建一个用户

如果使用root启动tomcat service，需要关闭org.apache.catalina.security.SecurityListener 检查设置。
把server.xml中的 \<Listener className="org.apache.catalina.security.SecurityListener" /\>注释掉就可以了

所以，可以为tomcat创建一个专用的用户，依据用途，例如：

```
useradd -d /home/jenkins -s /bin/bash jenkins
passwd jenkins
mkdir /home/jenkins
cp /etc/skel/* /home/jenkins
chown -R jenkins:jenkins /home/jenkins
```

备注：默认模板文件：/etc/skel
里面包括了：.bash_logout   .bash_profile  .bashrc   等文件


## 配置/etc/init.d的启动脚本

启动脚本的模板是 $CATALINA_HOME/bin/daemon.sh
将模板稍作修改，拷贝到/etc/init.d 下即可。
例如，

```
cp $CATALINA_HOME/bin/daemon.sh tomcat7
... modify tomcat7 script file ...
/etc/init.d/tomcat7 start           （作为service启动tomcat7）
```

在tomcat7启动脚本里边的修改：

```
test ".$TOMCAT_USER" = . && TOMCAT_USER=tomcat
```

改为：

```
test ".$TOMCAT_USER" = . && TOMCAT_USER=jenkins
```

在“# ----- Execute The Requested Command ----”之前强制设置下HOME，防止当前root的HOME

```
export HOME=/home/jenkins
```
