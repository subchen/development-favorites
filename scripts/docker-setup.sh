#!/bin/bash

curl -fSL https://get.docker.com/builds/Linux/x86_64/docker-1.11.1.tgz -o /tmp/docker.tgz
tar -zxvf /tmp/docker.tgz --strip-components=1 -C /usr/bin/

curl -fSL https://github.com/docker/compose/releases/download/1.7.1/docker-compose-Linux-x86_64 -o /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

curl -fSL https://github.com/docker/machine/releases/download/v0.7.0/docker-machine_linux-amd64 -o /usr/bin/docker-machine
chmod +x /usr/bin/docker-machine

cat > /etc/systemd/system/multi-user.target.wants/docker.service << EOF
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network.target

[Service]
Type=notify
EnvironmentFile=/etc/sysconfig/docker
ExecStart=/usr/bin/docker daemon -H 0.0.0.0:2376 -H unix:///var/run/docker.sock \$DOCKER_OPTS
MountFlags=slave
LimitNOFILE=1048576
LimitNPROC=1048576
LimitCORE=infinity
TasksMax=1048576
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/sysconfig/docker << EOF
DOCKER_OPTS="--bip=10.8.0.1/24"
EOF

systemctl daemon-reload
systemctl enable docker
