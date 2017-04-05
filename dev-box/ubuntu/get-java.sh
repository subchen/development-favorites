#!/bin/sh

set -e

#apt-get update && apt-get install -y openjdk-8-jdk
#apt-get update && apt-get install -y openjdk-9-jdk

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

curl -fSL -H "Cookie: oraclelicense=accept-securebackup-cookie" $JDK_DOWNLOAD_URL -o jdk-linux-x64.tar.gz \
 && echo "$JDK_SHA256_SUM jdk-linux-x64.tar.gz" | sha256sum -c - \
 && mkdir -p $JDK_HOME \
 && tar -xzf jdk-linux-x64.tar.gz -C $JDK_HOME --strip-components=1 \
 && rm -rf jdk-linux-x64.tar.gz

ln -sf $JDK_HOME /usr/share/java/jdk \
 && ln -sf /usr/share/java/jdk/bin/java      /usr/bin/java \
 && ln -sf /usr/share/java/jdk/bin/javac     /usr/bin/javac \
 && ln -sf /usr/share/java/jdk/bin/jar       /usr/bin/jar \
 && ln -sf /usr/share/java/jdk/bin/javadoc   /usr/bin/javadoc \
 && ln -sf /usr/share/java/jdk/bin/jps       /usr/bin/jps \
 && ln -sf /usr/share/java/jdk/bin/jstack    /usr/bin/jstack \
 && ln -sf /usr/share/java/jdk/bin/jmap      /usr/bin/jmap \
 && ln -sf /usr/share/java/jdk/bin/keytool   /usr/bin/keytool
