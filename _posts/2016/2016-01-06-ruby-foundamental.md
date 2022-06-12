---
layout: post
title: Ruby 基本语法快速入门
categories: [dev, ruby]
tags: [ruby]
---



## 一般语法

每句代码一行，不用分号结尾
代码缩进 **不影响** 代码含义，一般缩进单位是 2个空格。

## 注释

~~~ruby
# 这是一个单行注释。

@counter      # 跟踪页面被点击的次数
@siteCounter  # 跟踪所有页面被点击的次数

=begin
这是一个多行注释。
可扩展至任意数量的行。
但 =begin 和 =end 只能出现在第一行和最后一行。 
=end
~~~

## 命名规则

全局变量，a dollar sign ($) 开头
类的实例变量，@ 开头
类的变量，@@ 开头
局部变量、函数参数、方法名，以小写字母或下划线（_）开头
类名、模块名、常量名，大写字母开头

多个单词的实例变量名称，单词之间 用下划线（_）分割。

多个单词的类名，使用驼峰表示法。

函数名后可以跟3种符号： ?  !  =

* 例子
```
Local Variable:    name fish_and_chips x_axis thx1138 _x _26
Instance Variable:    @name @point_1 @X @_ @plan9
Class Variable:    @@total @@symtab @@N @@x_pos @@SINGLE
Global Variable:    $debug $CUSTOMER $_ $plan9 $Global
Class Name:    String ActiveRecord MyClass
Constant Name:    FEET_PER_MILE DEBUG
```

## 变量

变量无需声明



## 函数

函数定义：

```ruby
def say_goodnight(name)
    result = "Good night, " + name
    return result
end
```

## 数字

相关的类型： Integer, Fixnum , Bignum, Float

字符串转换为整型： Integer(your-string)

使用数字进行循环：

```ruby
3.times { print "X" }
1.upto(5) {|i| print i, " " }
99.downto(95) {|i| print i, " " }
50.step(80, 5) {|i| print i, " " }
```

## 字符串 String

单引号和双引号都行： 'string-literals-in-single-quotation'  "string-literals-in-double-quotation"
还可以用 %q , %Q或%

双引号的字符串，可以包含特殊转义字符串，如 \n  #{expression} 。连函数调用都支持： #{name.capitalize}

```ruby
    def say_goodnight(name)
        result = "Good night, #{name.capitalize}"
        return result
    end
    puts say_goodnight('uncle')

    produces:
    Good night, Uncle
```

### 字符串连接用 + 

例如， "hello " + "world!"

### 可以通过 [] 访问和设置，字符串中的单个字符

例如：

```ruby
person = "Tim"
puts "person is #{person}"
person[0] = 'J'
puts "person is #{person}"

produces:
person is Tim
person is Jim
```

### 常用字符串方法

downcase 方法，转换string中字母为小写。
scan(正则表达式)，搜索出字符串中所有match正则表达式的部分，形成数组。

例子：

```ruby
def words_from_string(string)
string.downcase.scan(/[\w']+/)
end

p words_from_string("But I didn't inhale, he said (emphatically)")

produces:
["but", "i", "didn't", "inhale", "he", "said", "emphatically"]
```

#### start_with?  字符串以什么开头

~~~ruby
puts 'abcdefg'.start_with?('abc')  #=> true

# 可以接受多个参数
'abcdefg'.start_with?( 'xyz', 'opq', 'ab')
~~~

#### 检查字符串是否为空？  - string.blank?

~~~ruby
a = nil
b = []
c = ""
c1 = "   "

a.blank? #=> true
b.blank? #=> true
c.blank? #=> true
c1.blank? #=> true

d = "1"
e = ["1"]

d.blank? #=> false
e.blank? #=> false
~~~


### here document


例如：

```ruby
string = <<END_OF_STRING
The body of the string is the input lines up to
one starting with the same text that followed the '<<'
END_OF_STRING

Normally, this terminator must start in column one.
However, if you put a minus sign after the << characters, you can indent the terminator:

string = <<-END_OF_STRING
    The body of the string is the input lines up to
    one starting with the same text that followed the '<<'
    END_OF_STRING

```

### String#split 方法

依据分隔符（可以是，正则表达式），对字符串进行分解，提前可用字段。

