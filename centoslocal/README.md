furywolf/centoslocal
====================

CentOS를 기반으로 한 Local 개발용 이미지들의 부모 이미지로 2017년 11월 9일 기준으로 CentOS 7을 기반으로 하고 있다.

기존의 CentOS 7 공식 이미지에 다음의 추가 작업이 진행되어 있다.
1. 로케일을 한국어(ko_KR.utf8)로 설정(java를 실행하면 도움말이 한글로 나오는 것을 확인할 수 있다)
2. TimeZone을 Asia/Seoul로 설정
3. Oracle Java 설치
4. Maven 설치
5. HOST OS와의 공유를 위해 /mnt/shared 디렉토리를 VOLUME으로 등록
6. Telnet 접속을 위해 23번 포트 열림(그러나 실제로는 동작하지 않는다. SSH를 통한 접속을 원하는 사람은 furywolf/centosprod 이미지를 사용하기 바란다)

이 이미지를 실행할때는 다음과 같이 실행하면 된다

docker run -it --name centoslocal -p 23:23  -v d:/docker/volumes/centos:/mnt/shared:rw furywolf/centoslocal

윈도우에서 실행하는 예제이기 때문에 이미지의 VOLUME으로 등록된 /mnt/shared 디렉토리를 d:/docker/volumes/centos 로 연결한 것이다. 자신의 환경에 맞게 설정하면 된다

[Github](https://github.com/TerryChang/mydocker/tree/master/centoslocal)에 이 이미지를 실행하기 위한 docker-compose.yml 파일이 있으니 참고하길 바란다