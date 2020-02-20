# spring boot app을 실행시키는데 사용되는 Docker Image
# base image는 가볍고 java만 설치되어 있으면 되기 때문에
# openjdk가 설치된 alpine linux인 openjdk:8-alpine을 사용했다(open jdk 8을 사용)
# 여기에 추가적으로 시간대를 서울로 설정하고 utf-8을 사용하기 위한 환경 설정 및 문서편집을 사용하기 위한 vim 설치를 진행했다
# 이 이미지와 host가 공유해야 할 상황이 존재할 경우를 대비해 /share_host 디렉토리를 공유대상으로 설정했다

FROM openjdk:8-alpine

MAINTAINER Terry Chang <furywolf@hanmail.net>

RUN apk update && \
apk upgrade && \
apk add tzdata && \
cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
apk del tzdata && \
apk add --no-cache vim && \
mkdir -p /share_host
ENV LANG ko_KR.utf8
VOLUME ["/share_host"]

CMD ["/bin/ash"]