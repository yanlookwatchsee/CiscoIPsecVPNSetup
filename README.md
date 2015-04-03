# CiscoIPsecVPNSetup
Script to quick set up Cisco IPsec VPN based on raccoon,  iptables and Ubuntu.


**Set up VPN, 6 steps:**

1 set up Amazon EC2 virtual machine
    
- Sign in/up Amazon EC2 service, and choose the region that is nearest from your location. (e.g. if you are in China, maybe Singapore is a good choice.)
- Launch a instance of Ubuntu Server 14.04 LTS
- Inbound poliy: open UDP port <b>500</b> ans UDP port <b>4500</b> (<b>important</b>)

2 Get source

```sh
$ git clone https://github.com/yanlookwatchsee/CiscoIPsecVPNSetup.git
```
3 Run setup script

```sh
$ sudo ./setupVPN.sh
```
4 Add identity and pre-shared key

```sh
$ sudo ./addIdentity
```

5 Add user and password

```sh
$ sudo ./vpnuser add
```

6 Check Cisco IPsec client on your device, if not, install it. (IOS and OSX have built-in Cisco Ipsec client)
And connect to the public IP of the server from your device!
>**Tips** Normally, you need to provide *user account* (vpnuser name), *user password*, *identity* (in IOS, it is called as *group name*)" and *pre-shared key* (PSK). Note that if you have to choose authentication method, choose *PSK* for authentication.


----------

**For technical details, pelase refer to the scripts. It is really straightforward.**


----------

**References**

*[How to build a remote user access VPN with Racoon] 

*[Simple Configuration Sample of IPsec/Racoon]

*[Chapter 7. IPSEC: secure IP over the Internet]
 
*[racoon(8) - Linux man page]

*[racoon mode_cfg section]


[How to build a remote user access VPN with Racoon]: http://www.netbsd.org/docs/network/ipsec/rasvpn.html
[Simple Configuration Sample of IPsec/Racoon]: http://www.kame.net/newsletter/20001119/
[Chapter 7. IPSEC: secure IP over the Internet]: http://www.lartc.org/howto/lartc.ipsec.html
[racoon(8) - Linux man page]: http://linux.die.net/man/8/racoon
[racoon mode_cfg section]: https://www.shrew.net/static/help-1.0.x/mode_cfgsection.htm



