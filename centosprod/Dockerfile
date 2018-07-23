#centos 기반으로 만든 운영용으로 실행되는 이미지의 베이스 이미지
#실제 운영에서 사용될 이미지이므로 ssh 와 vsftpd가 설치된다
#Systemd 기반의 서비스 관리를 할 것이므로 기본 centos/sydtemd 이미지를 상속받아 베이스 이미지를 만든다
#적용된 내용은
#1. locale 한국어 설정
#2. timezone 한국 설정
#3. Java 설치
#4. Maven 설치(Local Repository는 /opt/maven/repository 로 설정된다)
#5. SSH 서비스 설정
#6. FTP 서버를 운영하기 위한 vsftpd 설정

FROM centos/systemd

MAINTAINER Terry Chang <furywolf@hanmail.net>

RUN yum clean all && \
yum update -y && \ 
yum install -y sudo && \
yum install -y net-tools && \
yum install -y vim && \
yum install -y openssl && \
yum install -y vsftpd && \
yum install -y wget && \
yum install -y openssh-server openssh-clients && \
yum install -y java-1.8.0-openjdk-devel.x86_64 && \
yum reinstall -y glibc-common && \
yum clean all && \
systemctl enable sshd.service && \
systemctl enable vsftpd.service

#oracle java 설치 관련 환경변수 설정
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

#SSH Service 설정(https://github.com/sickp/docker-centos-sshd/blob/master/versions/7/Dockerfile 참조)
#root 계정의 암호를 이 시점에서 설정한다(root / admin 으로 설정)
RUN echo 'root:admin' | chpasswd && \
ssh-keygen -A

#vsftpd 설정
#vsftpd.conf 파일을 /etc/vsftpd 디렉토리에 복사한다
COPY resources/vsftpd.conf /etc/vsftpd/
#vsftpd.pem 파일을 /etc/vsftpd 디렉토리에 복사한다
COPY resources/vsftpd.pem /etc/vsftpd/

#SSH 포트 22번 열기
EXPOSE 21 22 64000-64010

# 부팅하면서 실행해야 할 명령들이 있는 init.sh를 이미지에 넣어둔뒤 실행을 한다
# init.sh 에서 SSH 서비스 데몬을 기동하게 되며 추가로 부팅하면서 실행해야 할 명령들이 있을 경우 init.sh에 해당 명령을 넣어둔다
ADD resources/init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh
CMD ["/usr/local/bin/init.sh"]