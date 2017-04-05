#!/bin/bash

set -e
set -x

if [ `id -u` != 0 ]; then
  echo "Please run this script under root"
  exit 1
fi

ROOT=$(cd $(dirname $0); pwd)

## timezone
timedatectl set-timezone Asia/Shanghai

## install binaries and config
cp -rf $ROOT/rootfs/* /

apt-get update && apt-get install -y \
    vim tmux \
    curl wget zip unzip tree \
    git rsync \
    python-software-properties software-properties-common \
    build-essential autoconf automake autotools-dev \
    yajl-tools jq \
    sshpass sshfs silversearcher-ag


## update ~/.bashrc
sed -i '/. .bashrc.my/d' ~/.bashrc
sed -i '$a . .bashrc.my' ~/.bashrc
. ~/.bashrc.my
