---
layout: post
title: systemd的service文件，关联 linux，自启动，systemctl
categories: []
tags: []
---

* 参考
  * [systemd.service — Service unit configuration - man page](https://www.freedesktop.org/software/systemd/man/systemd.service.html)
  * [systemd.exec — Execution environment configuration - man page](https://www.freedesktop.org/software/systemd/man/systemd.exec.html#)
  * [systemd.unit — Unit configuration - man page](https://www.freedesktop.org/software/systemd/man/systemd.unit.html#)
  * [systemd-run - man page](https://www.freedesktop.org/software/systemd/man/systemd-run.html#)
  * []()
  * [digitalocean.com - Understanding Systemd Units and Unit Files](https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files)
  * []()
  * []()
  * []()
  * []()


### systemcd unit file 概述


systemd 读取这个 unit configuration file 来控制进程启动/关闭。

一般的section: `[Unit]` 和 `[Install]` sections 包含 common configuration items

Unit-Specific Section 和类型有关系，例如：

service unit ，会包含`[Service]` section ，设置些 service specific configuration options。


### systemcd unit file 存放位置

`/lib/systemd/system`   软件安装的service文件，不要手动修改

`/etc/systemd/system`    供admin修改的地方，同样unit文件可以覆盖 `/lib/systemd/system` 里面的设置。

`/run/systemd/system`    存放运行时 unit 文件，优先级介于 `/etc/systemd/system`  和 `/lib/systemd/system` 之间。


### unit file 内容详解

文件有一个个section组成。 section name 大小写敏感。

~~~sh
[Section]
Directive1=value
Directive2=value

. . .
~~~

* 覆盖设置的方法，示例：

  1. `/lib/systemd/system/foo.service` 中默认设置： `Directive1=default_value`
  1. 执行 `sudo systemctl edit foo` 会生成 `/etc/systemd/system/foo.service.d/override.conf`
  1. 添加或修改 override.conf 或这 其他 .conf 文件中设置，就能覆盖系统默认设置了。
  1. 要清除某个设置，就不要赋值，例如： `Directive1=`

  * 注意
    如果Dependencies（例如，After= 等），不能使用赋空的方法清除，必须创建一个完全备份（`systemctl edit --full foo`），然后修改。
  * 参考：
    * <https://askubuntu.com/a/659268>
    * <https://unix.stackexchange.com/a/468067>



#### `[Unit]` Section 

一般就是第一个section，描述些unit的基本信息。

* `Description=` This directive can be used to describe the name and basic functionality of the unit. It is returned by various systemd tools, so it is good to set this to something short, specific, and informative.

* `Documentation=` This directive provides a location for a list of URIs for documentation. These can be either internally available man pages or web accessible URLs. The systemctl status command will expose this information, allowing for easy discoverability.

* `Requires=` This directive lists any units upon which this unit essentially depends. If the current unit is activated, the units listed here must successfully activate as well, else this unit will fail. These units are started in parallel with the current unit by default.

* `Wants=` This directive is similar to `Requires=`, but less strict. Systemd will attempt to start any units listed here when this unit is activated. If these units are not found or fail to start, the current unit will continue to function. This is the recommended way to configure most dependency relationships. Again, this implies a parallel activation unless modified by other directives.

* `BindsTo=` This directive is similar to `Requires=`, but also causes the current unit to stop when the associated unit terminates.

* `Before=` The units listed in this directive will not be started until the current unit is marked as started if they are activated at the same time. This does not imply a dependency relationship and must be used in conjunction with one of the above directives if this is desired.

* `After=` The units listed in this directive will be started before starting the current unit. This does not imply a dependency relationship and one must be established through the above directives if this is required.

* `Conflicts=` This can be used to list units that cannot be run at the same time as the current unit. Starting a unit with this relationship will cause the other units to be stopped.

* `Condition...=` There are a number of directives that start with Condition which allow the administrator to test certain conditions prior to starting the unit. This can be used to provide a generic unit file that will only be run when on appropriate systems. If the condition is not met, the unit is gracefully skipped.

* `Assert...=` Similar to the directives that start with Condition, these directives check for different aspects of the running environment to decide whether the unit should activate. However, unlike the Condition directives, a negative result causes a failure with this directive.


#### `[Install]` Section

用来定义 unit enable/disable 的行为。

* `WantedBy=` The `WantedBy=` directive is the most common way to specify how a unit should be enabled. This directive allows you to specify a dependency relationship in a similar way to the Wants= directive does in the `[Unit]` section. The difference is that this directive is included in the ancillary unit allowing the primary unit listed to remain relatively clean. When a unit with this directive is enabled, a directory will be created within `/etc/systemd/system` named after the specified unit with `.wants` appended to the end. Within this, a symbolic link to the current unit will be created, creating the dependency. 

    实例：

    `/usr/lib/systemd/system/NetworkManager.service` 设置了： 

    ~~~sh
    [Install]
    WantedBy=multi-user.target
    ~~~

    那么enable这个unit，就会在文件夹 `/etc/systemd/system/multi-user.target.wants` 下，会产生一个指向 `NetworkManager.service` 的link 文件。

    disable 这个unit，则会删除这个 link 文件。

    ~~~sh
    $ ls -l /etc/systemd/system/multi-user.target.wants/NetworkManager.service 

    lrwxrwxrwx 1 root root 46  5月 26  2021 /etc/systemd/system/multi-user.target.wants/NetworkManager.service -> /usr/lib/systemd/system/NetworkManager.service
    ~~~

* `RequiredBy=` 和`WantedBy=`类似，除了更严格，这个unit启动不了，required-by 的 unit 就会直接失败。和`WantedBy=`类似，会在`/etc/systemd/system/` 下生成目录 `the-required-by-unit.requires`，在里面创建依赖unit 的 link 文件。

* `Alias=` 可以使用这个alias来 enable/disable 这个unit。

* `Also=` This directive allows units to be enabled or disabled as a set. Supporting units that should always be available when this unit is active can be listed here. They will be managed as a group for installation tasks.

* `DefaultInstance=` For template units (covered later) which can produce unit instances with unpredictable names, this can be used as a fallback value for the name if an appropriate name is not provided.


####  `[Service]` Section

service 类型的 unit 专有 section。

* `Type=` directive
  * `simple` The main process of the service is specified in the start line. This is the default if the `Type=` and `Busname=` directives are not set, but the `ExecStart=` is set. Any communication should be handled outside of the unit through a second unit of the appropriate type (like through a .socket unit if this unit must communicate using sockets).

  * `forking` This service type is used when the service forks a child process, exiting the parent process almost immediately. This tells systemd that the process is still running even though the parent exited.

  * `oneshot` This type indicates that the process will be short-lived and that systemd should wait for the process to exit before continuing on with other units. This is the default `Type=` and `ExecStart=` are not set. It is used for one-off tasks.

  * `dbus` This indicates that unit will take a name on the D-Bus bus. When this happens, systemd will continue to process the next unit.

  * `notify` This indicates that the service will issue a notification when it has finished starting up. The systemd process will wait for this to happen before proceeding to other units.

  * `idle` This indicates that the service will not be run until all jobs are dispatched.


* `RemainAfterExit=` This directive is commonly used with the `oneshot` type. It indicates that the service should be considered active even after the process exits.

* `PIDFile=` If the service type is marked as `“forking”`, this directive is used to set the path of the file that should contain the process ID number of the main child that should be monitored.

* `BusName=` This directive should be set to the D-Bus bus name that the service will attempt to acquire when using the `“dbus”` service type.

* `NotifyAccess=` This specifies access to the socket that should be used to listen for notifications when the `“notify”` service type is selected This can be “none”, “main”, or "all". The default, “none”, ignores all status messages. The “main” option will listen to messages from the main process and the “all” option will cause all members of the service’s control group to be processed.

* `ExecStart=` This specifies the full path and the arguments of the command to be executed to start the process. This may only be specified once (except for “oneshot” services). If the path to the command is preceded by a dash “-” character, non-zero exit statuses will be accepted without marking the unit activation as failed.

* `ExecStartPre=` This can be used to provide additional commands that should be executed before the main process is started. This can be used multiple times. Again, commands must specify a full path and they can be preceded by “-” to indicate that the failure of the command will be tolerated.

* `ExecStartPost=` This has the same exact qualities as ExecStartPre= except that it specifies commands that will be run after the main process is started.

* `ExecReload=` This optional directive indicates the command necessary to reload the configuration of the service if available.

* `ExecStop=` This indicates the command needed to stop the service. If this is not given, the process will be killed immediately when the service is stopped.

* `ExecStopPost=` This can be used to specify commands to execute following the stop command.

* `RestartSec=` If automatically restarting the service is enabled, this specifies the amount of time to wait before attempting to restart the service.

* `Restart=` This indicates the circumstances under which systemd will attempt to automatically restart the service. This can be set to values like “always”, “on-success”, “on-failure”, “on-abnormal”, “on-abort”, or “on-watchdog”. These will trigger a restart according to the way that the service was stopped.

* `TimeoutSec=` This configures the amount of time that systemd will wait when stopping or stopping the service before marking it as failed or forcefully killing it. You can set separate timeouts with TimeoutStartSec= and TimeoutStopSec= as well.


#### `[Socket]` Section

略

#### `[Mount]` Section

略

#### `[Automount]` Section

略

#### `[Swap]` Section

略

#### `[Path]` Section

略

#### `[Timer]` Section

略

#### `[Slice]` Section

略




### systemd unit 类型

* `.service`: A service unit describes how to manage a service or application on the server. This will include how to start or stop the service, under which circumstances it should be automatically started, and the dependency and ordering information for related software.

* `.socket`: A socket unit file describes a network or IPC socket, or a FIFO buffer that systemd uses for socket-based activation. These always have an associated .service file that will be started when activity is seen on the socket that this unit defines.

* `.device`: A unit that describes a device that has been designated as needing systemd management by `udev` or the `sysfs` filesystem. Not all devices will have `.device` files. Some scenarios where `.device` units may be necessary are for ordering, mounting, and accessing the devices.

* `.mount`: This unit defines a mountpoint on the system to be managed by systemd. These are named after the mount path, with slashes changed to dashes. Entries within /etc/fstab can have units created automatically.

* `.automount`: An .automount unit configures a mountpoint that will be automatically mounted. These must be named after the mount point they refer to and must have a matching `.mount` unit to define the specifics of the mount.

* `.swap`: This unit describes swap space on the system. The name of these units must reflect the device or file path of the space.

* `.target`: 类似 run-level。 A target unit is used to provide synchronization points for other units when booting up or changing states. They also can be used to bring the system to a new state. Other units specify their relation to targets to become tied to the target’s operations. 

* `.path`: This unit defines a path that can be used for path-based activation. By default, a `.service` unit of the same base name will be started when the path reaches the specified state. This uses `inotify` to monitor the path for changes.

* `.timer`: A `.timer` unit defines a timer that will be managed by systemd, similar to a cron job for delayed or scheduled activation. A matching unit will be started when the timer is reached.

* `.snapshot`: A .snapshot unit is created automatically by the systemctl snapshot command. It allows you to reconstruct the current state of the system after making changes. Snapshots do not survive across sessions and are used to roll back temporary states.

* `.slice`: A .slice unit is associated with Linux Control Group nodes, allowing resources to be restricted or assigned to any processes associated with the slice. The name reflects its hierarchical position within the cgroup tree. Units are placed in certain slices by default depending on their type.

* `.scope`: Scope units are created automatically by systemd from information received from its bus interfaces. These are used to manage sets of system processes that are created externally.



#### unit 模板 / Template

模板文件名以 `@` 结尾： `example@.service`

应用模板出的unit 示例，通过 `@` 添加参数来生成： `example@instance1.service`

* 可以用在unit file 中的specifiers：
  * `%n` Anywhere where this appears in a template file, the full resulting unit name will be inserted.
  * `%N` This is the same as the above, but any escaping, such as those present in file path patterns, will be reversed.
  * `%p` This references the unit name prefix. This is the portion of the unit name that comes before the @ symbol.
  * `%P` This is the same as above, but with any escaping reversed.
  * `%i` This references the instance name, which is the identifier following the @ in the instance unit. This is one of the most commonly used specifiers because it will be guaranteed to be dynamic. The use of this identifier encourages the use of configuration significant identifiers. For example, the port that the service will be run at can be used as the instance identifier and the template can use this specifier to set up the port specification.
  * `%I` This specifier is the same as the above, but with any escaping reversed.
  * `%f` This will be replaced with the unescaped instance name or the prefix name, prepended with a /.
  * `%c` This will indicate the control group of the unit, with the standard parent hierarchy of /sys/fs/cgroup/ssytemd/ removed.
  * `%u` The name of the user configured to run the unit.
  * `%U` The same as above, but as a numeric UID instead of name.
  * `%H` The host name of the system that is running the unit.
  * `%%` This is used to insert a literal percentage sign.



































