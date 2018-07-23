furywolf/centolocal_wildfly
====================

[furywolf/centoslocal](https://hub.docker.com/r/furywolf/centoslocal/)를 기준 이미지로 해서 만든 Wildfly 10.1.0.Final 이미지이다  
Local PC에 Eclipse를 설치하고 이 이미지로 실행된 컨테이너와의 연동을 목적으로 만든 것이기 때문에 Wildfly가 foregorund로 실행이 되면서 로그 내용이 콘솔 화면에 직접 보이게 된다  
Eclipse에 Docker 관련 플러그인(JBoss Tools 플러그인에 Docker 플러그인이 있다)을 설치한뒤 해당 이미지를 실행하면 Eclipse 콘솔화면에서 Wildfly 컨테이너의 로그 내용을 볼 수 있다

Eclipse 연동과 관련해서는 다음의 게시물을 참조하면 된다

[Docker and WildFly Part 1 - Deployment via Docker volumes](http://tools.jboss.org/blog/2015-03-02-getting-started-with-docker-and-wildfly.html)  
[Docker and WildFly Part 2 - Deployment over management API](http://tools.jboss.org/blog/2015-03-03-docker-and-wildfly-2.html)

Oracle JDBC 드라이버가 Wildfly에 등록되어 있는 상태이기 때문에 Oracle JDBC 드라이버를 별도로 등록해주지 않아도 바로 Oracle DataSource를 만들어 사용할 수 있다

Wildfly의 관리자 계정을 등록해놨기 때문에 Wildfly의 관리자 페이지를 접속해서 관리자 기능을 사용할 수 있다  
관리자 계정은 id는 admin, 패스워드는 admin 이다

/opt/jboss/wildfly/standalone/deployments를 VOLUME으로 등록해서 HOST OS와 공유가 되도록 설정함으로써 Eclipse Project가 이 디렉토리로 deploy 되는 개념으로 연동을 하게끔 한다(Eclipse 연동 관련 게시물 중 첫번째 링크 게시물이 이 디렉토리를 사용한다)

일반적으로 사용되는 8080 포트, 관리자 페이지 접근용 포트인 9990, 디버깅 용도 포트인 8787번 포트가 열려있다

위에서 언급했다시피 Eclipse 연동을 전제로 해서 만든 이미지이므로 디버그 기능이 켜진 상태로 Wildfly가 구동된다. Eclipse에서 Remote Java Application 으로 디버깅을 할 수 있다. 이때 포트번호를 8787번을 주면 된다

이 이미지를 실행할때는 다음과 같이 실행하면 된다

docker run -d --name wildfly -p 8080:8080 -p 8787:8787 -p 9990:9990 -v d:/docker/volumes/wildfly/standalone/deployments:/opt/jboss/wildfly/standalone/deployments:rw furywolf/centoslocal\_wildfly

윈도우에서 실행하는 예제이기 때문에 이미지의 VOLUME으로 등록된 /opt/jboss/wildfly/standalone/deployments 디렉토리를 d:/docker/volumes/wildfly/standalone/deployments 로 연결한 것이다. 자신의 환경에 맞게 설정하면 된다

9990 포트 대신 다른 포트로 바꾸고자 할때에는 -p 9990:9990에서 앞의 9990을 원하는 포트로 바꾸면 된다(ex : -p 19990:9990)  
8080 포트 대신 다른 포트로 바꾸고자 할때에는 -p 8080:8080에서 앞의 8080를 원하는 포트로 바꾸면 된다(ex : -p 18080:8080)  
기타 다른 포트도 마찬가지 방법으로 바꾸면 된다

[Github](https://github.com/TerryChang/mydocker/tree/master/centoslocal_wildfly)에 이 이미지를 실행하기 위한 docker-compose.yml 파일이 있으니 참고하길 바란다

변경사항

* 2018-07-23
    1. Wildfly 버전 업그레이드(10.1.0.Final -> 13.0.0.Final)