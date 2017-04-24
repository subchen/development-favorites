#!/bin/bash

set -e

install_on_centos() {
    #yum-default install -y java-1.7.0-openjdk-devel
    yum-default install -y java-1.8.0-openjdk-devel
}

install_on_ubuntu() {
    proxy-sh apt-get update && apt-get install -y openjdk-8-jdk
    #proxy-sh apt-get update && apt-get install -y openjdk-9-jdk
}

install_on_all_platforms() {
    #JDK_VERSION=7u80
    #JDK_VERSION_PATCH=b15
    #JDK_DOWNLOAD_URL=http://download.oracle.com/otn-pub/java/jdk/${JDK_VERSION}-${JDK_VERSION_PATCH}/jdk-${JDK_VERSION}-linux-x64.tar.gz

    #JDK_VERSION=8u112
    #JDK_VERSION_PATCH=b15
    #JDK_DOWNLOAD_URL=http://download.oracle.com/otn-pub/java/jdk/${JDK_VERSION}-${JDK_VERSION_PATCH}/jdk-${JDK_VERSION}-linux-x64.tar.gz

    JDK_VERSION=8u121
    JDK_VERSION_PATCH=b13
    JDK_SHA256_SUM=97e30203f1aef324a07c94d9d078f5d19bb6c50e638e4492722debca588210bc
    JDK_DOWNLOAD_URL=http://download.oracle.com/otn-pub/java/jdk/${JDK_VERSION}-${JDK_VERSION_PATCH}/e9e7ea248e2c4826b92b3f075a80e441/jdk-${JDK_VERSION}-linux-x64.tar.gz

    JDK_HOME=/usr/share/java/jdk-${JDK_VERSION}

    proxy-sh curl -fSL -H "Cookie: oraclelicense=accept-securebackup-cookie" $JDK_DOWNLOAD_URL -o jdk-linux-x64.tar.gz \
     && echo "$JDK_SHA256_SUM jdk-linux-x64.tar.gz" | sha256sum -c - \
     && mkdir -p $JDK_HOME \
     && tar -xzf jdk-linux-x64.tar.gz -C $JDK_HOME --strip-components=1 \
     && rm -f jdk-linux-x64.tar.gz

    ln -sf $JDK_HOME /usr/share/java/jdk \
     && ln -sf /usr/local/share/jdk/bin/java      /usr/local/bin/java \
     && ln -sf /usr/local/share/jdk/bin/javac     /usr/local/bin/javac \
     && ln -sf /usr/local/share/jdk/bin/jar       /usr/local/bin/jar \
     && ln -sf /usr/local/share/jdk/bin/javadoc   /usr/local/bin/javadoc \
     && ln -sf /usr/local/share/jdk/bin/jps       /usr/local/bin/jps \
     && ln -sf /usr/local/share/jdk/bin/jstack    /usr/local/bin/jstack \
     && ln -sf /usr/local/share/jdk/bin/jmap      /usr/local/bin/jmap \
     && ln -sf /usr/local/share/jdk/bin/keytool   /usr/local/bin/keytool
}

install_on_all_platforms

