#!/bin/sh

JDK_VERSION=8u73
JDK_VERSION_PATCH=b02

curl -fSL \
  http://download.oracle.com/otn-pub/java/jdk/${JDK_VERSION}-${JDK_VERSION_PATCH}/jdk-${JDK_VERSION}-linux-x64.rpm \
  -H "Cookie: oraclelicense=accept-securebackup-cookie" \
  -o jdk-${JDK_VERSION}-linux-x64.rpm

curl -fSL \
  http://download.oracle.com/otn-pub/java/jdk/${JDK_VERSION}-${JDK_VERSION_PATCH}/jdk-${JDK_VERSION}-linux-x64.tar.gz \
  -H "Cookie: oraclelicense=accept-securebackup-cookie" \
  -o jdk-${JDK_VERSION}-linux-x64.tar.gz
