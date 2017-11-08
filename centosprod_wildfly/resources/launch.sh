#!/bin/sh

if [ "x$WILDFLY_HOME" = "x" ]; then
    WILDFLY_HOME="/opt/jboss/wildfly" # 경로 확인
fi
# "-bmanagement $4"는 관리콘솔 접속대역 설정으로 필요에 따라 생략 가능
if [[ "$1" == "domain" ]]; then
    $WILDFLY_HOME/bin/domain.sh -c $2 -b $3 -bmanagement $4
else
    $WILDFLY_HOME/bin/standalone.sh -c $2 -b $3 -bmanagement $4
fi