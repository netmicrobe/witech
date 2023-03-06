---
layout: post
title: CentOS 7 上使用 KVM，关联 virtualize
categories: [ ]
tags: []
---

* 参考
  * [How to install KVM on CentOS 7 / RHEL 7 Headless Server](https://www.cyberciti.biz/faq/how-to-install-kvm-on-centos-7-rhel-7-headless-server/)
  * [Linux Hypervisor Setup (libvirt/qemu/kvm)](https://joshrosso.com/c/linux-hypervisor-setup/)
  * [Virtualization using KVM + QEMU + libvirt](https://www.dwarmstrong.org/kvm-qemu-libvirt/)
  * [qemu:///system vs qemu:///session](https://blog.wikichoon.com/2016/01/qemusystem-vs-qemusession.html)
  * [Install Windows 10 on Pop!OS - Raphael](https://raphtlw.medium.com/how-to-set-up-a-kvm-qemu-windows-10-vm-ca1789411760)
  * [Performance Tweaks](https://pve.proxmox.com/wiki/Performance_Tweaks)
  * [10 Easy Steps To Install Windows 10 on Linux KVM – KVM Windows](https://getlabsdone.com/10-easy-steps-to-install-windows-10-on-linux-kvm/)
  * [Solution | How To Extend Windows Storage in KVM ?](https://getlabsdone.com/how-to-extend-windows-storage-in-kvm/)
  * []()
  * []()
  * []()



1. 检查是否支持虚拟化，不支持的话，重启去BIOS里面设置下

    ~~~sh
    lscpu | grep Virtualization

    Virtualization: VT-x
    ~~~

1. 安装 KVM

    ~~~sh
    yum install qemu-kvm libvirt libvirt-python libguestfs-tools virt-install
    ~~~

    Start the libvirtd service:

    ~~~sh
    systemctl enable libvirtd
    systemctl start libvirtd
    ~~~

    Verify kvm installation

    ~~~sh
    # Make sure KVM module loaded
    lsmod | grep -i kvm
    ~~~~

1. 权限设置
    这一步在centos上使用root倒不需要，在 debian 系上用的。
    
    1. 添加用户到 `kvm` 和 `libvirt` 用户组
        ~~~sh
        sudo adduser foo kvm
        sudo adduser foo libvirt
        ~~~

    1. libvirt.conf
        ~~~sh
        $ mkdir ~/.config/libvirt
        $ sudo cp -rv /etc/libvirt/libvirt.conf ~/.config/libvirt/
        $ sudo chown foo: ~/.config/libvirt/libvirt.conf
        ~~~

        修改 libvirt.conf
        ~~~
        uri_default = "qemu:///system"
        ~~~

    1. qemu.conf

        修改 `/etc/libvirt/qemu.conf`， 设置 `user` 为自己，`group` 为 `libvirt`
        ~~~
        user = "foo"
        group = "libvirt"
        ~~~

    1. 重启 `libvirt` 服务
        ~~~
        sudo systemctl start libvirtd
        ~~~


1. Configure bridged networking

    By default dhcpd based network bridge configured by libvirtd. 


    `brctl show`

    ~~~
    bridge name     bridge id               STP enabled     interfaces
    virbr0          8000.525500b8fe2c       yes             virbr0-nic
    ~~~

    `virsh net-list`

    ~~~
     Name                 State      Autostart     Persistent
    ----------------------------------------------------------
     default              active     yes           yes
    ~~~

    All VMs (guest machine) only have network access to other VMs on the same server. A private network 192.168.122.0/24 created 

    ~~~sh
    virsh net-dumpxml default
    ~~~

    If you want your VMs avilable to other servers on your LAN, setup a a network bridge on the server that connected to the your LAN. Update your nic config file such as ifcfg-enp3s0 or em1:

    编辑 `/etc/sysconfig/network-scripts/enp3s0` ，添加 `BRIDGE=br0`

    编辑 `/etc/sysconfig/network-scripts/ifcfg-br0` ，添加：

    ~~~
    DEVICE="br0"
    # I am getting ip from DHCP server #
    BOOTPROTO="dhcp"
    IPV6INIT="yes"
    IPV6_AUTOCONF="yes"
    ONBOOT="yes"
    TYPE="Bridge"
    DELAY="0"
    ~~~

    Restart the networking service (warning ssh command will disconnect, it is better to reboot

    ~~~sh
    systemctl restart NetworkManager
    ~~~

    Verify it with brctl command: `brctl show`

    ~~~
    bridge name     bridge id               STP enabled     interfaces
    br0             8000.e0d55e4b60d1       no              enp0s31f6
    virbr0          8000.525500b8fe2c       yes             virbr0-nic
    ~~~

1. ======================================================

1. 创建VM（以创建centos 7为例）

1. 下载iso
    ~~~sh
    cd /var/lib/libvirt/boot/
    wget https://mirrors.nju.edu.cn/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso

    # Verify ISO images:
    wget https://mirrors.nju.edu.cn/centos/7.9.2009/isos/x86_64/sha256sum.txt
    sha256sum --ignore-missing -c sha256sum.txt
    ~~~
1. Create CentOS 7.x VM
    下例创建 CentOS 7.x VM with 2GB RAM, 2 CPU core, 1 nics and 40GB disk space
    ~~~sh
    virt-install \
    --virt-type=kvm \
    --name centos7 \
    --ram 2048 \
    --vcpus=1 \
    --os-variant=centos7.0 \
    --cdrom=/var/lib/libvirt/boot/CentOS-7-x86_64-Minimal-2009.iso \
    --network=bridge=br0,model=virtio \
    --graphics vnc \
    --disk path=/var/lib/libvirt/images/centos7.qcow2,size=40,bus=virtio,format=qcow2
    ~~~
1. 看下 vnc 设置端口，例如，端口是 5901
    ~~~sh
    virsh dumpxml centos7 | grep vnc
    <graphics type='vnc' port='5901' autoport='yes' listen='127.0.0.1'>
    ~~~
1. 在工作电脑上设置一个到虚拟机的隧道
    ~~~sh
    ssh vivek@server1.cyberciti.biz -L 5901:127.0.0.1:5901
    ~~~
1. 在工作电脑上打开 vnc viewer
    连接地址: localhost:5900
1. vnc连上后，就会看到centos的安装UI界面，按照提示安装。
1. centos安装完成后，重启完成，vnc可以连接上去，操作命令行登录，安装openssh后，使用ssh。
1. qcow2 磁盘文件是逐步增长的，安装centos完成后，`/var/lib/libvirt/images/centos7-1.qcow2`的大小约 1.7G

1. 配置下网卡
    虚拟机创建好，在 `virt-manager` 图形界面下，可以看到有一个虚拟网卡：
    * Network source: Bridge br0: Host devices enp0s31f6
    * Device model: virtio

    但此时网卡默认不会启动，修改下 `/etc/sysconfig/network-scripts/` 中 `ONBOOT=yes`，
    然后重启虚拟机，虚拟网卡启动后，通过host 的 bridge 进入 host 所在的 LAN。

1. 查询、启动、关闭虚拟机 ==============================================

1. 列出所有虚拟机
    ~~~sh
    # virsh list --all
     Id    Name                           State
    ----------------------------------------------------
     -     centos7-1                      shut off
    ~~~

1. 使用 `virsh start` 启动虚拟机
    ~~~sh
    virsh start centos7-1

    virsh list --all
     Id    Name                           State
    ----------------------------------------------------
     1     centos7-1                      running
    ~~~

1. 使用 `virsh shutdown` 关闭虚拟机
    ~~~sh
    virsh shutdown centos7-1
    ~~~
1. 
1. 
1. 使用 virt-manager 安装 Windows 10 ==============================================
    * [Spice 下载](https://www.spice-space.org/download.html)
1. New VM
1. Choose how you would like to install the operating system:
    勾选 Local install media(ISO image or CDROM)
1. 选择 windows 10 iso 文件
1. 勾选 Automatically detect operating system based on install media
    识别出来： OS type : Windows  ,  Version : Microsoft Windows 10
1. 设置 Memory： 8192M （8G）
1. 设置CPU数目
1. 设置硬盘大小： 默认 40G
1. 设置虚拟机Name
1. 勾选 Customize configuration before install
1. Network selection: 这里选bridge 模式： Bridge br0: Host device enp0s31f6
1. 点击 Finish，完成创建。

1. 继续，安装之前的配置
1. 修改虚拟硬盘的性能
    1. 选中 "IDE Disk 1"，修改 disk storage type 为 virtio （默认是IDE）
    1. 点 Apply
    1. 选中 "VirtIO Disk 1"
        Performance Options
            Cache mode: none
            IO mode: Hypervisor default

1. 设置windows iso 的 CDROM
1. source path 点击connect，选中windows 10 的安装iso
1. Disk bus，还是选IDE，虽然慢点，兼容性好
1. 
1. 设置kvm的windows驱动 CDROM
    1. Add Hardware，选择`virtio-win-0.1.229.iso`，Disk bus，还是选IDE，SATA的话，后面windows installer 找不到。

1. 选中“Boot Options”，设置下启动顺序

1. 选中 “CPU”， 勾选 "Manually set CPU topology"
    Sockets: 1
    Cores 和 Threads 自己看物理CPU性能判断吧。

1. 选中 “Display Spice” ，不用改，保持默认
    Type： Spice server
    Listen type: Address
    Address: Hypervisor default
    Port: 勾选 Auto
    TLS Port: 勾选 Auto
1. 选中 “Video QXL”，不用改，保持默认
    Model: QXL”

1. 配置好后，不要x掉这个配置窗口！！ 点击窗口左上角“Begin Installation”
1. 按照提示安装，弹出“选择要安装的驱动程序”
    提示：缺少计算机所需的介质驱动程序。
1. 点击“Load drivers”，浏览文件系统，在 `virtio-win-0.1.229.iso` 的盘下面找到驱动
    硬盘驱动，`win10/amd64` 目录下
    网卡驱动， `NetKVM`目录下，我没装这个驱动，也正常的。
    显卡驱动， `qxldod`目录下，我没装这个驱动，也正常的。
1. 接下来和不同安装 Windows 10 过程一样，直到安装完成，进入windows10
1. 
1. 安装 VirtIO guest tools ，会提高虚拟机Spice的性能和集成度。
    包括qxl video driver and the SPICE guest agent (for copy and paste, automatic resolution switching, …)
1. 进入 `virtio-win-0.1.229.iso` 挂载的盘符，运行根目录下的 `wirtio-win-guest-tools`
1. 一路next，直到装好。
1. 
1. 
1. 
1. 
1. 
1. 





## 克隆VM

~~~sh
virt-clone \
  --original ubuntu18.04 \
  --name cloned-ubuntu \
  --file /var/lib/libvirt/images/cu.qcow2
~~~



## 目录说明

虚拟机image默认目录： `/var/lib/libvirt/images`
系统iso光盘文件目录： `/var/lib/libvirt/isos`






























































































































































































































