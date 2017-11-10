#!/bin/bash

JAVA_HOME=/opt/java
MAVEN_HOME=/opt/maven
ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
ORACLE_SID=XE
PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin:$ORACLE_HOME/bin
LANG=ko_KR.utf8

export JAVA_HOME
export MAVEN_HOME
export ORACLE_HOME
export ORACLE_SID
export PATH
export LANG