#centos 기반으로 만든 로칼 개발용으로 실행되는 이미지의 베이스 이미지
#로칼에서 개발용으로 실행되는 이미지이므로 ssh 와 vsftpd가 설치되지 않으며
#Systemd 기반의 서비스 관리를 할 것이 아니므로 기본 centos 이미지를 상속받아 베이스 이미지를 만든다
#적용된 내용은
#1. locale 한국어 설정
#2. timezone 한국 설정
#3. Java 설치

FROM centos

MAINTAINER Terry Chang <furywolf@hanmail.net>

RUN yum clean all && \
yum update -y && \ 
yum install -y sudo && \
yum install -y net-tools && \
yum install -y vim && \
yum install -y wget && \
yum clean all

#oracle java 설치 관련 환경변수 설정
ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=151 \
    JAVA_VERSION_BUILD=12 \
    JAVA_URL_HASH=e758a0de34e24606bca991d704f6dcbf \
	JAVA_HOME=/opt/java

	
#oracle java 설치(CoreOS를 이용해서 빌드할 경우)
# 주의 사항 : 최신 버전으로 올라온게 아닌 이전 버전으로 올라왔을 경우엔 부가적으로 로그인을 물어보기 때문에 정상적인 다운로드가 이루어지지 않는다
#             최신 버전 위주로 다운로드 링크를 확인해서 맞춰주도록 한다
#             tar를 이용해서 압축을 풀 경우 풀어지는 파일 리스트가 화면에 보여지기 때문에 작업상 불편할 수 있는데
#             이럴 경우 tar -xvf를 이용해서 압축을 풀지말고 tar -xf를 이용해서 압축을 푼다
#RUN curl -L -b "oraclelicense=a" http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_URL_HASH}/jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz -O && \
#tar -xvf jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz && \
#rm jdk*.tar.gz && \
#mv jdk* ${JAVA_HOME}	
	
#oracle java 설치(Docker for Windows로 빌드할 경우)
# 주의 사항 : Docker for Windows로 빌드할 경우 curl을 이용한 파일 다운로드가 정상적으로 동작하지를 않아서
#             미리 jdk-8u151-linux-x64.tar.gz을 받은뒤에
#             이를 다시 분할압축(github의 경우 파일 업로드시 파일 1개의 크기가 100메가를 넘어서는 안되는 제한이 있다.이때문에 분할압축을 했다)한 후
#             이러한 분할압축 파일로 java를 설치했다
#             (resources 디렉토리 밑에 jdk-8u151.tar.gzaa, jdk-8u151.tar.gzab, jdk-8u151.tar.gzac, jdk-8u151.tar.gzad 이렇게 있다)
#             tar를 이용해서 압축을 풀 경우 풀어지는 파일 리스트가 화면에 보여지기 때문에 작업상 불편할 수 있는데
#             이럴 경우 tar -xvf를 이용해서 압축을 풀지말고 tar -xf를 이용해서 압축을 푼다
# RUN tar -xf /tmp/jdk-8u151-linux-x64.tar.gz -C /tmp && \
COPY resources/jdk-8u151.tar.gz* /tmp/
RUN cat /tmp/jdk-8u151.tar.gz* > /tmp/jdk-8u151.tar.gz && \
tar -xf /tmp/jdk-8u151.tar.gz -C /tmp && \
rm /tmp/jdk-8u151.tar.gz* && \
mv /tmp/jdk* ${JAVA_HOME}

#locale 설정(https://hub.docker.com/r/gmchoi/centos/~/dockerfile/ 와 https://github.com/dunkelfrosch/docker-centos7-wb/blob/master/df-wb-centos-7/Dockerfile 참조)
RUN echo "Locale setting" && \
localedef -c -i ko_KR -f UTF-8 ko_KR.utf8 && \
echo -e "LANG=ko_KR.utf8\nLC_ALL=\nJAVA_HOME=/opt/java" > /etc/environment
# ENV LANG ko_KR.utf8

#timezone 설정
RUN echo "Change TimeZone to Asia/Seoul" && \
rm /etc/localtime && \
ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime

#path 설정(/etc/profile.d 디렉토리에 echo 명령을 이용해서 원하는 PATH가 추가된 path.sh 파일이 생성되도록 한다. 이렇게 하면 부팅시 path.sh를 거쳐서 PATH를 재정의한뒤 각 계정에 있는 .bash_profile 에서 정의된 PATH 재정의를 사용하게 된다)
RUN echo -e "export PATH=$PATH:$JAVA_HOME/bin" > /etc/profile.d/path.sh

#Host OS와 공유할 디렉토리를 만든다
RUN mkdir /mnt/shared

# 공유할 디렉토리가 밖으로 연결이 되도록 설정한다
VOLUME ["/mnt/shared"]

#Telnet 포트 23번 열기
EXPOSE 23

CMD ["/bin/bash"]