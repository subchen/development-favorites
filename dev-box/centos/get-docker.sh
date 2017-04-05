#!/bin/sh

set -e

curl -fSL https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo

yum --enablerepo=docker-ce-stable install -y docker-ce

systemctl enable docker.service
systemctl start docker.service
