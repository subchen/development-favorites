#!/bin/sh

JDK_VERSION=8u73
JDK_VERSION_PATCH=b02
JDK_HOME=/usr/lib/jvm/jdk-${JDK_VERSION}

curl -fSL -H "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/${JDK_VERSION}-${JDK_VERSION_PATCH}/jdk-${JDK_VERSION}-linux-x64.tar.gz \
    -o jdk-linux-x64.tar.gz \
 && echo "1b0120970aa8bc182606a16bf848a686 jdk-linux-x64.tar.gz" | md5sum -c \
 && sudo mkdir -p $JDK_HOME \
 && sudo tar -xzf jdk-linux-x64.tar.gz --strip-components=1 -C $JDK_HOME \
 && sudo rm -rf jdk-linux-x64.tar.gz

sudo ln -sf ${JDK_HOME} /usr/lib/jvm/jdk \
 && sudo ln -sf /usr/lib/jvm/jdk/bin/java /usr/bin/java \
 && sudo ln -sf /usr/lib/jvm/jdk/bin/javac /usr/bin/javac \
 && sudo ln -sf /usr/lib/jvm/jdk/bin/jar /usr/bin/jar \
 && sudo ln -sf /usr/lib/jvm/jdk/bin/javadoc /usr/bin/javadoc \
 && sudo ln -sf /usr/lib/jvm/jdk/bin/jps /usr/bin/jps \
 && sudo ln -sf /usr/lib/jvm/jdk/bin/jstack /usr/bin/jstack \
 && sudo ln -sf /usr/lib/jvm/jdk/bin/jmap /usr/bin/jmap \
 && sudo ln -sf /usr/lib/jvm/jdk/bin/keytool /usr/bin/keytool


MAVEN_VERSION=3.3.9
MAVEN_HOME=/usr/share/maven

curl -fSL https://archive.apache.org/dist/maven/maven-${MAVEN_VERSION:0:1}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -o maven.tar.gz \
 && echo "516923b3955b6035ba6b0a5b031fbd8b maven.tar.gz" | md5sum -c \
 && sudo mkdir -p $MAVEN_HOME \
 && sudo tar xzf maven.tar.gz --strip-components=1 -C $MAVEN_HOME \
 && sudo rm -rf maven.tar.gz \
 && sudo ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn


NODE_VERSION=6.2.0

sudo curl -fSL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz -o node.tar.gz \
 && echo "75b029b30d4a4147d67cf75bf6e034291fb5919c6935ec23f8365cee2d463f12 node.tar.gz" | sha256sum -c \
 && sudo tar -xzf node.tar.gz -C /usr/local --strip-components=1 \
 && sudo rm -rf node.tar.gz
 

GOLANG_VERSION=1.6.2
GOLANG_HOME=/usr/share/go
GOPATH=/go

curl -fSL https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz -o golang.tar.gz \
 && echo "e40c36ae71756198478624ed1bb4ce17597b3c19d243f3f0899bb5740d56212a golang.tar.gz" | sha256sum -c - \
 && sudo mkdir -p $GOLANG_HOME \
 && sudo tar -zxf golang.tar.gz -C $GOLANG_HOME --strip-components=1 \
 && sudo rm -rf golang.tar.gz
 && sudo mkdir -p $GOPATH/bin $GOPATH/src

cat > ~/.go-env.bash << EOF
export GOROOT=$GOLANG_HOME
export GOPATH=$GOPATH
export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH
EOF

cat >> ~/.bashrc << EOF
. ~/.go-env.bash
EOF

. ~/.go-env.bash


