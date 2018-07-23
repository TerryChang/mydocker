#centos 기반으로 만든 로칼 개발용으로 실행되는 이미지의 베이스 이미지
#로칼에서 개발용으로 실행되는 이미지이므로 ssh 와 vsftpd가 설치되지 않으며
#Systemd 기반의 서비스 관리를 할 것이 아니므로 기본 centos 이미지를 상속받아 베이스 이미지를 만든다
#적용된 내용은
#1. locale 한국어 설정
#2. timezone 한국 설정
#3. Java 설치
#4. Maven 설치(Local Repository는 /opt/maven/repository 로 설정된다)

FROM centos

MAINTAINER Terry Chang <furywolf@hanmail.net>

RUN yum clean all && \
yum update -y && \ 
yum install -y sudo && \
yum install -y net-tools && \
yum install -y vim && \
yum install -y wget && \
yum install -y java-1.8.0-openjdk-devel.x86_64 && \
yum clean all

#openjdk java 설치 관련 환경변수 설정
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.171-8.b10.el7_5.x86_64 \
	MAVEN_HOME=/opt/maven

#maven 설치
COPY resources/maven/apache-maven-3.5.2-bin.tar.gz /tmp/
RUN tar -xf /tmp/apache-maven-3.5.2-bin.tar.gz -C /tmp && \
rm /tmp/apache-maven*.tar.gz && \
mv /tmp/apache-maven* ${MAVEN_HOME} && \
mkdir -p ${MAVEN_HOME}/repository
COPY resources/maven/settings.xml ${MAVEN_HOME}/conf

# 설치한 maven(mvn)에 대해 soft link를 만들어둔다(로그인 기능이 없는 시스템 계정을 생성할 경우 maven 명령을 사용하기 위함이다)
RUN ln -s /opt/maven/bin/mvn /usr/bin/mvn

#locale 설정
RUN localedef -c -i ko_KR -f UTF-8 ko_KR.utf8

#timezone 설정
RUN rm /etc/localtime && \
ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime

#환경변수를 설정하는 environment.sh 파일을 넣어둔다(여기서 PATH를 설정한다)
COPY resources/environment.sh /etc/profile.d/
RUN chmod +x /etc/profile.d/environment.sh

#Host OS와 공유할 디렉토리를 만든다
RUN mkdir /mnt/shared

# 공유할 디렉토리가 밖으로 연결이 되도록 설정한다
VOLUME ["/mnt/shared"]

#Telnet 포트 23번 열기
EXPOSE 23

CMD ["/bin/bash"]