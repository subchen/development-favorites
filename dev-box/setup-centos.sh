#!/bin/bash

set -e
set -x

if [ "$(id -u)" != "0" ]; then
  echo "Please run this script as root!"
  exit 1
fi

ROOT=$(cd $(dirname $0); pwd)

## encoding
cat >> /etc/environment << EOF
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
EOF

## disable firewall and iptables
systemctl disable firewalld

setenforce 0
cat > /etc/sysconfig/selinux << EOF
SELINUX=disabled
SELINUXTYPE=targeted
EOF

## timezone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

## install binaries and config
cp -rf $ROOT/rootfs/*           /
cp -rf $ROOT/rootfs-centos/*    /

yum-default install -y \
    vim tmux wget curl zip unzip \
    net-tools tree psmisc bind-utils nmap-ncat \
    git rsync \
    yajl \
    yum-utils createrepo \
    make automake autoconf libtool gcc gcc-c++ \
    epel-release

yum-epel install -y \
    sshpass the_silver_searcher jq

yum-rpmforge install -y \
    fuse-sshfs


## update ~/.bashrc
echo -e "$(grep -v bashrc_devbox ~/.bashrc)\n\nsource .bashrc_devbox\n" > ~/.bashrc
source ~/.bashrc_devbox

