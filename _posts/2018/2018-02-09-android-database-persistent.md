---
layout: post
title: android 上使用sqlite数据库存储
categories: [ dev, android ]
tags: [ android, room, persistence, sqlite ]
---

* 参考：
  * [API Guides - Data Storage](https://developer.android.com/guide/topics/data/data-storage.html#db)
  * [TRAINING - SQLITE](https://developer.android.com/training/data-storage/sqlite.html)
  * [Saving Data Using the Room Persistence Library](https://developer.android.com/training/data-storage/room/index.html)
  * [Develop - Libraries - Architecture Components - Adding Components to your Project](https://developer.android.com/topic/libraries/architecture/adding-components.html)
  * [Develop - Libraries - Architecture Components - Room Persistence Library](https://developer.android.com/topic/libraries/architecture/room.html)


## Room Persistence Library

[ref-Database]: https://developer.android.com/reference/android/arch/persistence/room/Database.html
[ref-Insert]: https://developer.android.com/reference/android/arch/persistence/room/Insert.html
[ref-Query]: https://developer.android.com/reference/android/arch/persistence/room/Query.html
[ref-LiveData]: https://developer.android.com/reference/android/arch/lifecycle/LiveData.html
[ref-Migration]: https://developer.android.com/reference/android/arch/persistence/room/migration/Migration.html
[ref-TypeConverters]: https://developer.android.com/reference/android/arch/persistence/room/TypeConverters.html




The Room persistence library provides an abstraction layer over SQLite to allow fluent database access while harnessing the full power of SQLite.



There are 3 major components in Room:
* [Database][ref-Database]
  * annotated with `@Database`
  * Be an abstract class that extends `RoomDatabase`
  * Include **the list of entities** associated with the database within the annotation.
  * Contain an abstract method that has 0 arguments and returns the class that is annotated with `@Dao`.
* Entity
  * Represents a table within the database.
* DAO
  * Contains the methods used for accessing the database.

![](room_architecture.png)
{: style="width:70%"}

* **Note**: You should follow the singleton design pattern when instantiating an AppDatabase object, as each RoomDatabase instance is fairly expensive, and you rarely need access to multiple instances.

### 完整的简单例子

#### Gradle 配置

* project-root\build.gradle

~~~ gradle
// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    repositories {
        google()
        jcenter()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:3.0.1'

        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
}

allprojects {
    repositories {
        google()
        jcenter()
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}

~~~

* project-root\app\build.gradle 

~~~ gradle
apply plugin: 'com.android.application'

android {
    compileSdkVersion 26
    buildToolsVersion "27.0.3"
    defaultConfig {
        applicationId "com.wispeedio.setdingding"
        minSdkVersion 18
        targetSdkVersion 23
        versionCode 1
        versionName "1.0"
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
        vectorDrawables.useSupportLibrary = true
        javaCompileOptions {
            annotationProcessorOptions {
                arguments = ["room.schemaLocation": "$projectDir/schemas".toString()]
            }
        }
    }
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}

dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar'])
    androidTestCompile('com.android.support.test.espresso:espresso-core:2.0', {
        exclude group: 'com.android.support', module: 'support-annotations'
    })
    compile 'com.android.support:appcompat-v7:26.1.0'
    compile 'com.android.support:design:26.1.0'
    compile 'com.android.support:support-vector-drawable:26.1.0'
    testCompile 'junit:junit:4.10'
    compile 'com.android.support.test:testing-support-lib:0.1'
    compile 'com.android.support.test.uiautomator:uiautomator-v18:2.1.2'

    annotationProcessor "android.arch.lifecycle:compiler:1.1.0"

    // Room (use 1.1.0-alpha1 for latest alpha)
    implementation "android.arch.persistence.room:runtime:1.0.0"
    annotationProcessor "android.arch.persistence.room:compiler:1.0.0"

}
~~~

#### Entity 定义

~~~ java
package com.wispeedio.dbtesting;

import android.arch.persistence.room.Entity;
import android.arch.persistence.room.PrimaryKey;

import java.util.Date;

/**
 * Command Entity
 */
@Entity(tableName = Command.TABLE_NAME)
public class Command {
  /** The name of the Cheese table. */
  public static final String TABLE_NAME = "commands";

  @PrimaryKey(autoGenerate = true)
  public int id;

  // =========== initial fields ===========
  /** 何时执行 */
  public Date when_start;

  /** 执行的最长时间，单位：毫秒。*/
  public long timeout = 60000; // 默认 一分钟 超时。

  /** 状态：未执行；执行中；执行成功；执行失败；执行超时；已取消； */
  public int status;
  public static final int ST_NOT_RUN = 1;
  public static final int ST_RUNNING = 2;
  public static final int ST_SUCCESS = 3;
  public static final int ST_FAILED  = 4;
  public static final int ST_TIMEOUT = 5;
  public static final int ST_CANCELLED = 6; // “取消”操作只针对定时且未执行的命令

  /** 命令 */
  public String cmd;

  /** 命令类型：目前只有一种，shell命令 */
  public String cmd_type = "shell";

  /** 来源：目前只有短信下发的命令 */
  public String source;

  // =========== initial fields ===========

  /** 完成时间 */
  public Date when_done;

  /** 执行结果描述 */
  public String result;

  /** 备注 */
  public String memo;

  public String toString() {
    StringBuffer ret = new StringBuffer();
    ret.append("CMD [ ");
    ret.append(id);
    ret.append(" ] ");
    ret.append(when_start.toString());
    ret.append("");

    return ret.toString();
  }
}
~~~

#### DAO 定义

~~~ java
package com.wispeedio.dbtesting;

import android.arch.persistence.room.Dao;
import android.arch.persistence.room.Insert;
import android.arch.persistence.room.Query;

import java.util.List;

/**
 *
 */
@Dao
public interface CommandDao {
  @Insert
  long[] insertAll(Command... commands);

  @Query("SELECT * FROM " + Command.TABLE_NAME)
  Command[] loadAll();

  @Query("SELECT COUNT(*) FROM " + Command.TABLE_NAME)
  int count();

}
~~~

#### Converters 定义

~~~ java
package com.wispeedio.dbtesting;

import android.arch.persistence.room.TypeConverter;

import java.util.Date;

/**
 *
 */
public class Converters {
  @TypeConverter
  public static Date fromTimestamp(Long value) {
    return value == null ? null : new Date(value);
  }

  @TypeConverter
  public static Long dateToTimestamp(Date date) {
    return date == null ? null : date.getTime();
  }
}
~~~


#### Database 定义

~~~ java
package com.wispeedio.dbtesting;

import android.arch.persistence.db.SupportSQLiteOpenHelper;
import android.arch.persistence.room.Database;
import android.arch.persistence.room.DatabaseConfiguration;
import android.arch.persistence.room.InvalidationTracker;
import android.arch.persistence.room.Room;
import android.arch.persistence.room.RoomDatabase;
import android.arch.persistence.room.TypeConverters;
import android.content.Context;

/**
 *
 */
@Database(entities={Command.class}, version = 1)
@TypeConverters({Converters.class})
public abstract class AppDatabase extends RoomDatabase {

  /** The only instance */
  private static AppDatabase sInstance;

  /**
   * Gets the singleton instance of Database
   * @param context
   * @return The singleton instance of AppDatabase.
   */
  public static synchronized AppDatabase getInstance(Context context) {
    if( sInstance == null ) {
      sInstance = Room.databaseBuilder(context.getApplicationContext(),
          AppDatabase.class, "appdb").build();
    }
    return sInstance;
  }

  /**
   * @return The DAO for the Command table.
   */
  public abstract CommandDao command();
}
~~~

#### 使用数据库，MainActivity 按钮响应处理

~~~ java
      case R.id.insert:
        new Thread(new Runnable(){
          public void run() {
            Command cmd = new Command();
            cmd.when_start = new Date();
            CommandDao cmdDao = AppDatabase.getInstance(MainActivity.this).command();
            long[] ids = cmdDao.insertAll(cmd);
            AppConfig.log("ids : " + ids);
            if( ids != null ) {
              AppConfig.log("ids length : " + ids.length);
              for(long i:ids) {
                AppConfig.log("id : " + i);
              }
            }

            Command[] commands = cmdDao.loadAll();
            if(commands != null && commands.length > 0) {
              for (Command c : commands) {
                AppConfig.log(c.toString());
              }
            }
          }
        }).start();
        break;
~~~



### 配置 build.gradle

* [Android Plugin for Gradle Release Notes](https://developer.android.com/studio/releases/gradle-plugin.html)
* [Adding Components to your Project](https://developer.android.com/topic/libraries/architecture/adding-components.html)

Main Dependencies
Includes Lifecycles, LiveData, ViewModel, Room, and Paging.

It also includes test helpers for testing LiveData as well as testing Room migrations.

~~~ gradle
dependencies {
    // ViewModel and LiveData
    implementation "android.arch.lifecycle:extensions:1.1.0"
    // alternatively, just ViewModel
    implementation "android.arch.lifecycle:viewmodel:1.1.0"
    // alternatively, just LiveData
    implementation "android.arch.lifecycle:livedata:1.1.0"

    annotationProcessor "android.arch.lifecycle:compiler:1.1.0"

    // Room (use 1.1.0-alpha1 for latest alpha)
    implementation "android.arch.persistence.room:runtime:1.0.0"
    annotationProcessor "android.arch.persistence.room:compiler:1.0.0"

    // Paging
    implementation "android.arch.paging:runtime:1.0.0-alpha5"

    // Test helpers for LiveData
    testImplementation "android.arch.core:core-testing:1.1.0"

    // Test helpers for Room
    testImplementation "android.arch.persistence.room:testing:1.0.0"
}
~~~


### 简单例子，1个 entity ，1个 DAO

* User.java

~~~ java
@Entity
public class User {
    @PrimaryKey
    private int uid;

    @ColumnInfo(name = "first_name")
    private String firstName;

    @ColumnInfo(name = "last_name")
    private String lastName;

    // Getters and setters are ignored for brevity,
    // but they're required for Room to work.
}
~~~


* UserDao.java

~~~ java
@Dao
public interface UserDao {
    @Query("SELECT * FROM user")
    List<User> getAll();

    @Query("SELECT * FROM user WHERE uid IN (:userIds)")
    List<User> loadAllByIds(int[] userIds);

    @Query("SELECT * FROM user WHERE first_name LIKE :first AND "
           + "last_name LIKE :last LIMIT 1")
    User findByName(String first, String last);

    @Insert
    void insertAll(User... users);

    @Delete
    void delete(User user);
}
~~~

* AppDatabase.java

~~~ java
@Database(entities = {User.class}, version = 1)
public abstract class AppDatabase extends RoomDatabase {
    public abstract UserDao userDao();
}
~~~

After creating the files above, you get an instance of the created database using the following code:

~~~ java
AppDatabase db = Room.databaseBuilder(getApplicationContext(),
        AppDatabase.class, "database-name").build();
~~~


### Entity

* 每个 Entity类 对应数据库中的一个 table
* By default, Room creates a column for each field that's defined in the entity.
  * If an entity has fields that you don't want to persist, you can annotate them using `@Ignore`
* must reference the entity class through the entities array in the Database class.
* To persist a field, Room must have access to it. You can make a field **public**, or you can provide a **getter and setter** for it.


#### primary key 主键

* 每个 entity 必须至少指定一个属性为主键。即使只有一个field，依然需要冠以 `@PrimaryKey`
* 多个列组合成主键
  ~~~ java
  @Entity(primaryKeys = {"firstName", "lastName"})
  class User {
      public String firstName;
      public String lastName;
  ]
  ~~~
* if you want Room to assign automatic IDs to entities, you can set the @PrimaryKey's `autoGenerate` property. 


#### 表名、列名

* 默认使用类名作为表名。使用`tableName`属性可以更改
  ~~~ java
  @Entity(tableName = "users")
  class User {
      ...
  }
  ~~~
* 默认field即列名。使用`@ColumnInfo.name`修改列名。
  ~~~ java
  @Entity(tableName = "users")
  class User {
      @PrimaryKey
      public int id;

      @ColumnInfo(name = "first_name")
      public String firstName;

      @ColumnInfo(name = "last_name")
      public String lastName;
  }
  ~~~


#### 标注索引 indices、唯一约束 uniqueness

~~~ java
// "last_name", "address"组合起来的索引，命名为 name
@Entity(indices = {@Index("name"),
        @Index(value = {"last_name", "address"})})
class User {
    @PrimaryKey
    public int id;

    public String firstName;
    public String address;

    @ColumnInfo(name = "last_name")
    public String lastName;
}
~~~

~~~ java
// 唯一约束
@Entity(indices = {@Index(value = {"first_name", "last_name"},
        unique = true)})
~~~



#### Define relationships between objects

~~~ java
@Entity(foreignKeys = @ForeignKey(entity = User.class,
                                  parentColumns = "id",
                                  childColumns = "user_id"))
class Book {
    @PrimaryKey
    public int bookId;

    public String title;

    @ColumnInfo(name = "user_id")
    public int userId;
}
~~~

* you can tell SQLite to delete all books for a user if the corresponding instance of User is deleted by including `onDelete = CASCADE` in the `@ForeignKey` annotation.
*  SQLite handles `@Insert(onConflict = REPLACE)` as a set of REMOVE and REPLACE operations instead of a single UPDATE operation.


#### Create nested objects

~~~ java
class Address {
    public String street;
    public String state;
    public String city;

    @ColumnInfo(name = "post_code")
    public int postCode;
}

// The table representing a User object then contains columns with the following names: id, firstName, street, state, city, and post_code.
@Entity
class User {
    @PrimaryKey
    public int id;

    public String firstName;

    @Embedded
    public Address address;
}
~~~



### Accessing data using Room DAOs

#### Insert

* When you create a DAO method and annotate it with [@Insert][ref-Insert], Room generates an implementation that inserts all parameters into the database in a single transaction.
* If the @Insert method receives only 1 parameter, it can return a long, which is the new rowId for the inserted item
*  If the parameter is an array or a collection, it should return long[] or List<Long> instead.

~~~ java
@Dao
public interface MyDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    public void insertUsers(User... users);

    @Insert
    public void insertBothUsers(User user1, User user2);

    @Insert
    public void insertUsersAndFriends(User user, List<User> friends);
}
~~~

#### Update

* 传参1个或多个 entity，Room根据主键找到对应记录更新。
* you can have this method return an int value instead, indicating the number of rows updated in the database.

~~~ java
@Dao
public interface MyDao {
    @Update
    public void updateUsers(User... users);
}
~~~

#### Delete

* The Delete convenience method removes a set of entities, given as parameters, from the database. 
* uses the primary keys to find the entities to delete.

~~~ java
@Dao
public interface MyDao {
    @Delete
    public void deleteUsers(User... users);
}
~~~





### Query for information

* Each [@Query][ref-Query] method is verified at compile time, so if there is a problem with the query, a compilation error occurs instead of a runtime failure.
* It gives a warning if only some field names match.
* It gives an error if no field names match

~~~ java
@Dao
public interface MyDao {
    @Query("SELECT * FROM user")
    public User[] loadAllUsers();
}
~~~

#### Passing parameters into the query

~~~ java
@Dao
public interface MyDao {
    @Query("SELECT * FROM user WHERE age > :minAge")
    public User[] loadAllUsersOlderThan(int minAge);
}
~~~

~~~ java
@Dao
public interface MyDao {
    @Query("SELECT * FROM user WHERE age BETWEEN :minAge AND :maxAge")
    public User[] loadAllUsersBetweenAges(int minAge, int maxAge);

    @Query("SELECT * FROM user WHERE first_name LIKE :search "
           + "OR last_name LIKE :search")
    public List<User> findUserWithName(String search);
}
~~~

#### Returning subsets of columns

~~~ java
// create the following plain old Java-based object (POJO) to fetch the user's first name and last name:

public class NameTuple {
    @ColumnInfo(name="first_name")
    public String firstName;

    @ColumnInfo(name="last_name")
    public String lastName;
}

// use this POJO in your query method:

@Dao
public interface MyDao {
    @Query("SELECT first_name, last_name FROM user")
    public List<NameTuple> loadFullName();
}

~~~

#### Passing a collection of arguments

~~~ java
@Dao
public interface MyDao {
    @Query("SELECT first_name, last_name FROM user WHERE region IN (:regions)")
    public List<NameTuple> loadUsersFromRegions(List<String> regions);
}
~~~


#### Observable queries

Room generates all necessary code to update the [LiveData][ref-LiveData] when the database is updated.


#### Reactive queries with RxJava

[reactivex-Flowable]: http://reactivex.io/RxJava/2.x/javadoc/io/reactivex/Flowable.html
[reactivex-Publisher]: http://www.reactive-streams.org/reactive-streams-1.0.1-javadoc/org/reactivestreams/Publisher.html
[room-rxjava]: https://medium.com/google-developers/room-rxjava-acb0cd4f3757

Room can also return RxJava2 [Publisher][reactivex-Publisher] and [Flowable][reactivex-Flowable] objects from the queries you define. To use this functionality, add the android.arch.persistence.room:rxjava2 artifact from the Room group into your build Gradle dependencies. You can then return objects of types defined in RxJava2, as shown in the following code snippet:

~~~ java
@Dao
public interface MyDao {
    @Query("SELECT * from user where id = :id LIMIT 1")
    public Flowable<User> loadUserById(int id);
}
~~~

For more details, see the Google Developers [Room and RxJava][room-rxjava] article.



#### Direct cursor access

~~~ java
@Dao
public interface MyDao {
    @Query("SELECT * FROM user WHERE age > :minAge LIMIT 5")
    public Cursor loadRawUsersOlderThan(int minAge);
}
~~~


#### Querying multiple tables

~~~ java
@Dao
public interface MyDao {
    @Query("SELECT * FROM book "
           + "INNER JOIN loan ON loan.book_id = book.id "
           + "INNER JOIN user ON user.id = loan.user_id "
           + "WHERE user.name LIKE :userName")
   public List<Book> findBooksBorrowedByNameSync(String userName);
}
~~~

~~~ java
// You can also return POJOs from these queries. For example, you can write a query that loads a user and their pet's name as follows:

@Dao
public interface MyDao {
   @Query("SELECT user.name AS userName, pet.name AS petName "
          + "FROM user, pet "
          + "WHERE user.id = pet.user_id")
   public LiveData<List<UserPet>> loadUserAndPetNames();

   // You can also define this class in a separate file, as long as you add the
   // "public" access modifier.
   static class UserPet {
       public String userName;
       public String petName;
   }
}
~~~


### Migrating Room databases

* Each [Migration][ref-Migration] class specifies a startVersion and endVersion. 
* At runtime, Room runs each Migration class's migrate() method, using the correct order to migrate the database to a later version.
* Caution: If you don't provide the necessary migrations, Room rebuilds the database instead, which means you'll lose all of your data in the database.


~~~ java
Room.databaseBuilder(getApplicationContext(), MyDb.class, "database-name")
        .addMigrations(MIGRATION_1_2, MIGRATION_2_3).build();

static final Migration MIGRATION_1_2 = new Migration(1, 2) {
    @Override
    public void migrate(SupportSQLiteDatabase database) {
        database.execSQL("CREATE TABLE `Fruit` (`id` INTEGER, "
                + "`name` TEXT, PRIMARY KEY(`id`))");
    }
};

static final Migration MIGRATION_2_3 = new Migration(2, 3) {
    @Override
    public void migrate(SupportSQLiteDatabase database) {
        database.execSQL("ALTER TABLE Book "
                + " ADD COLUMN pub_year INTEGER");
    }
};
~~~

#### Export schemas

Upon compilation, Room exports your database's schema information into a JSON file. 
To export the schema, set the room.schemaLocation annotation processor property in your build.gradle file, as shown in the following code snippet:

~~~ gradle
// build.gradle

android {
    ...
    defaultConfig {
        ...
        javaCompileOptions {
            annotationProcessorOptions {
                arguments = ["room.schemaLocation":
                             "$projectDir/schemas".toString()]
            }
        }
    }
}
~~~

To test these migrations, add the android.arch.persistence.room:testing Maven artifact from Room into your test dependencies, and add the schema location as an asset folder, as shown in the following code snippet:

~~~ gradle
// build.gradle

android {
    ...
    sourceSets {
        androidTest.assets.srcDirs += files("$projectDir/schemas".toString())
    }
}
~~~

A sample migration test appears in the following code snippet:

~~~ java
@RunWith(AndroidJUnit4.class)
public class MigrationTest {
    private static final String TEST_DB = "migration-test";

    @Rule
    public MigrationTestHelper helper;

    public MigrationTest() {
        helper = new MigrationTestHelper(InstrumentationRegistry.getInstrumentation(),
                MigrationDb.class.getCanonicalName(),
                new FrameworkSQLiteOpenHelperFactory());
    }

    @Test
    public void migrate1To2() throws IOException {
        SupportSQLiteDatabase db = helper.createDatabase(TEST_DB, 1);

        // db has schema version 1. insert some data using SQL queries.
        // You cannot use DAO classes because they expect the latest schema.
        db.execSQL(...);

        // Prepare for the next version.
        db.close();

        // Re-open the database with version 2 and provide
        // MIGRATION_1_2 as the migration process.
        db = helper.runMigrationsAndValidate(TEST_DB, 2, true, MIGRATION_1_2);

        // MigrationTestHelper automatically verifies the schema changes,
        // but you need to validate that the data was migrated properly.
    }
}
~~~



### Test on an Android device

The recommended approach for testing your database implementation is writing a JUnit test that runs on an Android device. Because these tests don't require creating an activity, they should be faster to execute than your UI tests.

When setting up your tests, you should create an in-memory version of your database to make your tests more hermetic, as shown in the following example:

~~~ java
@RunWith(AndroidJUnit4.class)
public class SimpleEntityReadWriteTest {
    private UserDao mUserDao;
    private TestDatabase mDb;

    @Before
    public void createDb() {
        Context context = InstrumentationRegistry.getTargetContext();
        mDb = Room.inMemoryDatabaseBuilder(context, TestDatabase.class).build();
        mUserDao = mDb.getUserDao();
    }

    @After
    public void closeDb() throws IOException {
        mDb.close();
    }

    @Test
    public void writeUserAndReadInList() throws Exception {
        User user = TestUtil.createUser(3);
        user.setName("george");
        mUserDao.insert(user);
        List<User> byName = mUserDao.findUsersByName("george");
        assertThat(byName.get(0), equalTo(user));
    }
}
~~~

### Use type converters

For example, if we want to persist instances of Date, we can write the following TypeConverter to store the equivalent Unix timestamp in the database:

~~~ java
public class Converters {
    @TypeConverter
    public static Date fromTimestamp(Long value) {
        return value == null ? null : new Date(value);
    }

    @TypeConverter
    public static Long dateToTimestamp(Date date) {
        return date == null ? null : date.getTime();
    }
}
~~~

Next, you add the [@TypeConverters][ref-TypeConverters] annotation to the AppDatabase class so that Room can use the converter that you've defined for each entity and DAO in that AppDatabase:

~~~ java
// AppDatabase.java

@Database(entities = {User.class}, version = 1)
@TypeConverters({Converters.class})
public abstract class AppDatabase extends RoomDatabase {
    public abstract UserDao userDao();
}
~~~

Using these converters, you can then use your custom types in other queries, just as you would use primitive types

~~~ java
// User.java

@Entity
public class User {
    ...
    private Date birthday;
}

// UserDao.java

@Dao
public interface UserDao {
    ...
    @Query("SELECT * FROM user WHERE birthday BETWEEN :from AND :to")
    List<User> findUsersBornBetweenDates(Date from, Date to);
}
~~~



























































































































































































































