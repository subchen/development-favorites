#!/bin/sh

set -e

JDK_VERSION=8u73
JDK_VERSION_PATCH=b02
JDK_HOME=/usr/share/java/jdk-${JDK_VERSION}

curl -fSL -H "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/${JDK_VERSION}-${JDK_VERSION_PATCH}/jdk-${JDK_VERSION}-linux-x64.tar.gz \
  -o jdk-linux-x64.tar.gz \
&& mkdir -p $JDK_HOME \
&& tar -xzf jdk-linux-x64.tar.gz --strip-components=1 -C $JDK_HOME \
&& rm -rf jdk-linux-x64.tar.gz

ln -sf $JDK_HOME /usr/share/java/jdk \
&& ln -sf /usr/share/java/bin/java /usr/bin/java \
&& ln -sf /usr/share/java/bin/javac /usr/bin/javac \
&& ln -sf /usr/share/java/bin/jar /usr/bin/jar \
&& ln -sf /usr/share/java/bin/javadoc /usr/bin/javadoc \
&& ln -sf /usr/share/java/bin/jps /usr/bin/jps \
&& ln -sf /usr/share/java/bin/jstack /usr/bin/jstack \
&& ln -sf /usr/share/java/bin/jmap /usr/bin/jmap \
&& ln -sf /usr/share/java/bin/keytool /usr/bin/keytool