例子，提取歌曲信息：
```
tut_stdtypes/songdata
/jazz/j00132.mp3 | 3:45 | Fats     Waller      | Ain't Misbehavin'
/jazz/j00319.mp3 | 2:58 | Louis    Armstrong   | Wonderful World
/bgrass/bg0732.mp3| 4:09 | Strength in Numbers | Texas Red
```

```ruby
Song = Struct.new(:title, :name, :length)
File.open("songdata") do |song_file|
    songs = []
    song_file.each do |line|
        file, length, name, title = line.chomp.split(/\s*\|\s*/)
        name.squeeze!(" ")
        mins, secs = length.scan(/\d+/)
        songs << Song.new(title, name, mins.to_i*60 + secs.to_i)
    end
    puts songs[1]
end

produces:
#<struct Song title="Wonderful World", name="Louis Armstrong", length=178>
```

### 字符串中搜索 include?

~~~ruby
my_string = "abcdefg"
if my_string.include? "cde"
   puts "String includes 'cde'"
end
~~~











## 数组

### 定义、初始化、引用

如下例：

```ruby
a = [ 1, 'cat', 3.14 ] # array with three elements
puts "The first element is #{a[0]}"
# set the third element
a[2] = nil
puts "The array is now #{a.inspect}" # inspect 将 Array 转换为字符串格式：[ 元素1，元素2, ... ]

produces:
The first element is 1
The array is now [1, "cat", nil]
```

### 空数组写法

```ruby
@books_in_stock = []
```

### 检查数组是否为空 any?

### 向数组中追加元素

```ruby
@books_in_stock << BookInStock.new("《Ruby入门》")
```

### 元素赋值

```ruby
a = [ 1, 3, 5, 7, 9 ] #=> [1, 3, 5, 7, 9]
a[1] = 'bat'          #=> [1, "bat", 5, 7, 9]
a[-3] = 'cat'         #=> [1, "bat", "cat", 7, 9]
a[3] = [ 9, 8 ]       #=> [1, "bat", "cat", [9, 8], 9]
a[6] = 99             #=> [1, "bat", "cat", [9, 8], 9, nil, 99]
```

### 数组长度 array.length

### 提取连续元素

a[index, count] 提取方法，例如：

```ruby
a = [ 1, 3, 5, 7, 9 ]
a[1, 3] # => [3, 5, 7]
a[3, 1] # => [7]
```

a[begin...end] 提取法，例如：  注意 2个点，3个点含义不同

```ruby
a = [ 1, 3, 5, 7, 9 ]
a[1..3]  # => [3, 5, 7]
a[1...3] # => [3, 5]
a[3..3]  # =>  [7]
```

### 连续元素替换，插入等 []= 操作符的nx功能

```ruby
a = [ 1, 3, 5, 7, 9 ]    #=>    [1, 3, 5, 7, 9]
a[2, 2] = 'cat'            #=>    [1, 3, "cat", 9]
a[2, 0] = 'dog'            #=>    [1, 3, "dog", "cat", 9]
a[1, 1] = [ 9, 8, 7 ]   #=>    [1, 9, 8, 7, "dog", "cat", 9]
a[0..3] = []            #=>    ["dog", "cat", 9]
a[5..6] = 99, 98        #=>    ["dog", "cat", 9, nil, nil, 99, 98]
```

### 数组当成 栈 使用

```ruby
stack = []
stack.push "red"
stack.push "green"
stack.push "blue"
stack                # => ["red", "green", "blue"]

stack.pop    #    =>    "blue"
stack.pop    #    =>    "green"
stack.pop    #    =>    "red"
stack        #    =>    []
```

### 数组当成 FIFO队列 使用

```ruby
queue = []
queue.push "red"
queue.push "green"
queue.shift # => "red"
queue.shift # => "green"
```

### 获取前后连续元素 first & last

```ruby
array = [ 1, 2, 3, 4, 5, 6, 7 ]
array.first(4) # => [1, 2, 3, 4]
array.last(4) # => [4, 5, 6, 7]
```

### for 循环遍历数组

```ruby
array = [ 1, 2, 3, 4, 5, 6, 7 ]
for num in array
    p num
end
```

## Hash 表

Key-Value键值对数组，Key 必须唯一。

例如：

