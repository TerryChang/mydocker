#!/bin/bash

# Prepare to install Oracle
yum install -y initscripts libaio1 libaio net-tools bc &&

# do some stuff
mv /assets/chkconfig /sbin/chkconfig &&
chmod 755 /sbin/chkconfig &&

# oracle install시에 swap space가 2기가가 필요하다는 경고를 보내면서 install을 실패하기 때문에 이것을 피하기 위해 현재 2기가가 있다는 식으로 속이는 작업을 진행한다
# swap space에 대한 정보가 /usr/bin/free에 있기 때문에 이것을 /usr/bin/free.bak으로 백업을 한 뒤에
# free 파일에 Swap 2048로 설정함으로써 swap space를 2기가로 설정해서 install이 진행이 되도록 한다
mv /usr/bin/free /usr/bin/free.bak &&
printf "#!/bin/sh\necho Swap - - 2048" > /usr/bin/free &&
chmod +x /usr/bin/free &&

# oracle install 파일 분할 압축을 풀어낸다
cat /assets/oracle-xe-11g.tar.gz* | tar xfz - -C /assets &&

# Install Oracle
rpm -ivh /assets/oracle-xe-11.2.0-1.0.x86_64.rpm &&

# oracle install 작업을 마친뒤에 swap sapce 관련 작업때문에 backup 해 두었던 /usr/bin/free.bak 파일을 /usr/bin/free로 덮어씌운다 
mv /usr/bin/free.bak /usr/bin/free &&

# Backup listener.ora as template
cp /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora.tmpl &&
cp /u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora /u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora.tmpl &&

mv /assets/init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts &&
mv /assets/initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts &&

# oracle-xe configure를 실행하면 총 5개의 질문에 대한 답을 해야 한다
# 1. Oracle Application Express가 사용할 http 포트번호(defualt가 8080이다)
# 2. Database Listener가 사용할 http 포트번호(default가 1521이다)
# 3. sys와 system 계정에서 사용할 비밀번호
# 4. 3번 질문이 비밀번호를 물어보는 것이기 때문에 이를 확인(confirm)하기 위해 3번에서 입력한 비밀번호를 다시 물어보는 질문
# 5. Boot 시에 Oracle을 자동으로 시작하게 할지에 대한 질문
# 이를 입력하기 위해 아래의 내용이 들어가게 된다 그리고 엔터키를 의미하게끔 하려고 \n이 들어가는데 \를 escape 문자로 하기 위해 \\게 함으로써 \\n이 되는 것이다
printf 8080\\n1521\\noracle\\noracle\\nn\\n | /etc/init.d/oracle-xe configure &&

rm -Rf /var/tmp/.oracle && 

# Remove installation files
rm -r /assets/

exit $?
