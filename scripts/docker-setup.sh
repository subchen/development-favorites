#!/bin/bash

curl -fSL https://get.docker.com/builds/Linux/x86_64/docker-1.9.1 -o /usr/bin/docker
curl -fSL https://github.com/docker/compose/releases/download/1.5.2/docker-compose-Linux-x86_64 -o /usr/bin/docker-compose
curl -fSL https://github.com/docker/machine/releases/download/v0.5.5/docker-machine_linux-amd64 -o /usr/bin/docker-machine
chmod +x /usr/bin/docker*

cat > /etc/systemd/system/multi-user.target.wants/docker.service << EOF
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network.target

[Service]
EnvironmentFile=/etc/sysconfig/docker
ExecStart=/usr/bin/docker daemon -H unix:///var/run/docker.sock \$DOCKER_OPTS
Type=notify
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
DOCKER_OPTS="-H 0.0.0.0:2376 --bip=10.8.0.1/24"
EOF

systemctl daemon-reload

#systemctl enable docker
#systemctl start docker
#systemctl status docker
