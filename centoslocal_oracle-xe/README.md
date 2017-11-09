furywolf/centolocal_oracle-xe
====================

[furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/)를 기준 이미지로 해서 만든 oracle 11g xe 이미지이다<br/>
자신의 Local PC에서 설치해서 사용할 목적이기 때문에 [furywolf/centoslocal](https://hub.docker.com/r/furywolf/centoslocal/) 이미지를 기준 이미지로 해서 만들어야 했지만<br/>
Oracle과 Listener의 시작/종료/재시작을 Systemd를 이용하기 위해 Naming은 centoslocal로 했지만 기준 이미지는 운영서버 이미지인 [furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/)를 사용해서 제작했다

[furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/) 이미지를 기준 이미지로 했기 때문에 이 이미지가 가지고 있는 특성을 그대로 갖고 있다(root 계정 패스워드, SSH 접속, Oracle Java 설치 등)

Oracle과 Listener의 시작/종료/재시작을 Systemd를 이용해서 하고 있기 때문에 systemctl 명령을 이용해서 할 수 있다.

* Oracle 서비스 시작(ex : systemctl start oracle.service)
* Oracle 서비스 종료(ex : systemctl stop oracle.service)
* Oracle 서비스 재시작(ex : systemctl restart oracle.service)
* Oracle 서비스 현재 상태 확인(ex: systemctl status oracle.service)


* Listener 서비스 시작(ex : systemctl start lsnrctl.service)
* Listener 서비스 종료(ex : systemctl stop lsnrctl.service)
* Listener 서비스 재시작(ex : systemctl restart lsnrctl.service)
* Listener 서비스 현재 상태 확인(ex: systemctl status lsnrctl.service)

SSH 접속으로 인해 root 계정에 비밀번호를 설정해놓았다(비밀번호는 admin)

설치되어 있는 Oracle XE의 SID는 XE로 되어 있고 system 계정과 sys 계정의 비밀번호는 oracle로 지정되어 있다

Oracle의 기본 통신 포트인 1521 포트와 Oracle APEX(Application Express)를 이용해 Oracle XE를 관리할 경우를 위해 8080 포트를 열어두었다

Oracle의 Tablespace를 외부 장치에 저장하기 위한 용도로 이미지 내부에 /mnt/shared/tablespaces 디렉토리를 만든뒤에 이를 VOLUME으로 등록해두었다. 이렇게 하면 tablespace 파일이 외부 장치에 저장이 되기 때문에 차후에 tablespace 파일을 재사용 할 수 있다

이 이미지를 실행할때는 다음과 같이 실행하면 된다

docker run -d --name oracle-xe --cap-add=SYS\_ADMIN -p 21:21 -p 22:22 -p 1521:1521 -p 8080:8080 -p 64000-64010:64000-64010 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v d:/docker/volumes/oracle/tablespaces:/mnt/shared/tablespaces:rw furywolf/centoslocal\_oracle-xe

윈도우에서 실행하는 예제이기 때문에 이미지의 VOLUME으로 등록된 /mnt/shared/tablespaces 디렉토리를 d:/docker/volumes/oracle/tablespaces 로 연결한 것이다. 자신의 환경에 맞게 설정하면 된다

이 이미지 또한 [furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/)에서 설명했듯이 **반드시 -d 옵션을 붙여서 이미지가 background로 실행**이 되게끔 해야 한다

1521 포트 대신 다른 포트로 바꾸고자 할때에는 -p 1521:1521에서 앞의 1521을 원하는 포트로 바꾸면 된다(ex : -p 3009:1521)<br/>
8080 포트 대신 다른 포트로 바꾸고자 할때에는 -p 8080:8080에서 앞의 8080를 원하는 포트로 바꾸면 된다(ex : -p 18080:8080)<br/>

[Github](https://github.com/TerryChang/mydocker/tree/master/centoslocal_oracle-xe)에 이 이미지를 실행하기 위한 docker-compose.yml 파일이 있으니 참고하길 바란다