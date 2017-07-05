---
layout: post
title: Go 使用入门
categories: [dev, go]
tags: [go, go-lang]
---



### package

每个源码文件第一行必须是 package your-package-name

### import

```
import (
  "log" // Go Built-in package
  "fmt"
  _ "package-not-used-but-wanna-load" // 没用到，但是想初始化（调用包中各文件的init）进来的package，在前头写个下划线
)
```

### nil

### 变量

In Go, all variables are initialized to their zero value. 

* For numeric types, that value is 0; 
* for strings it’s an empty string; 
* for Booleans it’s false;
* for pointers, the zero value is nil. 

When it comes to reference types, there are underlying data structures that are initialized to their zero values. 

### 函数

#### 函数定义

注意，参数名在前，类型在后

func FUNCTION-NAME(PARAMETER1 type-name, ...)

### 集合

#### slice

相当于动态数组


#### map


#### range

The keyword **range** can be used with arrays, strings, slices, maps, and channels. 

```
for _, item := range items {
...
}
或者，
for index, item := range items {
...
}
```



### godoc

#### 本地运行文档服务器：

```
godoc -http=:6060
```

If you open your webbrowser and navigate to http://localhost:6060, you’ll see a web page with documentation for both the Go standard libraries and any Go source that lives in your GOPATH.





### 使用习惯

#### 函数返回结果和错误

例如，

```go
// Open the file.
file, err := os.Open(dataFile)
```

#### 集合 [] 获取返回 item 和 exists

例如，

```
matcher, exists := matchers[feed.Type]
```

#### BLANK IDENTIFIER (_)

The _ (underscore character) is known as the blank identifier and has many uses within Go. It’s used when you want to throw away the assignment of a value, including the assignment of an import to its package name, or ignore return values from a function when you’re only interested in the others.
