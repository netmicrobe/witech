---
layout: post
title: manjaro-更新报错-signature-unknown-trust，关联 
categories: [ ]
tags: []
---

* 参考
  * [Cannot update Manjaro Linux: Unknown trust with Archlinux-keyring](https://unix.stackexchange.com/questions/439780/cannot-update-manjaro-linux-unknown-trust-with-archlinux-keyring)
  * [Pacman's always failed when upgrading (unknown trust)](https://unix.stackexchange.com/questions/171657/pacmans-always-failed-when-upgrading-unknown-trust?noredirect=1&lq=1)
  * [Manjaro is unable to update (GPGME & keyring errors) ](https://forum.manjaro.org/t/manjaro-is-unable-to-update-gpgme-keyring-errors/96941)
  * [Mitigate and prevent GPGME error when syncing your system](https://forum.manjaro.org/t/root-tip-how-to-mitigate-and-prevent-gpgme-error-when-syncing-your-system/84700)
  * [Update of manjaro-keyring gave errors](https://forum.manjaro.org/t/update-of-manjaro-keyring-gave-errors/108968/27)
  * [Unable to update my system due to signing key errors ](https://forum.manjaro.org/t/unable-to-update-my-system-due-to-signing-key-errors/111900)
  * []()
  * []()


~~~
error: archlinux-keyring: signature from "Christian Hesse (Arch Linux Package Signing) <arch@eworm.de>" is unknown trust
:: File /var/cache/pacman/pkg/archlinux-keyring-20221123-1-any.pkg.tar.zst is corrupted (invalid or corrupted package (PGP signature)).
Do you want to delete it? [Y/n] 
error: failed to commit transaction (invalid or corrupted package)
Errors occurred, no packages were upgraded.
~~~


解决办法

1. 修改 pacman 设置，先不要检查签名
    1. 修改 `sudo vi /etc/pacman.conf`
    1. `[options]` 部分，`SigLevel` 改为 `Optional TrustAll`
1. 重建 keyring
    ~~~sh
    sudo rm -r /etc/pacman.d/gnupg
    sudo pacman -Sy gnupg archlinux-keyring manjaro-keyring
    sudo pacman-key --init
    sudo pacman-key --populate archlinux manjaro
    # refresh-keys 这一步等挺长时间的
    sudo pacman-key --refresh-keys 
    sudo pacman -Sc
    ~~~
1. 为了安全 `SigLevel` 改为 `Required DatabaseOptional`
1. 更新系统 `sudo pacman -Syyu`




