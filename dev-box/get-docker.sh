#!/bin/bash

set -e

install_on_centos() {
    proxy-sh curl -fSL https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo
    yum-default --enablerepo=docker-ce-stable install -y docker-ce
}

install_on_ubuntu() {
    proxy-sh apt-get update && proxy-sh apt-get install -y \
        apt-transport-https ca-certificates software-properties-common

    proxy-sh curl -fSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

    proxy-sh apt-get update && proxy-sh apt-get install -y \
        docker-ce
}

if [ -f /etc/redhat-release ]; then
    install_on_centos
else
    install_on_ubuntu
fi

systemctl daemon-reload
systemctl enable docker.service
systemctl start docker.service

