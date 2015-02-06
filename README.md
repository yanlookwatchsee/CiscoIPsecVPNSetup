# CiscoIPsecVPNSetup
Script to quick set up Cisco IPsec VPN based on raccoon,  iptables and Ubuntu.


**Set up VPN, 6 steps:**

1. set up Amazon EC2 virtual machine
    - Sign in/up Amazon EC2 service, and choose the region that is nearest from your location. (e.g. if you are in China, maybe Singapore is a good choice.)
	- Launch a instance of Ubuntu Server 14.04 LTS
	- Inbound poliy: open UDP port 500 ans UDP port 4500 (important!)

2. Get source
```sh
$ git clone https://github.com/yanlookwatchsee/CiscoIPsecVPNSetup.git
```

3. Run setup script
```sh
$ sudo ./setupVPN.sh
```
4. Add identity and pre-shared key
```sh
$ sudo ./addIdentity
```

5. Add user and password
```sh
$ sudo ./vpnuser add
```

6. Check Cisco IPsec client on your device, if not, install it. (IOS and OSX have built-in Cisco Ipsec client)
And connect to the public IP of the server from your device!

**For technical details, pelase refer to the scripts. It is really straightforward.**


