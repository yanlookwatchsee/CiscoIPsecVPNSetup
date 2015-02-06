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

echo  "Install/update Racoon ... begin"
apt-get install racoon
echo  "Install/update Racoon ... done"

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

ip_addr=`ip addr show dev eth0 | sed -n 's/inet \([0-9.]\+\).*/\1/p'`
#modify quick.racoon.conf 
sed -i "s/\(.*pool_size\) \([0-9]\+\)/\1 ${ip_number}/" quick.racoon.conf
sed -i  "s/isakmp[ \t]\+[0-9.]\+/isakmp ${ip_addr}/" quick.racoon.conf
sed -i "s/isakmp_natt[ \t]\+[0-9.]\+/isakmp_natt ${ip_addr}/" quick.racoon.conf
cp quick.racoon.conf /etc/racoon/racoon.conf

touch /etc/racoon/quick.racoon.psk
chmod 600 /etc/racoon/quick.racoon.psk

#start racoon
if [ -z `pidof racoon` ]; then
	racoon 
else
	racoonctl reload-config
fi

#configrate source-NAT: iptables 
sysctl -w net.ipv4.ip_forward=1
nated=`iptables -n -t nat -L | sed  -n "s/SNAT.*all.*192.168.177.0\/24.*0.0.0.0.*/yes/p"`
if [ -z "${nated}" ]; then
	iptables -t nat -A POSTROUTING -s 192.168.177.0/24 -o eth0 -j SNAT --to ${ip_addr}
fi

echo 'done'
echo '#'
echo '#'
echo '#'
echo '#'
echo '#################################################################'
echo '# Now you can connect to this public IP to try Cisco IPsec VPN  #'
echo '#################################################################'
echo '#'
echo '#'
echo '#'


