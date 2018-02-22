#!/bin/bash

JAVA_HOME=/opt/java
JRE_HOME=/opt/java/jre
MAVEN_HOME=/opt/maven
PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin
LANG=ko_KR.utf8

export JAVA_HOME
export MAVEN_HOME
export LANG
export PATH

nohup java -Dnexus-work=/sonatype-work -Dnexus-webapp-context-path=/ -Xms256m -Xmx768m -cp 'conf/:lib/*' -server -Djava.net.preferIPv4Stack=true org.sonatype.nexus.bootstrap.Launcher ./conf/jetty.xml ./conf/jetty-requestlog.xml >/dev/null 2>&1 &