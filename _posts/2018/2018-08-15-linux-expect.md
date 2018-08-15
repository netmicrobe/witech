---
layout: post
title: expect脚本编写
categories: [ cm, linux ]
tags: [tcl, expect, ssh]
---


---
* 参考：
  * [Expect Command Tutorial in Linux With Example Usage](https://www.slashroot.in/expect-command-tutorial-linux-example-usage)
  * [Expect](https://core.tcl.tk/expect/index)
  * [expect(1) - Linux man page](https://linux.die.net/man/1/expect)
  * [Expect examples and tips](https://www.pantz.org/software/expect/expect_examples_and_tips.html)
  * []()

---



## expect

### 安装 expect

For Red Hat based systems,

~~~
yum install expect
~~~

或者, For Debian based or Ubuntu

~~~
apt-get install expect
~~~


### Most used commands and descriptions

* `expect`

  The expect command will wait until one of the patterns given matches the output of a spawned process, a specified time period has passed, or an end-of-file is seen. Since you can give the expect command multiple things to match on you can have it do different things when it matches. The first sentence bares repeating, but I will try to expand on it. Expect will constantly loop through the multiple given patterns until a match is found. Expect will match the first pattern it finds in the order you specified them. When it finds a match it will execute any commands given and keep following any more nested commands until it hits the last command. It will never return to the calling block. It then moves onto the next part of the script.

  If at any time there are no matches it will timeout. If the pattern keyword (match word) "timeout" is used you can have it perform an action when the timeout happens.

  If an eof is returned it will exit the spawned process and move on. If you use "eof" as a pattern keyword then you can have it also perform an action if an eof happens.

  You can also use the pattern keyword called "default" that can perform an action if either eof or timeout are reached. We will see how to use this to make great error messages later.

* `send`
  Sends string to the current process. Usually this is a command followed by a return character (\r) like send "yourpassword\r". You use the expect command to match the output and decide what to send the current process.
* `spawn` - Creates a new process by running a given program. This is usually given at the start of the script to begin the process. Examples given earlier were "spawn ssh user@host or spawn ftp host". You are starting up (connecting to) the process you want to interact with.
* `send_user` - Output that gets sent to stdout. This is used for sending message to the screen as the script runs. It is great for user feedback, banners, and for generating error messages.
* `interact` - This will give control of the current process over to the user for interaction. Great if the script can get a person to a certain point and then they have to take over. When you get to the point you want to interact with just put in the word "interact".
* `log_user` - By default all process output shows up on stdout (your screen). To stop this you can set log_user to 0 "log_user 0" at the top of your script. To turn things back on just set it back to "log_user 1" or remove the line.
* `exp_internal` - This is essentially the Expect debug log mode. Turn this on by setting this to 1 like "exp_internal 1". It will show you everything expect sees and how it is trying to match it. This is invaluable for when you think your script should be working, but it is not.
* `set` - Set is just how to set variables in Tcl and thus Expect. Things like setting the global timeout value from 10 seconds to 20 with "set timeout 20". Another would be grabbing a username from the command line of the expect script and setting it to a variable "set username [lindex $argv 0]".
* `close` - Closes the connection to the current process.



### 简单的例子

* interactive_program.sh

~~~ shell
#!/bin/bash
echo "What is your name?"
read ANSWER
echo "How many dogs you have?"
read ANSWER
echo "How many cats you have?"
read ANSWER
~~~

* expect_script.sh

~~~ tcl
#!/usr/bin/expect
spawn ./interactive_program.sh
expect -exact "What is your name?\r"
send -- "Sam\r"
expect -exact "How many dogs you have?\r"
send -- "2\r"
expect -exact "How many cats you have?\r"
send -- "2\r"
expect eof
~~~

`expect eof` indicates that the script ends here.



### 带参数的例子

~~~ tcl
#!/usr/bin/expect
set user_name [lindex $argv 0]
set pass_word [lindex $argv 1]
spawn passwd $user_name
expect -exact "Enter new UNIX password: "
send -- "$pass_word\r"
expect -exact "\rRetype new UNIX password: "
send -- "$pass_word\r"
expect eof
~~~

`set user_name [lindex $argv 0]` & `set pass_word [lindex $argv 1]` creates two variables named `user_name` and `pass_word` from the command line parameters provided



### 脚本中使用循环

#### foreach loop

~~~ tcl
#!/usr/bin/expect
set l [list testuser testuser1 testuser2 testuser3]
set pass_word sf345234
foreach user_name $l {
    spawn passwd $user_name
    expect -exact "Enter new UNIX password: "
    send -- "$pass_word\r"
    expect -exact "\rRetype new UNIX password: "
    send -- "$pass_word\r"
    expect eof
}
~~~

* note: the fact that the above script assumes that the users testuser, testuser1, testuser2 and testuser3 exists in the system. 


#### for loop

~~~ tcl
#!/usr/bin/expect -f

for {set NUM 0} {$NUM <= 5} {incr NUM} {
  puts "\nNUM = $NUM"
}
puts ""
~~~

#### while loop

~~~ tcl
#!/usr/bin/expect
set pass_word sf345234
set m 0
while {$m<10} {
    spawn passwd "testuser$m"
    expect -exact "Enter new UNIX password: "
    send -- "$pass_word\r"
    expect -exact "\rRetype new UNIX password: "
    send -- "$pass_word\r"
    expect eof
        incr m
}
~~~

### 条件控制 if

~~~ tcl
#!/usr/bin/expect
set m 0
while {$m<10} {
    set pass_word sf345234
    if { $m == 2 } {
      set pass_word asfjhfajhakasfa234
    }
    spawn passwd "testuser$m"
    expect -exact "Enter new UNIX password: "
    send -- "$pass_word\r"
    expect -exact "\rRetype new UNIX password: "
    send -- "$pass_word\r"
    expect eof
    incr m
}
~~~

~~~ tcl
#!/usr/bin/expect -f
 
set NUM 1

if { $NUM < 5 } {
  puts "\Smaller than 5\n"
} elseif { $NUM > 5 } {
  puts "\Bigger than 5\n"
} else {
  puts "\Equals 5\n"
}
~~~


#### User-defined Functions

~~~ tcl
proc myfunc { TOTAL } {
  set TOTAL [expr $TOTAL + 1]
  return "$TOTAL"
}

set NUM 0
while {$NUM <= 5} {
  puts "\nNumber $NUM"
  set NUM [myfunc $NUM]
}

puts ""
~~~


### ssh 自动登录的例子

~~~ tcl
#!/usr/bin/expect
#Usage ssh-pass <host> <ssh user> <ssh password>

set timeout 60
set username [lindex $argv 1]
set password [lindex $argv 2]
set hostname [lindex $argv 0]
#log_user 0

if {[llength $argv] == 0} {
  send_user "Usage: ssh-pass hostname username \'password\'\n"
  exit 1
}

send_user "\n#####\n# $hostname\n#####\n"

spawn ssh -q -oStrictHostKeyChecking=no -oCheckHostIP=no $username@$hostname

expect {
  timeout { send_user "\nFailed to get password prompt\n"; exit 1 }
  eof { send_user "\nSSH failure for $hostname\n"; exit 1 }
  "*?assword"
}

send "$password\r"

interact
~~~



































