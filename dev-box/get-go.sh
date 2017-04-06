#!/bin/sh

set -e

#GOLANG_VERSION=1.7.5
#GOLANG_SHA256_SUM=2e4dd6c44f0693bef4e7b46cc701513d74c3cc44f2419bf519d7868b12931ac3

GOLANG_VERSION=1.8
GOLANG_SHA256_SUM=53ab94104ee3923e228a2cb2116e5e462ad3ebaeea06ff04463479d7f12d27ca

GOLANG_FILENAME=go${GOLANG_VERSION}.linux-amd64.tar.gz
GOLANG_HOME=/usr/share/go

echo "Downloading $GOLANG_FILENAME ..." \
 && proxy-sh curl -fSL https://storage.googleapis.com/golang/$GOLANG_FILENAME -o $GOLANG_FILENAME \
 && echo "$GOLANG_SHA256_SUM $GOLANG_FILENAME" | sha256sum -c - \
 && mkdir -p $GOLANG_HOME \
 && tar -zxf $GOLANG_FILENAME -C $GOLANG_HOME --strip-components=1 \
 && rm -rf $GOLANG_FILENAME

cat > ~/.bashrc.d/golang.sh << EOF
export GOROOT=/usr/share/go
export GOPATH=/go
export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH
EOF

. ~/.bashrc.d/golang.sh

