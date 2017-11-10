#!/bin/bash

JAVA_HOME=/opt/java
MAVEN_HOME=/opt/maven
CATALINA_HOME=/opt/tomcat
JPDA_ADDRESS=8000
PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin
LANG=ko_KR.utf8

export JAVA_HOME
export MAVEN_HOME
export CATALINA_HOME
export JPDA_ADDRESS
export LANG
export PATH