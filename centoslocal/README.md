furywolf/centoslocal
====================

CentOS를 기반으로 한 Local 개발용 이미지들의 부모 이미지로 2017년 11월 9일 기준으로 CentOS 7을 기반으로 하고 있다.

기존의 CentOS 7 공식 이미지에 다음의 추가 작업이 진행되어 있다.
1. Oracle Java 설치
2. 로케일을 한국어(ko_KR.utf8)로 설정(java -help를 실행하면 도움말이 한글로 나오는 것을 확인할 수 있다)
3. TimeZone을 Asia/Seoul로 설정
4. HOST OS와의 공유를 위해 /mnt/shared 디렉토리를 VOLUME으로 등록
5. Telnet 접속을 위해 23번 포트 열림