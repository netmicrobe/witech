---
layout: post
title: Ubuntu 上安装配置 OpenVPN
categories: [ cm, linux ]
tags: [ vpn]
---

---

* 参考
  * [OpenVPN](https://openvpn.net/)
  * [DigitalOcean - How To Set Up an OpenVPN Server on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-16-04)
  * []()
  * []()

---

## OpenVPN

OpenVPN is an TLS/SSL VPN. it utilizes certificates in order to encrypt traffic between the server and clients. 



## Ubuntu 16.04 Server 上安装 OpenVPN

### Install OpenVPN

~~~ shell
sudo apt-get update
sudo apt-get install openvpn easy-rsa
~~~

`easy-rsa` package 用来配置 an internal CA (certificate authority).



### Set Up the CA Directory

In order to issue trusted certificates, we will need to set up our own simple certificate authority (CA).

copy the easy-rsa template directory into our home directory with the make-cadir command:

~~~
make-cadir ~/openvpn-ca
cd ~/openvpn-ca
~~~

Configure the CA Variables

~~~
nano ~/openvpn-ca/vars
~~~

Edit the values in red to whatever you'd prefer, but do not leave them blank:

* ~/openvpn-ca/vars
  ~~~
  . . .

  export KEY_COUNTRY="US"
  export KEY_PROVINCE="NY"
  export KEY_CITY="New York City"
  export KEY_ORG="DigitalOcean"
  export KEY_EMAIL="admin@example.com"
  export KEY_OU="Community"

  . . .
  ~~~

`KEY_NAME`的值改成自定义的名字，这里改成“server”:

* ~/openvpn-ca/vars
  ~~~
  export KEY_NAME="server"
  ~~~


### Build the Certificate Authority

~~~ shell
cd ~/openvpn-ca
source vars

# Make sure we're operating in a clean environment by typing:
./clean-all

# Now, we can build our root CA by typing:
./build-ca
~~~

执行 `build-ca` 之后会开始创建 the root certificate authority key and certificate. 之前已经配置好了 `vars` 文件，这里只要一路 `ENTER`确认就好。

~~~
Generating a 2048 bit RSA private key
..........................................................................................+++
...............................+++
writing new private key to 'ca.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [US]:
State or Province Name (full name) [NY]:
Locality Name (eg, city) [New York City]:
Organization Name (eg, company) [DigitalOcean]:
Organizational Unit Name (eg, section) [Community]:
Common Name (eg, your name or your server's hostname) [DigitalOcean CA]:
Name [server]:
Email Address [admin@email.com]:
~~~




### Create the Server Certificate, Key, and Encryption Files


generating the OpenVPN server certificate and key pair. 一路回车或者输'y'确认。

~~~
./build-key-server server
~~~

> Note: If you choose a name other than server here, you will have to adjust some of the instructions below. For instance, when copying the generated files to the /etc/openvpn directroy, you will have to substitute the correct names. You will also have to modify the /etc/openvpn/server.conf file later to point to the correct .crt and .key files.


~~~
. . .

Certificate is to be certified until May  1 17:51:16 2026 GMT (3650 days)
Sign the certificate? [y/n]:y


1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
~~~



generate a strong Diffie-Hellman keys to use during key exchange by typing:
命令执行要花个几分钟。

~~~
./build-dh
~~~

generate an HMAC signature to strengthen the server's TLS integrity verification capabilities:

~~~
openvpn --genkey --secret keys/ta.key
~~~



### Generate a Client Certificate and Key Pair

if you have more than one client, you can repeat this process as many times as you'd like. Pass in a unique value to the script for each client.


We will use `client1` as the value for our first certificate/key pair for this guide.

To produce credentials without a password, to aid in automated connections, use the `build-key` command like this:

~~~
cd ~/openvpn-ca
source vars
./build-key client1
~~~

If instead, you wish to create a password-protected set of credentials, use the `build-key-pass` command

~~~
cd ~/openvpn-ca
source vars
./build-key-pass client1
~~~


### Configure the OpenVPN Service

#### Copy the Files to the OpenVPN Directory `/etc/openvpn`

刚刚的证书和密钥文件都放在 `~/openvpn-ca/keys`

move our CA cert, our server cert and key, the HMAC signature, and the Diffie-Hellman file:

~~~
cd ~/openvpn-ca/keys
sudo cp ca.crt server.crt server.key ta.key dh2048.pem /etc/openvpn
~~~

copy and unzip a sample OpenVPN configuration file into configuration directory so that we can use it as a basis for our setup:

~~~ shell
gunzip -c /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz | sudo tee /etc/openvpn/server.conf
~~~


#### Adjust the OpenVPN Configuration

编辑 `/etc/openvpn/server.conf`

First, find the HMAC section by looking for the `tls-auth` directive. Remove the ";" to uncomment the tls-auth line. Below this, add the key-direction parameter set to "0":

~~~
tls-auth ta.key 0 # This file is secret
key-direction 0
~~~

Next, find the section on cryptographic ciphers by looking for the commented out `cipher` lines.

The AES-128-CBC cipher offers a good level of encryption and is well supported. Remove the ";" to uncomment the cipher AES-128-CBC line:

~~~
cipher AES-128-CBC
~~~

Below this, add an auth line to select the HMAC message digest algorithm. For this, SHA256 is a good choice:

~~~
auth SHA256
~~~

Finally, find the user and group settings and remove the ";" at the beginning of to uncomment those lines:

~~~
user nobody
group nogroup
~~~


#### (Optional) Push DNS Changes to Redirect All Traffic Through the VPN

If you wish to use the VPN to route all of your traffic, you will likely want to push the DNS settings to the client computers.

编辑 `/etc/openvpn/server.conf`

Find the `redirect-gateway` section and remove the semicolon ";" from the beginning of the redirect-gateway line to uncomment it:

~~~
push "redirect-gateway def1 bypass-dhcp"
~~~

Just below this, find the `dhcp-option` section. Again, remove the ";" from in front of both of the lines to uncomment them:

~~~
push "dhcp-option DNS 208.67.222.222"
push "dhcp-option DNS 208.67.220.220"
~~~

This should assist clients in reconfiguring their DNS settings to use the VPN tunnel for as the default gateway.


#### (Optional) Adjust the Port and Protocol

By default, the OpenVPN server uses port 1194 and the UDP protocol to accept client connections.

编辑 `/etc/openvpn/server.conf`

~~~
# Optional!
port 443
~~~

Often if the protocol will be restricted to that port as well. If so, change proto from UDP to TCP:

~~~
# Optional!
proto tcp
~~~


#### (Optional) Point to Non-Default Credentials

If you selected a different name during the ./build-key-server command earlier, modify the cert and key lines that you see to point to the appropriate .crt and .key files. If you used the default server, this should already be set correctly:

~~~
cert server.crt
key server.key
~~~



### Adjust the Server Networking Configuration


#### Allow IP Forwarding

First, we need to allow the server to forward traffic. This is fairly essential to the functionality we want our VPN server to provide.

修改文件 `/etc/sysctl.conf` 

look for the line that sets net.ipv4.ip_forward. Remove the "#" character from the beginning of the line to uncomment that setting:

~~~
net.ipv4.ip_forward=1
~~~

To read the file and adjust the values for the current session, type:

~~~
sudo sysctl -p
~~~



#### Adjust the UFW Rules to Masquerade Client Connections

Before we open the firewall configuration file to add masquerading, we need to find the public network interface of our machine. To do this, type:

~~~
ip route | grep default
~~~

Your public interface should follow the word "dev". For example, this result shows the interface named wlp11s0, which is highlighted below:

~~~
Output
default via 203.0.113.1 dev wlp11s0  proto static  metric 600
~~~

When you have the interface associated with your default route, open the `/etc/ufw/before.rules` file to add the relevant configuration:

编辑 `/etc/ufw/before.rules`

This file handles configuration that should be put into place before the conventional UFW rules are loaded. Towards the top of the file, add the highlighted lines below. This will set the default policy for the POSTROUTING chain in the nat table and masquerade any traffic coming from the VPN:

>Note: Remember to replace wlp11s0 in the -A POSTROUTING line below with the interface you found in the above command.


~~~
#
# rules.before
#
# Rules that should be run before the ufw command line added rules. Custom
# rules should be added to one of these chains:
#   ufw-before-input
#   ufw-before-output
#   ufw-before-forward
#

# START OPENVPN RULES
# NAT table rules
*nat
:POSTROUTING ACCEPT [0:0] 
# Allow traffic from OpenVPN client to wlp11s0 (change to the interface you discovered!)
-A POSTROUTING -s 10.8.0.0/8 -o wlp11s0 -j MASQUERADE
COMMIT
# END OPENVPN RULES

# Don't delete these required lines, otherwise there will be errors
*filter
~~~


We need to tell UFW to allow forwarded packets by default as well. To do this, we will open the `/etc/default/ufw` file:

find the DEFAULT_FORWARD_POLICY directive. We will change the value from DROP to ACCEPT:

~~~
DEFAULT_FORWARD_POLICY="ACCEPT"
~~~


#### Open the OpenVPN Port and Enable the Changes

If you did not change the port and protocol in the /etc/openvpn/server.conf file, you will need to open up UDP traffic to port 1194. If you modified the port and/or protocol, substitute the values you selected here.

~~~
sudo ufw allow 1194/udp
sudo ufw allow OpenSSH
~~~

Now, we can disable and re-enable UFW to load the changes from all of the files we've modified:

~~~
sudo ufw disable
sudo ufw enable
~~~



### Start and Enable the OpenVPN Service


We need to start the OpenVPN server by specifying our configuration file name as an instance variable after the systemd unit file name. Our configuration file for our server is called `/etc/openvpn/server.conf`, so we will add `@server` to end of our unit file when calling it:

~~~
sudo systemctl start openvpn@server
~~~

Double-check that the service has started successfully by typing:

~~~
sudo systemctl status openvpn@server
~~~

If everything went well, your output should look something that looks like this:

~~~
Output
● openvpn@server.service - OpenVPN connection to server
   Loaded: loaded (/lib/systemd/system/openvpn@.service; disabled; vendor preset: enabled)
   Active: active (running) since Tue 2016-05-03 15:30:05 EDT; 47s ago
     Docs: man:openvpn(8)
           https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage
           https://community.openvpn.net/openvpn/wiki/HOWTO
  Process: 5852 ExecStart=/usr/sbin/openvpn --daemon ovpn-%i --status /run/openvpn/%i.status 10 --cd /etc/openvpn --script-security 2 --config /etc/openvpn/%i.conf --writepid /run/openvpn/%i.pid (code=exited, sta
 Main PID: 5856 (openvpn)
    Tasks: 1 (limit: 512)
   CGroup: /system.slice/system-openvpn.slice/openvpn@server.service
           └─5856 /usr/sbin/openvpn --daemon ovpn-server --status /run/openvpn/server.status 10 --cd /etc/openvpn --script-security 2 --config /etc/openvpn/server.conf --writepid /run/openvpn/server.pid

May 03 15:30:05 openvpn2 ovpn-server[5856]: /sbin/ip addr add dev tun0 local 10.8.0.1 peer 10.8.0.2
May 03 15:30:05 openvpn2 ovpn-server[5856]: /sbin/ip route add 10.8.0.0/24 via 10.8.0.2
May 03 15:30:05 openvpn2 ovpn-server[5856]: GID set to nogroup
May 03 15:30:05 openvpn2 ovpn-server[5856]: UID set to nobody
May 03 15:30:05 openvpn2 ovpn-server[5856]: UDPv4 link local (bound): [undef]
May 03 15:30:05 openvpn2 ovpn-server[5856]: UDPv4 link remote: [undef]
May 03 15:30:05 openvpn2 ovpn-server[5856]: MULTI: multi_init called, r=256 v=256
May 03 15:30:05 openvpn2 ovpn-server[5856]: IFCONFIG POOL: base=10.8.0.4 size=62, ipv6=0
May 03 15:30:05 openvpn2 ovpn-server[5856]: IFCONFIG POOL LIST
May 03 15:30:05 openvpn2 ovpn-server[5856]: Initialization Sequence Completed
~~~


You can also check that the OpenVPN tun0 interface is available by typing:

~~~
ip addr show tun0
~~~

You should see a configured interface:

~~~
Output
4: tun0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 100
    link/none 
    inet 10.8.0.1 peer 10.8.0.2/32 scope global tun0
       valid_lft forever preferred_lft forever
~~~

If everything went well, enable the service so that it starts automatically at boot:

~~~
sudo systemctl enable openvpn@server
~~~


### Create Client Configuration Infrastructure

#### Creating the Client Config Directory Structure

~~~
mkdir -p ~/client-configs/files
chmod 700 ~/client-configs/files
~~~

#### Creating a Base Configuration

~~~
cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf ~/client-configs/base.conf
~~~

编辑 `~/client-configs/base.conf`

* First, locate the remote directive.
  * This points the client to our OpenVPN server address. This should be the public IP address of your OpenVPN server.   
  *  If you changed the port that the OpenVPN server is listening on, change 1194 to the port you selected:

  ~~~
  . . .
  # The hostname/IP and port of the server.
  # You can have multiple remote entries
  # to load balance between the servers.
  remote server_IP_address 1194
  . . .
  ~~~

  * Be sure that the protocol matches the value you are using in the server configuration:
    ~~~
    proto udp
    ~~~


* Next, uncomment the user and group directives by removing the ";":
  ~~~
  # Downgrade privileges after initialization (non-Windows only)
  user nobody
  group nogroup
  ~~~

  Find the directives that set the ca, cert, and key. Comment out these directives since we will be adding the certs and keys within the file itself:
  ~~~
  # SSL/TLS parms.
  # See the server config file for more
  # description.  It's best to use
  # a separate .crt/.key file pair
  # for each client.  A single ca
  # file can be used for all clients.

  # COMMENT OUT FOLLOWING 3 LINES
  #ca ca.crt
  #cert client.crt
  #key client.key
  ~~~

  Mirror the cipher and auth settings that we set in the /etc/openvpn/server.conf file:
  ~~~
  cipher AES-128-CBC
  auth SHA256
  ~~~

* Next, add the key-direction directive somewhere in the file. This must be set to "1" to work with the server:
  ~~~
  key-direction 1
  ~~~

* Finally, add a few commented out lines. We want to include these with every config, but should only enable them for Linux clients that ship with a /etc/openvpn/update-resolv-conf file. This script uses the resolvconf utility to update DNS information for Linux clients.

  ~~~
  # script-security 2
  # up /etc/openvpn/update-resolv-conf
  # down /etc/openvpn/update-resolv-conf
  ~~~


#### Creating a Configuration Generation Script

Next, we will create a simple script to compile our base configuration with the relevant certificate, key, and encryption files. This will place the generated configuration in the `~/client-configs/files` directory.

创建并修改 `~/client-configs/make_config.sh`

~~~ shell
#!/bin/bash

# First argument: Client identifier

KEY_DIR=~/openvpn-ca/keys
OUTPUT_DIR=~/client-configs/files
BASE_CONFIG=~/client-configs/base.conf

cat ${BASE_CONFIG} \
    <(echo -e '<ca>') \
    ${KEY_DIR}/ca.crt \
    <(echo -e '</ca>\n<cert>') \
    ${KEY_DIR}/${1}.crt \
    <(echo -e '</cert>\n<key>') \
    ${KEY_DIR}/${1}.key \
    <(echo -e '</key>\n<tls-auth>') \
    ${KEY_DIR}/ta.key \
    <(echo -e '</tls-auth>') \
    > ${OUTPUT_DIR}/${1}.ovpn
~~~

~~~
chmod 700 ~/client-configs/make_config.sh
~~~



### Generate Client Configurations

~~~
cd ~/client-configs
./make_config.sh client1
~~~

If everything went well, we should have a client1.ovpn file in our ~/client-configs/files directory:

~~~
ls ~/client-configs/files
~~~





### Install the Client Configuration



#### Windows

下载 OpenVPN 的客户端： <https://openvpn.net/index.php/open-source/downloads.html>

安装好 OpenVPN 后将 .ovpn file 拷贝到 `C:\Program Files\OpenVPN\config`

客户端必须右键菜单中选择“以管理员身份运行”。

Each time you launch the OpenVPN GUI, Windows will ask if you want to allow the program to make changes to your computer. Click Yes.

右键点击屏幕右下角OpenVPN任务栏图标，Select client1 at the top of the menu (that's our client1.ovpn profile) and choose Connect.

Disconnect from the VPN the same way: Go into the system tray applet, right-click the OpenVPN applet icon, select the client profile and click Disconnect.















































































































































































































