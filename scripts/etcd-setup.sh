#!/bin/bash

ETCD_VERSION=2.2.3

curl -fSL https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz -o etcd.tar.gz \
  && mkdir -p /tmp/etcd \
  && tar -zxf etcd.tar.gz -C /tmp/etcd --strip-components=1 \
  && mv /tmp/etcd/etcd* /usr/bin \
  && rm -rf etcd.tar.gz /tmp/etcd

mkdir -p /etc/etcd 
mkdir -p /var/lib/etcd

cat > /etc/systemd/system/multi-user.target.wants/etcd.service << EOF
[Unit]
Description=Etcd Server
After=network.target

[Service]
Type=notify
EnvironmentFile=/etc/etcd/etcd.conf
ExecStart=/usr/bin/etcd
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

LOCAL_PUBLIC_IP=$(hostname --all-ip-addresses | cut -d ' ' -f 1)

cat > /etc/etcd/etcd.conf << EOF
ETCD_NAME=default
ETCD_DATA_DIR="/var/lib/etcd/default.etcd"
ETCD_LISTEN_PEER_URLS="http://0.0.0.0:2380"
ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379"
ETCD_ADVERTISE_CLIENT_URLS="http://$LOCAL_PUBLIC_IP:2379"
EOF


