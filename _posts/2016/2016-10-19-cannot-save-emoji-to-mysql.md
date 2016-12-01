---
layout: post
title: 无法将emoji表情（4字节UTF8字符）保存到mysql
categories: [dev, java, database]
tags: [dev, mysql, emoji, java, hibernate, jdbc]
---


## 错误现象

![](/images/dev/java/database/cannot_save_emoji_to_mysql.png)

```
 SAVE >>>>> COMMIT 95171
 COMMIT STR : [ fix #43898 ] 修改搜索按钮大小 [emoji的笑脸]-redmine的数据也不支持，囧！
 COMMIT STR : 5b2066697820233433383938205d20e4bfaee694b9e6909ce7b4a2e68c89e992aee5a4a7e5b08ff09f9882
 
SQL Error: 1366, SQLState: HY000
Incorrect string value: '\xF0\x9F\x98\x82' for column 'rev_comment' at row 1
SQL Warning Code: 1366, SQLState: HY000
Incorrect string value: '\xF0\x9F\x98\x82' for column 'rev_comment' at row 1

org.hibernate.exception.GenericJDBCException: could not execute statement
	at org.hibernate.exception.internal.StandardSQLExceptionConverter.convert(StandardSQLExceptionConverter.java:54)
	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:126)
	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:112)
	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:211)
	at org.hibernate.id.IdentityGenerator$GetGeneratedKeysDelegate.executeAndExtract(IdentityGenerator.java:96)
	at org.hibernate.id.insert.AbstractReturningDelegate.performInsert(AbstractReturningDelegate.java:58)
	at org.hibernate.persister.entity.AbstractEntityPersister.insert(AbstractEntityPersister.java:3032)
	at org.hibernate.persister.entity.AbstractEntityPersister.insert(AbstractEntityPersister.java:3558)
	at org.hibernate.action.internal.EntityIdentityInsertAction.execute(EntityIdentityInsertAction.java:98)
	at org.hibernate.engine.spi.ActionQueue.execute(ActionQueue.java:492)
	at org.hibernate.engine.spi.ActionQueue.addResolvedEntityInsertAction(ActionQueue.java:197)
	at org.hibernate.engine.spi.ActionQueue.addInsertAction(ActionQueue.java:181)
	at org.hibernate.engine.spi.ActionQueue.addAction(ActionQueue.java:216)
	at org.hibernate.event.internal.AbstractSaveEventListener.addInsertAction(AbstractSaveEventListener.java:334)
	at org.hibernate.event.internal.AbstractSaveEventListener.performSaveOrReplicate(AbstractSaveEventListener.java:289)
	at org.hibernate.event.internal.AbstractSaveEventListener.performSave(AbstractSaveEventListener.java:195)
	at org.hibernate.event.internal.AbstractSaveEventListener.saveWithGeneratedId(AbstractSaveEventListener.java:126)
	at org.hibernate.event.internal.DefaultSaveOrUpdateEventListener.saveWithGeneratedOrRequestedId(DefaultSaveOrUpdateEventListener.java:209)
	at org.hibernate.event.internal.DefaultSaveOrUpdateEventListener.entityIsTransient(DefaultSaveOrUpdateEventListener.java:194)
	at org.hibernate.event.internal.DefaultSaveOrUpdateEventListener.performSaveOrUpdate(DefaultSaveOrUpdateEventListener.java:114)
	at org.hibernate.event.internal.DefaultSaveOrUpdateEventListener.onSaveOrUpdate(DefaultSaveOrUpdateEventListener.java:90)
	at org.hibernate.internal.SessionImpl.fireSaveOrUpdate(SessionImpl.java:684)
	at org.hibernate.internal.SessionImpl.saveOrUpdate(SessionImpl.java:676)
	at org.hibernate.internal.SessionImpl.saveOrUpdate(SessionImpl.java:671)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:606)
	at org.hibernate.context.internal.ThreadLocalSessionContext$TransactionProtectionWrapper.invoke(ThreadLocalSessionContext.java:356)
	at com.sun.proxy.$Proxy3.saveOrUpdate(Unknown Source)
	at net.sf.statsvn.XcqcDBUtils.saveOrUpdateCommit(XcqcDBUtils.java:245)
	at net.sf.statsvn.XcqcDBUtils.saveRepository(XcqcDBUtils.java:113)
	at net.sf.statsvn.input.XcqcRepositoryManager.saveRepository(XcqcRepositoryManager.java:132)
	at net.sf.statsvn.XcqcStat2DB.generateDefaultHTMLSuite(XcqcStat2DB.java:238)
	at net.sf.statsvn.XcqcStat2DB.generate(XcqcStat2DB.java:92)
	at net.sf.statsvn.XcqcStat2DB.main(XcqcStat2DB.java:62)
Caused by: java.sql.SQLException: Incorrect string value: '\xF0\x9F\x98\x82' for column 'rev_comment' at row 1
	at com.mysql.jdbc.SQLError.createSQLException(SQLError.java:1075)
	at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:3562)
	at com.mysql.jdbc.MysqlIO.checkErrorPacket(MysqlIO.java:3494)
	at com.mysql.jdbc.MysqlIO.sendCommand(MysqlIO.java:1960)
	at com.mysql.jdbc.MysqlIO.sqlQueryDirect(MysqlIO.java:2114)
	at com.mysql.jdbc.ConnectionImpl.execSQL(ConnectionImpl.java:2696)
	at com.mysql.jdbc.PreparedStatement.executeInternal(PreparedStatement.java:2105)
	at com.mysql.jdbc.PreparedStatement.executeUpdate(PreparedStatement.java:2398)
	at com.mysql.jdbc.PreparedStatement.executeUpdate(PreparedStatement.java:2316)
	at com.mysql.jdbc.PreparedStatement.executeUpdate(PreparedStatement.java:2301)
	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:208)
	... 32 more
could not execute statement
FAIL TO SACN [ 95171 , 95171  ]
Build step 'Execute shell' marked build as failure
```



