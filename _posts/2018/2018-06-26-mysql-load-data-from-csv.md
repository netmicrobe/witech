---
layout: post
title: 从 csv 向 mysql 导入数据，LOAD DATA INFILE
categories: [ cm, mysql ]
tags: [ import, database ]
---

[Prepared SQL Statement Syntax]: https://dev.mysql.com/doc/refman/8.0/en/sql-syntax-prepared-statements.html
[User-Defined Variables]: https://dev.mysql.com/doc/refman/8.0/en/user-variables.html


* 参考
  * [MySQL 5.7 Reference Manual - ](https://dev.mysql.com/doc/refman/5.7/en/load-data.html)
  * <https://stackoverflow.com/a/2139097/3316529>
  * [MySQL Tutorial / Import CSV File Into MySQL Table](http://www.mysqltutorial.org/import-csv-file-mysql-table/)
  * [Prepared SQL Statement Syntax]
  * [User-Defined Variables]

---


## 语法


~~~ mysql
LOAD DATA [LOW_PRIORITY | CONCURRENT] [LOCAL] INFILE 'file_name'
    [REPLACE | IGNORE]
    INTO TABLE tbl_name
    [PARTITION (partition_name [, partition_name] ...)]
    [CHARACTER SET charset_name]
    [{FIELDS | COLUMNS}
        [TERMINATED BY 'string']
        [[OPTIONALLY] ENCLOSED BY 'char']
        [ESCAPED BY 'char']
    ]
    [LINES
        [STARTING BY 'string']
        [TERMINATED BY 'string']
    ]
    [IGNORE number {LINES | ROWS}]
    [(col_name_or_user_var
        [, col_name_or_user_var] ...)]
    [SET col_name={expr | DEFAULT},
        [, col_name={expr | DEFAULT}] ...]
~~~


## 示例


### 如何忽略csv的字段：使用一个不用的变量占位

PREPARE...EXECUTE...DEALLOCATE...的语法参见： [Prepared SQL Statement Syntax]
用来动态拼接SQL语句的。支持大部分SQL语法，但不支持`LOAD DATA INFILE`

~~~ sql
SET @tblname='log_20180625';

SET @s1=CONCAT('DROP TABLE IF EXISTS ', @tblname);
PREPARE stmt1 FROM @s1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;

SET @s2=CONCAT('CREATE TABLE ', @tblname, ' LIKE tb_xc_sdk');
PREPARE stmt2 FROM @s2;
EXECUTE stmt2;
DEALLOCATE PREPARE stmt2;


-- DROP TABLE IF EXISTS `log_20180625`;
-- CREATE TABLE `log_20180625` LIKE tb_xc_sdk;

LOAD DATA INFILE '_load_sdk_log_20180625.csv' 
  INTO TABLE log_20180625 
  CHARACTER SET utf8 
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"' 
  ESCAPED BY '"'
  LINES TERMINATED BY '\n' 
  IGNORE 1 LINES 
  (REQ_TIME, IP, REQ_INTERFACE, PARAMS, USERID, USER_TYPE, @ig_ACCESS_TOKEN, @ig_USERNAME, @ig_IMSI, @ig_MAC, @ig_IMSI, @ig_IS_IMSI_LOGIN, @ig_IS_MAC_REG, @ig_IS_MAC_LOGIN, ACTION_CODE, PAGE_CODE, FROMER, GAME_ID, CHANNEL_ID, @ig_U_ID, USERNAME, MSISDN, @ig_EMAIL, ACCOUNT_VALID, ACCOUNT_STATUS);


-- DELETE FROM `log_20180625` WHERE USERID = 0;

SET @s3=CONCAT('DELETE FROM ', @tblname, ' WHERE USERID = 0');
PREPARE stmt3 FROM @s3;
EXECUTE stmt3;
DEALLOCATE PREPARE stmt3;
~~~




### 如何使用SET

~~~ sql
LOAD DATA INFILE 'wiphone_test_data/tb_selfr_phone.csv' 
  INTO TABLE tb_selfr_phone 
  CHARACTER SET utf8 
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"' 
  ESCAPED BY '"'
  LINES TERMINATED BY '\r\n' 
  IGNORE 1 LINES 
  (sr_brand, sr_model, @pid, @ig_pname, @ig_bid, @ig_bname, @ig_babbr)
  SET phoneid = NULLIF(@pid, '');
~~~

































