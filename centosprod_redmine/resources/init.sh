#!/bin/bash

# 추가로 실행시켜야 할 스크립트가 있을 경우 exec /usr/sbin/init 실행하기 전에 실행이 되도록 스크립트를 작성한다
exec /usr/sbin/init
# /resources/mariadb_secure_init.sh
# mysql -u root -p root < /resources/redmine_database.sql