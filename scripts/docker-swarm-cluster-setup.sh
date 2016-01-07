#!/bin/bash

ETCD_VERSION=2.0.10

curl -fSL https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz -o etcd.tar.gz \
  && mkdir -p /tmp/etcd \
  && tar -zxf etcd.tar.gz -C /tmp/etcd --strip-components=1 \
  && mv /tmp/etcd/etcd* /usr/bin \
  && rm -rf etcd.tar.gz /tmp/etcd

mkdir -p /var/lib/etcd/default.etcd
etcd --name=default \
  --data-dir=/var/lib/etcd/default.etcd \
  --listen-client-urls="http://0.0.0.0:2379" \
  --listen-peer-urls="http://0.0.0.0:2380" \
  &


IFACE_NAME=${IFACE_NAME:-eno16777736}

ETCD_IP=$(ip addr show $IFACE_NAME | sed -n -r 's/.*inet ([0-9.]+).*/\1/p')

#SWARM_MASTER="172.16.86.201"
#SWARM_SLAVES="172.16.86.202 172.16.86.203"

docker-machine create \
  -d generic \
  --generic-ip-address=$SWARM_MASTER \
  --generic-ssh-user=root \
  --swarm \
  --swarm-master \
  --swarm-discovery="etcd://$ETCD_IP:2379" \
  --engine-opt="cluster-store=etcd://$ETCD_IP:2379" \
  --engine-opt="cluster-advertise=$IFACE_NAME:2376" \
  swarm-master


INDEX=0
for SLAVE in $SWARM_SLAVES; do
  INDEX=$(expr $INDEX + 1)
  docker-machine create \
    -d generic \
    --generic-ip-address=$SLAVE \
    --generic-ssh-user=root \
    --swarm \
      --swarm-discovery="etcd://$ETCD_IP:2379" \
      --engine-opt="cluster-store=etcd://$ETCD_IP:2379" \
      --engine-opt="cluster-advertise=$IFACE_NAME:2376" \
      swarm-slave-$INDEX
done
