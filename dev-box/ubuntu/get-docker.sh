#!/bin/sh

set -e

apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    software-properties-common

curl -fSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update && apt-get install -y docker-ce

systemctl enable docker.service
systemctl start docker.service

