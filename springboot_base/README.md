furywolf/springboot_base
====================

Spring Boot App을 실행시키기 위해 사용되는 이미지로 OpenJDK 8 이 설치되어 있는 alpine linux 기반의 이미지를 기반으로 해서 제작했다 

이 이미지에 다음의 추가 작업이 진행되어 있다

1. 시간대를 서울로 하기 위해 tzdata 설치
2. vim 에디터 설치
3. utf8 사용을 위한 LANG 변수 선언
4. /share_host 디렉토리를 만든뒤 이 디렉토리를 공유 디렉토리로 설정

이 이미지를 실행할때는 다음과 같이 실행하면 된다

docker run --name springboot_base -it -v d:/docker/volumes/share:/share_host:rw furywolf/springboot_base:8

윈도우에서 실행하는 예제이기 때문에 이미지의 VOLUME으로 등록된 /share_host 디렉토리를 d:/docker/volumes/share 로 연결한 것이다. 자신의 환경에 맞게 설정하면 된다

[Github](https://github.com/TerryChang/mydocker/tree/master/centoslocal)에 이 이미지를 실행하기 위한 docker-compose.yml 파일이 있으니 참고하길 바란다 