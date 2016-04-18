#!/bin/sh

JDK_VERSION=8u73
JDK_VERSION_PATCH=b02
JDK_HOME=/usr/lib/jvm/jdk-${JDK_VERSION}

sudo curl -fSL -H "Cookie: oraclelicense=accept-securebackup-cookie" \
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
&& sudo ln -sf /usr/lib/jvm/jdk/bin/jmap /usr/bin/jmap


MAVEN_VERSION=3.3.9
MAVEN_HOME=/usr/share/maven

sudo curl -fSL https://archive.apache.org/dist/maven/maven-${MAVEN_VERSION:0:1}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -o maven.tar.gz \
 && echo "516923b3955b6035ba6b0a5b031fbd8b maven.tar.gz" | md5sum -c \
 && sudo mkdir -p $MAVEN_HOME \
 && sudo tar xzf maven.tar.gz --strip-components=1 -C $MAVEN_HOME \
 && sudo rm -rf maven.tar.gz \
 && sudo ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn
 
