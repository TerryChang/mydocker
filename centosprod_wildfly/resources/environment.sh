#!/bin/bash

JAVA_HOME=/opt/java
MAVEN_HOME=/opt/maven
JBOSS_HOME=/opt/jboss/wildfly
LAUNCH_JBOSS_IN_BACKGROUND=true
PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin
LANG=ko_KR.utf8

export JAVA_HOME
export MAVEN_HOME
export JBOSS_HOME
export LAUNCH_JBOSS_IN_BACKGROUND
export PATH
export LANG