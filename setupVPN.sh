#!/bin/bash
version_compare () {
	#todo
	return 1
}
#set up Amazon EC2 virtual machine (free tier, 15G Internet bandwidth, Ubuntu 14);
echo "System check ..."
os=`uname -a | sed -n 's/.*\(Linux\).*\(Ubuntu\).*'/\1-\2/p`;
if [ -z ${os} ] ; then
	echo "Linux Ubuntu required, exit.";
	exit
fi
machine=`uname -m`;
if [ -z ${machine} ]; then 
	echo "x86_64 machine required, exit.";
	exit
fi
if [ ${machine} != "x86_64" ]; then
	echo "x86_64 machine required, exit.";
fi

#Install racoon: sudo apt-get install racoon

echo  "Racoon check ..."
racoon_path=`which racoon`
if [ -n ${racoon_path} ]; then
	ipsec_version=`racoon -V | sed -n 's/.*ipsec-tools \([0-9\.]\+\).*/\1/p'`;
	echo ${ipsec_version}
fi

version_compare ${ipsec_version} '0.5'
ret=$?
if [ ${ret} == 1 ]; then
	echo 'version check pass'
else
	echo 'ipsec-tool minimal version > 0.5 required.'
	exit
fi
#
#Prepare your VPN preference: internal IP segment, ID(IOS called "group name"), 
#PSK(pre-shared key), user/passwd;
#
default_first_ip='192.168.177.1'
default_ip_num=128

ip_number=0

echo 'Internal IP segment: 192.168.177.0/24'

while [ ${ip_number} -gt 254 -o ${ip_number} -eq 0 ]; do
	echo -n 'Input the total number(<254) of device allowed to connect to this VPN, press enter to use default value 128: '
	read ip_number
	if [ -z ${ip_number} ]; then
		ip_number=${default_ip_num}
	fi
done

echo 'Number of device allowed to connect: '${ip_number}



#Configurate racoon: racoon.conf (internal IP segment), psk.txt(ID,PSK);
echo -n 'Provisioning ... '

#modify quick.racoon.conf 
sed -i "s/\(.*pool_size\) \([0-9]\+\)/\1 ${ip_number}/" quick.racoon.conf

#start racoon

#racoon -f quick.racoon.conf

ip_addr=`ip addr show dev eth0 | sed -n 's/inet \([0-9.]\+\).*/\1/p'`
#configrate source-NAT: iptables 
#sysctl -w net.ipv4.ip_forward=1
#iptables -t nat -A POSTROUTING -s 192.168.177.0/24 -o eth0 -j SNAT --to ${ip_addr}
echo 'done'


