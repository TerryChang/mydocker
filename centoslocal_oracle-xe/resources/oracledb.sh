#!/bin/bash

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
LSNR=$ORACLE_HOME/bin/lsnrctl
SQLPLUS=$ORACLE_HOME/bin/sqlplus
SU=/bin/su
ORACLE_OWNER=oracle

# Starting Oracle Database 11g Express Edition instance and Listener
if [ $1 = "start" ]
then
    $SQLPLUS -s /nolog @$ORACLE_HOME/config/scripts/startdb.sql
elif [ $1 = "stop" ]
then
    $SQLPLUS -s /nolog @$ORACLE_HOME/config/scripts/stopdb.sql
elif [ $1 = "restart" ]
then
    $SQLPLUS -s /nolog @$ORACLE_HOME/config/scripts/stopdb.sql
	$SQLPLUS -s /nolog @$ORACLE_HOME/config/scripts/startdb.sql
else
    echo "Option[start/stop/restart]..."
fi