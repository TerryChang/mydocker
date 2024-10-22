furywolf/centosprod_wildfly
====================

[furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/)를 기준 이미지로 해서 만든 Wildfly 10.1.0.Final 이미지이다  
[furywolf/centoslocal_wildfly](https://hub.docker.com/r/furywolf/centoslocal_wildfly/)와는 달리 운영서버에서 실행되는 전제로 만든 이미지이기 때문에 Systemd를 이용한 wildfly 서비스 관리가 이루어지도록 했으며
이로 인해 wildfly가 background로 실행되게 된다

[furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/) 이미지를 기준 이미지로 했기 때문에 이 이미지가 가지고 있는 특성을 그대로 갖고 있다(root 계정 패스워드, SSH 접속, Oracle Java 설치 등)

Web Application 배포와 관련되어서는 관리자 페이지를 이용하서나 직접 FTP로 접속해서 올리면 된다

Wildfly의 시작/종료/재시작을 Systemd를 이용해서 하고 있기 때문에 systemctl 명령을 이용해서 할 수 있다.

* Wildfly 서비스 시작(ex : systemctl start wildfly.service)
* Wildfly 서비스 종료(ex : systemctl stop wildfly.service)
* Wildfly 서비스 재시작(ex : systemctl restart wildfly.service)
* Wildlfy 서비스 현재 상태 확인(ex: systemctl status wildfly.service)

Oracle JDBC 드라이버가 Wildfly에 등록되어 있는 상태이기 때문에 Oracle JDBC 드라이버를 별도로 등록해주지 않아도 바로 Oracle DataSource를 만들어 사용할 수 있다

Wildfly의 관리자 계정을 등록해놨기 때문에 Wildfly의 관리자 페이지를 접속해서 관리자 기능을 사용할 수 있다  
관리자 계정은 id는 admin, 패스워드는 admin 이다

일반적으로 사용되는 8080 포트, 관리자 페이지 접근용 포트인 9990 포트가 열려있다

위에서 언급했다시피 운영서버에서 실행되는 이미지이므로 디버그 기능은 꺼져있는 상태로 Wildfly가 구동된다. 그러나 디버그 포트인 8787번 포트는 열려있기 때문에 디버그 기능을 구동시킬 경우 systemctl stop wildfly.service를 실행시켜 Wildfly 서비스를 중지시킨뒤에 wildfly를 systemctl이 아닌 수동으로 shell script를 별도로 만들어서 실행시키면 된다(/opt/jboss/wildfly/bin/standalone.sh -c standalone.xml -b 0.0.0.0 -bmanagement 0.0.0.0 --debug)

이 이미지를 실행할때는 다음과 같이 실행하면 된다

docker run -d --name wildfly --cap-add=SYS\_ADMIN -p 21:21 -p 22:22 -p 8080:8080 -p 8787:8787 -p 9990:9990 -v /sys/fs/cgroup:/sys/fs/cgroup:ro furywolf/centosprod\_wildfly

이 이미지 또한 [furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/)에서 설명했듯이 **반드시 -d 옵션을 붙여서 이미지가 background로 실행**이 되게끔 해야 한다

9990 포트 대신 다른 포트로 바꾸고자 할때에는 -p 9990:9990에서 앞의 9990을 원하는 포트로 바꾸면 된다(ex : -p 19990:9990)  
8080 포트 대신 다른 포트로 바꾸고자 할때에는 -p 8080:8080에서 앞의 8080를 원하는 포트로 바꾸면 된다(ex : -p 18080:8080)  
기타 다른 포트도 마찬가지 방법으로 바꾸면 된다

[Github](https://github.com/TerryChang/mydocker/tree/master/centosprod_wildfly)에 이 이미지를 실행하기 위한 docker-compose.yml 파일이 있으니 참고하길 바란다

변경사항

* 2018-07-23
    1. Wildfly 버전 업그레이드(10.1.0.Final -> 13.0.0.Final)