## 分析

提交的注释中存在emoji表情（4字节UTF8字符），无法保存，数据表和字段的编码都是 utf8。

需要将数据库表和字段改为 utf8mb4， 从mysql 5.5.3 开始支持 utf8mb4（参见：<https://dev.mysql.com/doc/refman/5.5/en/charset-unicode-utf8mb4.html>）

```sql
ALTER TABLE statsvn.`commits` DEFAULT COLLATE='utf8mb4_general_ci';

ALTER TABLE statsvn.`commits` MODIFY 
	`rev_comment` VARCHAR(4096) NULL DEFAULT NULL COMMENT '提交说明' COLLATE 'utf8mb4_general_ci';

ALTER TABLE statsvn.`commits` MODIFY 
	`memo` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注' COLLATE 'utf8mb4_general_ci';
```

同时，hibernate xml 配置文件不支持 utf8mb4 连接，在代码中work around，参考 <http://stackoverflow.com/questions/24886504/cant-persist-emojis-with-mysql-and-hibernate>

```java
session.doReturningWork(new ReturningWork<Object>() {
    @Override
    public Object execute(Connection conn) throws SQLException {
        try (Statement stmt = conn.createStatement()) {
            stmt.executeQuery("SET NAMES utf8mb4");
        }
        return null;
    }
});
```

## mysql 5.5.3之前版本的解决办法

mysql 5.5.3之前版本，不支持 utf8mb4。不能保存 emoji 字符。

解决方法是，将所有出现注释中的 emoji字符删除后保存到数据库。

```java
/**
 * 删除emoji表情字符（4字节UTF8字符），mysql 5.5.3 以下的版本不能存储这些字符
 * 参考：http://www.oodlestechnologies.com/blogs/How-to-remove-emoji-from-String
 * @param content
 * @return
 */
public static String removeEmojiAndSymbolFromString(String content) {
  String utf8tweet = "";
  try {
    byte[] utf8Bytes = content.getBytes("UTF-8");
    utf8tweet = new String(utf8Bytes, "UTF-8");
  } catch (UnsupportedEncodingException e) {
    e.printStackTrace();
  }
  Pattern unicodeOutliers =
    Pattern.compile(
        "[\ud83c\udc00-\ud83c\udfff]|[\ud83d\udc00-\ud83d\udfff]|[\u2600-\u27ff]",
        Pattern.UNICODE_CASE |
        Pattern.CANON_EQ |
        Pattern.CASE_INSENSITIVE
    );
  Matcher unicodeOutlierMatcher = unicodeOutliers.matcher(utf8tweet);

  utf8tweet = unicodeOutlierMatcher.replaceAll(" ");
  return utf8tweet;
}
```





