#!/bin/sh

set -e

MAVEN_VERSION=3.3.9
MAVEN_HOME=/usr/share/maven

echo "Downloading maven $MAVEN_VERSION ..." \
 && proxy-sh curl -fSL https://archive.apache.org/dist/maven/maven-${MAVEN_VERSION:0:1}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz     -o maven.tar.gz \
 && proxy-sh curl -fSL https://archive.apache.org/dist/maven/maven-${MAVEN_VERSION:0:1}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz.md5 -o maven.tar.gz.md5 \
 && echo "$(cat maven.tar.gz.md5) maven.tar.gz" | md5sum -c \
 && mkdir -p $MAVEN_HOME \
 && tar xzf maven.tar.gz -C $MAVEN_HOME --strip-components=1 \
 && rm -rf maven.tar.gz maven.tar.gz.md5 \
 && ln -sf $MAVEN_HOME/bin/mvn /usr/bin/mvn

