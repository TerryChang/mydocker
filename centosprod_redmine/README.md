furywolf/centosprod_redmine
====================

[furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/)를 기준 이미지로 해서 만든 redmine 이미지이다  

[furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/) 이미지를 기준 이미지로 했기 때문에 이 이미지가 가지고 있는 특성을 그대로 갖고 있다(root 계정 패스워드, SSH 접속, Oracle Java 설치 등)

이 redmine 이미지는 apache httpd와 mariadb 10.3을 기반으로 구성되어 있다.
이미지 안에 mariadb가 설치되어 있기 때문에 별도의 db 연동 없이 이 이미지를 컨테이너로 띄우면 바로 사용할 수 있다.
포트는 80 포트를 사용하고 있다.

이 이미지를 실행할때는 다음과 같이 실행하면 된다

docker run -d --name redmine --cap-add=SYS\_ADMIN  -p 80:80 -p 64000-64010:64000-64010 -v /sys/fs/cgroup:/sys/fs/cgroup:ro furywolf/redmine

이 이미지 또한 [furywolf/centosprod](https://hub.docker.com/r/furywolf/centosprod/)에서 설명했듯이 **반드시 -d 옵션을 붙여서 이미지가 background로 실행**이 되게끔 해야 한다

80 포트 대신 다른 포트로 바꾸고자 할때에는 -p 80:80에서 앞의 80를 원하는 포트로 바꾸면 된다(ex : -p 18080:8080)  

[Github](https://github.com/TerryChang/mydocker/tree/master/centosprod_redmine)에 이 이미지를 실행하기 위한 docker-compose.yml 파일이 있으니 참고하길 바란다