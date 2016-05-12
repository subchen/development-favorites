#!/bin/bash

set -e

yum install -y git vim zip unzip tree net-tools psmisc bind-utils

systemctl disable iptables-services firewalld

setenforce 0
cat > /etc/sysconfig/selinux << EOF
SELINUX=disabled
SELINUXTYPE=targeted
EOF

cat >> /etc/environment << EOF
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
EOF
