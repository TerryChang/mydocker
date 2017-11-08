#!/bin/bash

#Oracle Listener와 관련된 파일인 listener.ora와 tnsnames.ora 파일에 대한 설정을 진행한다
#이 작업은 Oracle 이미지 빌드할때 하면 안된다. 아래에 보면 $HOSTNAME 을 이용해서 linux 서버의 host 이름을 알아오는 부분이 있는데
#빌드를 하는 시점에서 이 작업을 진행하면 $HOSTNAME은 빌드하는 리눅스 머신의 host 이름을 가져오기 때문에
#docker로 run을 할때 정해지는 리눅스 머신의 host 이름을 사용할 수 없다
#그래서 docker run을 실행할때 이 작업을 하도록 한다
LISTENER_ORA=/u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
TNSNAMES_ORA=/u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora

cp "${LISTENER_ORA}.tmpl" "$LISTENER_ORA" &&
sed -i "s/%hostname%/$HOSTNAME/g" "${LISTENER_ORA}" &&
sed -i "s/%port%/1521/g" "${LISTENER_ORA}" &&
cp "${TNSNAMES_ORA}.tmpl" "$TNSNAMES_ORA" &&
sed -i "s/%hostname%/$HOSTNAME/g" "${TNSNAMES_ORA}" &&
sed -i "s/%port%/1521/g" "${TNSNAMES_ORA}"