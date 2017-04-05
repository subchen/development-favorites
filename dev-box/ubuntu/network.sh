#!/bin/bash

hostname dev-box
echo dev-box > /etc/hostname

cat > /etc/network/interfaces << EOF
auto lo
iface lo inet loopback

auto ens33
iface ens33 inet static
address 192.168.10.101
netmask 255.255.255.0
gateway 192.168.10.1

dns-nameservers 8.8.8.8
EOF

/etc/init.d/networking restart


cat > /etc/hosts << EOF
127.0.0.1      localhost

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

# hostname
10.79.53.164   dev-box
EOF

cat > /etc/resolvconf/resolv.conf.d/head << EOF
nameserver 8.8.8.8
EOF

resolvconf -u

