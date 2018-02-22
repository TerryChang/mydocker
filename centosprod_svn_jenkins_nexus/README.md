furywolf/centosprod_svn_jenkins_nexus
====================

[furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/)를 기준 이미지로 해서 Subversion, Jenkins, Nexus가  
설치되어 있는 이미지이다  
운영서버에서 실행되는 전제로 만든 이미지이기 때문에 Systemd를 이용하여 Subversion, Jenkins, Nexus가 서비스 관리가 이루어지도록 했으며
이로 인해 각 프로그램이 모두 background로 실행되게 된다

[furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/) 이미지를 기준 이미지로 했기 때문에 이 이미지가 가지고 있는 특성을 그대로 갖고 있다(root 계정 패스워드, SSH 접속, Oracle Java 설치 등)

버전정보는 다음과 같다

* Subversion : 1.7.14
* Jenkins : 2.89.4
* Nexus : 2.14.6-02

Subversion, Jenkins, Nexus의 시작/종료/재시작을 Systemd를 이용해서 하고 있기 때문에 systemctl 명령을 이용해서 할 수 있다.

* Subversion 서비스 시작(ex : systemctl start svnserve.service)
* Subversion 서비스 종료(ex : systemctl stop svnserve.service)
* Subversion 서비스 재시작(ex : systemctl restart svnserve.service)
* Subversion 서비스 현재 상태 확인(ex: systemctl status svnserve.service)
* Jenkins 서비스 시작(ex : systemctl start jenkins.service)
* Jenkins 서비스 종료(ex : systemctl stop jenkins.service)
* Jenkins 서비스 재시작(ex : systemctl restart jenkins.service)
* Jenkins 서비스 현재 상태 확인(ex: systemctl status jenkins.service)
* Nexus 서비스 시작(ex : systemctl start nexus.service)
* Nexus 서비스 종료(ex : systemctl stop nexus.service)
* Nexus 서비스 재시작(ex : systemctl restart nexus.service)
* Nexus 서비스 현재 상태 확인(ex: systemctl status nexus.service)

Jenkins를 운영할 때 JDK와 Maven을 설정해야 하는데 이때 사용해야 할 JAVA_HOME과 MAVEN_HOME은 다음과 같이 설정한다

JAVA_HOME : /opt/java
MAVEN_HOME : /opt/maven

Jenkins는 웹브라우저에서 처음 실행시키는 과정에서 관리자 계정을 만들기 때문에 관리자 계정을 사전에 알아야 할 필요가 없지만 Nexus의 
경우는 관리자 계정이 이미 만들어져 있어서 이 관리자 계정을 알고 있어야 한다. Nexus의 기존 관리자 계정은 admin / admin123 이다 

Subversion은 3690 포트, Jenkins는 8080 포트, Nexus는 8081 포트를 사용하며 해당 이미지에는 공유 목적의 디렉토리로 /mnt/shared/svn
, /mnt/shared/jenkins, /mnt/shared/nexus 가 있다. 그래서 이 이미지를 실행할때는 다음과 같이 실행하면 된다

docker run -d --name svn_jenkins_nexus --cap-add=SYS\_ADMIN -p 21:21 -p 22:22 -p 3690:3690 -p 8080:8080 -p 8081:8081 
-v /sys/fs/cgroup:/sys/fs/cgroup:ro -v d:/docker/volumes/centosprod_jenkins_svn/svn:/mnt/shared/svn:rw
-v d:/docker/volumes/centosprod_jenkins_svn/jenkins:/mnt/shared/jenkins:rw 
-v d:/docker/volumes/centosprod_jenkins_svn/nexus:/mnt/shared/nexus:rw furywolf/centosprod\_svn_jenkins_nexus

이 이미지 또한 [furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/)에서 설명했듯이 **반드시 -d 옵션을 붙여서 이미지가 background로 실행**이 되게끔 해야 한다

3690 포트 대신 다른 포트로 바꾸고자 할때에는 -p 3690:3690에서 앞의 3690을 원하는 포트로 바꾸면 된다(ex : -p 13690:3690)  
기타 다른 포트도 마찬가지 방법으로 바꾸면 된다

[Github](https://github.com/TerryChang/mydocker/tree/master/centosprod_wildfly)에 이 이미지를 실행하기 위한 docker-compose.yml 파일이 있으니 참고하길 바란다

