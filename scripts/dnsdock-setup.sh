#!/bin/bash

set -e

curl https://raw.githubusercontent.com/subchen/development-favorites/master/binaries/dnsdock/dnsdock-1.12.0 -o /usr/bin/dnsdock
chmod +x /usr/bin/dnsdock

cat > /etc/systemd/system/dnsdock.service << EOF
[Unit]
Description=DNS service discovery for Docker containers
Documentation=https://github.com/tonistiigi/dnsdock
After=docker.service
Requires=docker.service

[Service]
Type=simple
ExecStart=/usr/bin/dnsdock -dns=:53 -http=:8053 -domain=docker -nameserver=64.104.123.245:53
MountFlags=slave
LimitNOFILE=1048576
LimitNPROC=1048576
LimitCORE=infinity
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/resolv.conf << EOF
search consul.docker
nameserver 127.0.0.1
EOF

systemctl daemon-reload
#systemctl start dnsdock
