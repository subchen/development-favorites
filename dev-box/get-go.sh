#!/bin/sh

set -e

ARCH=$(uname -s | tr [A-Z] [a-z])

#GOLANG_VERSION=1.7.5
#GOLANG_SHA256_SUM=2e4dd6c44f0693bef4e7b46cc701513d74c3cc44f2419bf519d7868b12931ac3

GOLANG_VERSION=1.8.1

GOLANG_FILENAME=go${GOLANG_VERSION}.$ARCH-amd64.tar.gz
GOLANG_HOME=/usr/share/go

echo "Downloading $GOLANG_FILENAME ..." \
 && proxy-sh curl -fSL https://storage.googleapis.com/golang/${GOLANG_FILENAME} -o ${GOLANG_FILENAME} \
 && proxy-sh curl -fSL https://storage.googleapis.com/golang/${GOLANG_FILENAME}.sha256 -o ${GOLANG_FILENAME}.sha256 \
 && echo "$(echo ${GOLANG_FILENAME}.sha256) $GOLANG_FILENAME" | sha256sum -c - \
 && mkdir -p $GOLANG_HOME \
 && tar -zxf $GOLANG_FILENAME -C $GOLANG_HOME --strip-components=1 \
 && rm -f $GOLANG_FILENAME ${GOLANG_FILENAME}.sha256

ln -sf $GOLANG_HOME/bin/go           /usr/local/bin/go \
 && ln -sf $GOLANG_HOME/bin/gofmt    /usr/local/bin/gofmt \
 && ln -sf $GOLANG_HOME/bin/godoc    /usr/local/bin/godoc

cat > ~/.bashrc.d/golang.sh << EOF
export GOROOT=$GOLANG_HOME
export GOPATH=/go
export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH
EOF

. ~/.bashrc.d/golang.sh

