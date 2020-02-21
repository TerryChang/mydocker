# openjdk:8-alpine 기반으로 Spring Boot Application이 실행되는 이미지의 베이스 이미지
# 시간대를 서울로 하기 위해 tzdata 를 추가했다
# properties 파일들의 문서편집 상황이 있을 수 있기 때문에 vim 에디터만 추가로 설치한다
# utf8 사용을 위해 LANG 환경변수 선언
# /tmp 디렉토리를 공유할수 있도록 설정

FROM furywolf/springboot_base

MAINTAINER Terry Chang <furywolf@hanmail.net>

ADD kubernetes-sample.jar /

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "/kubernetes-sample.jar" ]