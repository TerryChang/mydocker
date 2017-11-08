#furywolf/centosprod 기반으로 만든 oracle 이미지
#oracle의 sys와 system 계정의 패스워드는 oracle이다

FROM furywolf/centosprod

MAINTAINER Terry Chang <furywolf@hanmail.net>

ENV ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe \
	ORACLE_SID=XE

#환경변수 ORACLE_HOME과 ORACLE_SID를 설정하고
#path 설정(terrycentos 이미지에 PATH 관련으로 /etc/profile.d/path.sh이 있기 때문에 이 파일에 추가가 되도록 설정한다)
RUN echo -e "ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe\nORACLE_SID=XE" >> /etc/environment \
    && echo "$(cat /etc/profile.d/path.sh):$ORACLE_HOME/bin" > /etc/profile.d/path.sh

ADD assets /assets
RUN chmod +x /assets/setup.sh && /assets/setup.sh

ADD resources/oracledb.sh /etc/systemd/system/oracledb.sh
ADD resources/oracle.conf /etc/systemd/system/oracle.conf
ADD resources/lsnrctl.service /etc/systemd/system/lsnrctl.service
ADD resources/oracle.service /etc/systemd/system/oracle.service
# oracle setup이 끝나면 /u01/app/oracle/product/11.2.0/xe/network/admin 가 생성되기 때문에 listener_setup.sh 파일을 복사해둔다
# listener_setup.sh 파일의 역할에 대해서는 listener_setup.sh 파일 안에 있으니 참조할것
ADD resources/listener_setup.sh /u01/app/oracle/product/11.2.0/xe/network/admin/listener_setup.sh	
RUN chmod +x /etc/systemd/system/oracledb.sh \
    && chmod +x /u01/app/oracle/product/11.2.0/xe/network/admin/listener_setup.sh \
	&& systemctl enable lsnrctl \
    && systemctl enable oracle

#oracle 테이블스페이스를 별도로 저장할 디렉토리를 만들어둔뒤에 이를 Host OS와 공유하게 함으로써
#테이블스페이스 파일을 재사용을 할 수 있도록 한다
RUN mkdir -p /mnt/shared/tablespaces
VOLUME ["/mnt/shared/tablespaces"]

EXPOSE 21 22 1521 8080 64000-64010

# 부팅하면서 실행해야 할 명령들이 있는 init.sh를 이미지에 넣어둔뒤 실행을 한다
# init.sh 에서 SSH 서비스 데몬을 기동하게 되며 추가로 부팅하면서 실행해야 할 명령들이 있을 경우 init.sh에 해당 명령을 넣어둔다
ADD resources/init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh
ENTRYPOINT ["/usr/local/bin/init.sh"]
