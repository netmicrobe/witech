---
layout: post
title: CentOS 7 上使用 KVM，关联 virtualize
categories: [ ]
tags: []
---

* 参考
  * [How to install KVM on CentOS 7 / RHEL 7 Headless Server](https://www.cyberciti.biz/faq/how-to-install-kvm-on-centos-7-rhel-7-headless-server/)
  * [Linux Hypervisor Setup (libvirt/qemu/kvm)](https://joshrosso.com/c/linux-hypervisor-setup/)
  * []()
  * []()
  * []()
  * []()
  * []()
  * []()
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

1. ======================================================

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
1. 
1. 
1. 
1. 
1. 
1. 
1. 
1. 
1. 
1. 
1. 
1. 
1. 
1. 
1. 
1. 








































































































































































































































