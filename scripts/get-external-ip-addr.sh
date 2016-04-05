#!/bin.sh

IP=`hostname -i`
echo $IP

IP=`hostname -I | cut -d ' ' -f 1`
echo $IP

IP=$(ip addr show eth0 | sed -n -r 's/.*inet ([0-9\.]+).*/\1/p')
echo $IP

IP=$(ifconfig eth0 | sed -n -r 's/.*inet ([0-9\.]+).*/\1/p')
echo $IP
