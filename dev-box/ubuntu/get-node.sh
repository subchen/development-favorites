#!/bin/sh

set -e

#NODE_VERSION=6.10.1 # LTS

NODE_VERSION=7.8.0
NODE_FILENAME=node-v$NODE_VERSION-linux-x64.tar.gz

echo "Downloading $NODE_FILENAME ..." \
 && curl -fSL https://nodejs.org/dist/v$NODE_VERSION/$NODE_FILENAME -o $NODE_FILENAME \
 && curl -fSL https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt -o SHASUMS256.txt \
 && grep $NODE_FILENAME SHASUMS256.txt | sha256sum -c \
 && tar -xzf $NODE_FILENAME -C /usr/local --strip-components=1 \
 && rm -rf $NODE_FILENAME SHASUMS256.txt
