furywolf/centosprod
====================

CentOS를 기반으로 한 운영서버 이미지들의 부모 이미지로 2017년 11월 9일 기준으로 CentOS 7을 기반으로 하고 있다.

기존의 CentOS 7 공식 이미지에 다음의 추가 작업이 진행되어 있다.

1. 로케일을 한국어(ko_KR.utf8)로 설정(java를 실행하면 도움말이 한글로 나오는 것을 확인할 수 있다)
2. TimeZone을 Asia/Seoul로 설정
3. Oracle Java 설치
4. Maven 설치
5. HOST OS와의 공유를 위해 /mnt/shared 디렉토리를 VOLUME으로 등록
6. Systemd를 기반으로 한 서비스 관리 적용
7. SSH 접속을 위한 OpenSSH 설치(22번 포트 열려있음)
8. FTP 접속을 위한 VSFTP 설치(21번 포트와 64000번부터 64010번 포트까지 열려있음)

Systemd를 기반으로 서비스를 관리하기 때문에 systemctl 명령어를 이용한 서비스 시작, 종료, 재시작, 현재 상태 확인 기능이 가능하다  
VSFTP를 예로 들어 설명하면 다음과 같이 사용할 수 있다

* 서비스 시작(ex : systemctl start vsftpd.service)
* 서비스 종료(ex : systemctl stop vsftpd.service)
* 서비스 재시작(ex : systemctl restart vsftpd.service)
* 현재 상태 확인(ex: systemctl status vsftpd.service)

SSH 접속으로 인해 root 계정에 비밀번호를 설정해놓았다(비밀번호는 admin)

이 이미지를 실행할때는 다음과 같이 실행하면 된다

docker run -d --name centosprod --cap-add=SYS_ADMIN -p 21:21 -p 22:22 -p 64000-64010:64000-64010 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v d:/docker/volumes/centos:/mnt/shared:rw furywolf/centosprod

윈도우에서 실행하는 예제이기 때문에 이미지의 VOLUME으로 등록된 /mnt/shared 디렉토리를 d:/docker/volumes/centos 로 연결한 것이다. 자신의 환경에 맞게 설정하면 된다

이때 주의해야 할 것은 **반드시 -d 옵션을 붙여서 이미지가 background로 실행이 되게끔 해야 하는 것**이다. -d 대신 -it를 붙여서 foreground로 실행시켜도 되지만 그럴 경우 exit를 입력해서 docker 이미지에서 빠져나오는 작업을 하지못한다  
그래서 -d 옵션을 붙여서 이미지가 background로 실행되게 한 뒤에 putty 같은 ssh 클라이언트를 통해 해당 이미지를 접속하면 된다. 자신의 컴퓨터에서 이미지를 실행하고 있다면 putty에서 주소는 localhost, 포트는 22로 설정한 뒤 SSH로 지정해서 접속하면 된다  

FTP 접속 포트를 바꾸고자 할때에는 -p 21:21에서 앞의 21을 원하는 포트로 바꾸면 된다(ex : -p 2121:21)  
SSH 접속 포트를 바꾸고자 할때에는 -p 22:22에서 앞의 22를 원하는 포트로 바꾸면 된다(ex : -p 2222:22)  
SSH를 이용한 FTP 접속도 가능한데 이때는 FTP 접속 포트를 SSH 접속하면 된다  

[Github](https://github.com/TerryChang/mydocker/tree/master/centosprod)에 이 이미지를 실행하기 위한 docker-compose.yml 파일이 있으니 참고하길 바란다