```ruby
inst_section = {
    'cello' =>'string',
    'clarinet' => 'woodwind',
    'drum'=> 'percussion'
}
puts inst_section['cello']  # 引用
```

初始化值默认nil，例如，访问一个不存在的 key， 其 value 为 nil。
改变 value 的初始化值，例如，默认为0：  your-hash = Hash.new(0)

### Hash 长度获取，length 方法

使用 Symbol 作为 Key

例子，3种表示方法，都是等价的，第2、3种表示方法，都是使用 Symbol 作为 Key：

```ruby
h = { 'dog' => 'canine', 'cat' => 'feline', 'donkey' => 'asinine' }
h = { :dog => 'canine', :cat => 'feline', :donkey => 'asinine' }
h = { dog: 'canine', cat: 'feline', donkey: 'asinine' }
```

### 检查Key 是否存在：  hash.has_key?(target_key)





## Range

Ranges as Sequences
In Ruby, these sequences are created using the .. and ... range operators. The two-dot form creates an
inclusive range, and the three-dot form creates a range that excludes the specified high value.

low..high  包含low，high，以及之间的值
low...high 包含low，以及之间的值，不包含high值

### Range#to_a  转换为数组

例如：
```ruby
(1..10).to_a            # => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
('bar'..'bat').to_a   # => ["bar", "bas", "bat"]
```

### Range#to_enum 转换为 Enumerator

例如：

```ruby
enum = ('bar'..'bat').to_enum
enum.next    # => "bar"
enum.next    # => "bas"

Ranges as Conditions

while line = gets
    puts line if line =~ /start/ .. line =~ /end/
end
```

### Ranges as Intervals

whether some value falls within the interval represented by the range

例子：

```ruby
(1..10)       === 5             # => true
(1..10)       === 15            # => false
(1..10)       === 3.14159       # => true
('a'..'j')    === 'c'           # => true
('a'..'j')    === 'z'           # => false
```

例子：

```ruby
car_age = gets.to_f
# let's assume it's 9.5
case car_age
when 0...1
    puts "Mmm.. new car smell"
when 1...3
    puts "Nice and new"
when 3...10
    puts "Reliable but slightly dinged"
when 10...30
    puts "Clunker"
else
    puts "Vintage gem"
end
```


## Symbol 代号

全局的唯一标识符，以冒号开头，例如：   :state_ok    :state_error

常用来作为hash的key，例如：

```ruby
inst_section = {
    :cello =>'string',
    :drum => 'percussion'
}
puts inst_section[:cello]  # 引用

# 简化形式，等价上面的 inst_section
inst_section = {
    cello => 'string',
    drum => 'percussion'
}
```

## 程序的控制结构

### if

```ruby
today = Time.now
if today.saturday?
    puts "Do chores around the house"
elsif today.sunday?
    puts "Relax"
else
    puts "Go to work"
end
```

produces:
Go to work


#### if 的变体

```ruby
puts "Danger, Will Robinson" if radiation > 3000
```

### while

```ruby
while weight < 100 and num_pallets <= 5
    pallet = next_pallet()
    weight += pallet.weight
    num_pallets += 1
end
```

#### while 的变体

```ruby
square = square*square while square < 1000
```

### for 循环

例子：

```ruby
for i in 0...5
    # ...
end
```

## 正则表达式  Regular Expressions

/pattern/

### =~ 操作符

使用方式：字符串 =~ /pattern/
If the pattern is found in the string,
=~ returns its starting position; otherwise, it returns nil.

例如：

```ruby
line = gets
if line =~ /Perl|Python/
    puts "Scripting language mentioned: #{line}"
end
```

### 利用 regex 替换

```ruby
line = gets

# replace first 'Perl' with 'Ruby'
newline = line.sub( /Perl/, 'Ruby' )

# replace every 'Python' with 'Ruby'
newerline = newline.gsub( /Python/, 'Ruby' )

# You can replace every occurrence of Perl and Python with Ruby using this:
newline = line.gsub( /Perl|Python/ , 'Ruby')
```



## 时间

* 获取时间戳

~~~ruby
require 'date'

p DateTime.now.strftime('%s') # "1384526946" (seconds)
p DateTime.now.strftime('%Q') # "1384526946523" (milliseconds)
~~~













