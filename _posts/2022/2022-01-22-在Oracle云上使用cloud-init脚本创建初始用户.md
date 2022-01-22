---
layout: post
title: 在Oracle云上使用cloud-init脚本创建初始用户
categories: [cm, linux]
tags: [mkpasswd]
---


* 参考
  * [Oracle Cloud Blog - Direct Console access to your Linux Instances from the OCI Console](https://www.oc-blog.com/2021/10/06/direct-console-access-to-your-linux-instances-from-the-oci-console/?utm_source=rss&utm_medium=rss&utm_campaign=direct-console-access-to-your-linux-instances-from-the-oci-console)
  * [could-init Release 21.4 - pdf](https://readthedocs.org/projects/cloudinit/downloads/pdf/latest/)
  * [Cloud config examples](https://cloudinit.readthedocs.io/en/latest/topics/examples.html)
  * [Oracle Cloud Infrastructure Compute](https://plugins.jenkins.io/oracle-cloud-infrastructure-compute/)
  * [oci-learning - Creating Compute Instance](https://enabling-cloud.github.io/oci-learning/manual/CreatingComputeInstance.html)
  * [Martins Blog - Bootstrapping a VM image in Oracle Cloud Infrastructure using cloud-init](https://martincarstenbach.wordpress.com/2018/11/30/bootstrapping-a-vm-image-in-oracle-cloud-infrastructure-using-cloud-init/)
  * []()


Oracle Cloud 上创建实例的时候，默认都是设置公钥登录，但是如果密钥没输入正确，就白瞎这台虚拟机了，登不上呀。

可以临时创建 Console Connection ，上传新的公钥，但是进去之后发现，还TM要输入帐号和密码，默认根本没密码呀。。。woc！！

这里使用 cloud-init 脚本，在虚拟机创建的时候，创建一个可以用来从console connection登录、且可sudo的帐号。

1. 创建 instance，配置主要参数后，点击“Create”按钮上面的“Show Advanced Options”
1. Management 》Paste cloud-init script
    ~~~
    #cloud-config
    users:
    - default
    - name: backdoor
      sudo: ALL=(ALL) NOPASSWD:ALL
      lock_passwd: false
      passwd: $6$MFhXlUHt$JG.sn2M4ReeZ.V/TDs8AWJzhA1anX0iUbE0WvfR8v/8d4eGv8v6EwhyiKO.6VixMaC8/dG.YQce01QV8w1.dZ0
    ~~~
    以上脚本，创建了一个名为 **backddor** 的用户，密码为 `1LoveOracle!!`，但是他没有公钥，所以他没法通过ssh登录。

    * passwd 密文的生成方法：
        ~~~bash
        yay -S mkpasswd
        mkpasswd --method=SHA-512 --salt=MFhXlUHt
        # 输入密码后回车，会生成密文
        ~~~
        以上例子中的密文开头部分 `$6$MFhXlUHt$` ，`6` 表示加密方法是 SHA-512，当然可以换其他加密方法，例如，SHA-265 对应 `5`，详情可查看 mkpasswd 的帮助文档。`MFhXlUHt` 就是执行mkpasswd时，传入的salt参数。
1. 点击 create ，创建实例
1. 实例详情页面，左侧导航 Resources 》Console Connection
1. 点击 Create local Connection ，上传当前linux电脑的 public key
1. 创建完成后，点击 connection 对应的三个竖排点，出现的菜单中选择 `Copy serial console connection for Linux/Mac`
1. 将拷贝好的命令，在当前linux电脑执行。就可以通过Oracle的代理连上虚拟机了。
1. 这时候输入用户名和密码就能进去操作了。
1. `sudo -i` 可以提权到root


### cloud-init 脚本 users 配置参考

Cloud config examples
Including users and groups

~~~shell
#cloud-config
# Add groups to the system
# The following example adds the ubuntu group with members 'root' and 'sys'
# and the empty group cloud-users.
groups:
  - ubuntu: [root,sys]
  - cloud-users

# Add users to the system. Users are added after groups are added.
# Note: Most of these configuration options will not be honored if the user
#       already exists. Following options are the exceptions and they are
#       applicable on already-existing users:
#       - 'plain_text_passwd', 'hashed_passwd', 'lock_passwd', 'sudo',
#         'ssh_authorized_keys', 'ssh_redirect_user'.
users:
  - default
  - name: foobar
    gecos: Foo B. Bar
    primary_group: foobar
    groups: users
    selinux_user: staff_u
    expiredate: '2032-09-01'
    ssh_import_id:
      - lp:falcojr
      - gh:TheRealFalcon
    lock_passwd: false
    passwd: $6$j212wezy$7H/1LT4f9/N3wpgNunhsIqtMj62OKiS3nyNwuizouQc3u7MbYCarYeAHWYPYb2FT.lbioDm2RrkJPb9BZMN1O/
  - name: barfoo
    gecos: Bar B. Foo
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    ssh_import_id:
      - lp:falcojr
      - gh:TheRealFalcon
    lock_passwd: true
    ssh_authorized_keys:
      - <ssh pub key 1>
      - <ssh pub key 2>
  - name: cloudy
    gecos: Magic Cloud App Daemon User
    inactive: '5'
    system: true
  - name: fizzbuzz
    sudo: False
    ssh_authorized_keys:
      - <ssh pub key 1>
      - <ssh pub key 2>
  - snapuser: joe@joeuser.io
  - name: nosshlogins
    ssh_redirect_user: true

# Valid Values:
#   name: The user's login name
#   expiredate: Date on which the user's account will be disabled.
#   gecos: The user name's real name, i.e. "Bob B. Smith"
#   homedir: Optional. Set to the local path you want to use. Defaults to
#           /home/<username>
#   primary_group: define the primary group. Defaults to a new group created
#           named after the user.
#   groups:  Optional. Additional groups to add the user to. Defaults to none
#   selinux_user:  Optional. The SELinux user for the user's login, such as
#           "staff_u". When this is omitted the system will select the default
#           SELinux user.
#   lock_passwd: Defaults to true. Lock the password to disable password login
#   inactive: Number of days after password expires until account is disabled
#   passwd: The hash -- not the password itself -- of the password you want
#           to use for this user. You can generate a safe hash via:
#               mkpasswd --method=SHA-512 --rounds=4096
#           (the above command would create from stdin an SHA-512 password hash
#           with 4096 salt rounds)
#
#           Please note: while the use of a hashed password is better than
#               plain text, the use of this feature is not ideal. Also,
#               using a high number of salting rounds will help, but it should
#               not be relied upon.
#
#               To highlight this risk, running John the Ripper against the
#               example hash above, with a readily available wordlist, revealed
#               the true password in 12 seconds on a i7-2620QM.
#
#               In other words, this feature is a potential security risk and is
#               provided for your convenience only. If you do not fully trust the
#               medium over which your cloud-config will be transmitted, then you
#               should use SSH authentication only.
#
#               You have thus been warned.
#   no_create_home: When set to true, do not create home directory.
#   no_user_group: When set to true, do not create a group named after the user.
#   no_log_init: When set to true, do not initialize lastlog and faillog database.
#   ssh_import_id: Optional. Import SSH ids
#   ssh_authorized_keys: Optional. [list] Add keys to user's authorized keys file
#   ssh_redirect_user: Optional. [bool] Set true to block ssh logins for cloud
#       ssh public keys and emit a message redirecting logins to
#       use <default_username> instead. This option only disables cloud
#       provided public-keys. An error will be raised if ssh_authorized_keys
#       or ssh_import_id is provided for the same user.
#
#       ssh_authorized_keys.
#   sudo: Defaults to none. Accepts a sudo rule string, a list of sudo rule
#         strings or False to explicitly deny sudo usage. Examples:
#
#         Allow a user unrestricted sudo access.
#             sudo:  ALL=(ALL) NOPASSWD:ALL
#
#         Adding multiple sudo rule strings.
#             sudo:
#               - ALL=(ALL) NOPASSWD:/bin/mysql
#               - ALL=(ALL) ALL
#
#         Prevent sudo access for a user.
#             sudo: False
#
#         Note: Please double check your syntax and make sure it is valid.
#               cloud-init does not parse/check the syntax of the sudo
#               directive.
#   system: Create the user as a system user. This means no home directory.
#   snapuser: Create a Snappy (Ubuntu-Core) user via the snap create-user
#             command available on Ubuntu systems.  If the user has an account
#             on the Ubuntu SSO, specifying the email will allow snap to
#             request a username and any public ssh keys and will import
#             these into the system with username specifed by SSO account.
#             If 'username' is not set in SSO, then username will be the
#             shortname before the email domain.
#

# Default user creation:
#
# Unless you define users, you will get a 'ubuntu' user on ubuntu systems with the
# legacy permission (no password sudo, locked user, etc). If however, you want
# to have the 'ubuntu' user in addition to other users, you need to instruct
# cloud-init that you also want the default user. To do this use the following
# syntax:
#   users:
#     - default
#     - bob
#     - ....
#  foobar: ...
#
# users[0] (the first user in users) overrides the user directive.
#
# The 'default' user above references the distro's config:
# system_info:
#   default_user:
#     name: Ubuntu
#     plain_text_passwd: 'ubuntu'
#     home: /home/ubuntu
#     shell: /bin/bash
#     lock_passwd: True
#     gecos: Ubuntu
#     groups: [adm, audio, cdrom, dialout, floppy, video, plugdev, dip, netdev]
~~~






















