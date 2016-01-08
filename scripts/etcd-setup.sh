#!/bin/bash

ETCD_VERSION=2.2.3

curl -fSL https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz -o etcd.tar.gz \
  && mkdir -p /tmp/etcd \
  && tar -zxf etcd.tar.gz -C /tmp/etcd --strip-components=1 \
  && mv /tmp/etcd/etcd* /usr/bin \
  && rm -rf etcd.tar.gz /tmp/etcd

mkdir -p /var/lib/etcd

cat > /etc/systemd/system/multi-user.target.wants/etcd.service << EOF
[Unit]
Description=Etcd Server
After=network.target

[Service]
EnvironmentFile=-/etc/etcd/etcd.conf
ExecStart=/usr/bin/etcd --name=default --data-dir=/var/lib/etcd/default.etcd --listen-client-urls="http://0.0.0.0:2379" --listen-peer-urls="http://0.0.0.0:2380"
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

system daemon-reload
