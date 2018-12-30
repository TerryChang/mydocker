#!/bin/bash

MYSQL_ROOT_PASSWORD="root"

SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"\\r\"

expect \"Set root password?\"
send \"\\r\"

expect \"New password:\"
send \"$MYSQL_ROOT_PASSWORD\\r\"

expect \"Re-enter new password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"

expect \"Remove anonymous users?\"
send \"\\r\"

expect \"Disallow root login remotely?\"
send \"\\r\"

expect \"Remove test database and access to it?\"
send \"\\r\"

expect \"Reload privilege tables now?\"
send \"\\r\"
expect eof
")

echo "$SECURE_MYSQL"